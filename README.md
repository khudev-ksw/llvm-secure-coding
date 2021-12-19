# Capstone Design 1 LLVM Project : LLVM-Pass로 Secure Coding Rule 준수 여부 검사
## Introduction
IoT device는 보안 기술 적용의 어려움으로 보안상 취약점이 많습니다. 이를 해결하기 위해 많은 방법들 개발되고 있으며, 그 중 본 연구에서는 Linux 환경에서 LLVM-Pass를 통해 Secure Coding Rule을 검사하는 기능을 구현해보았습니다. 궁극적으로는 ARM 등 Baremetal System에 LLVM을 적용하여 Secure Coding Rule을 준수하는 code verification tool 제작을 목표로 합니다.

## Related Works
- 정적분석, 퍼징, 기호실행 등 취약점 탐지 방법
- LLVM, LLVM IR, LLVM-Pass : https://llvm.org

## Implementation Flow
![기초조사서_구현방안_figure1](https://user-images.githubusercontent.com/41164017/139457573-a84ace85-7c58-4e4b-910e-d345ee615373.png)
- LLVM은 Front-end에 대응하는 언어로 작성된 source code를 LLVM-IR로 변환하고, Middle-end에서는 LLVM-IR을 Optimization 하며, 그 결과를 Back-end에서 처리하여 최종적인 Target Machine Code를 생성합니다. 이 과정 중 Middle-end Optimization에서 LLVM-Pass로 구현된 기능을 실행할 수 있고, 본 연구는 Optimization에서 Secure Coding Rule 준수 여부를 확인하여 결과를 알려줍니다.
- 본 연구에서는 C/C++에 대응되는 clang을 Front-end로 사용합니다.


## Implementation Goals
- 본 연구에서 구현할 Secure Coding Rule으로는 '메모리 버퍼 오버플로우', 'Null Pointer 역참조', 'Use-after-Free'를 선정했습니다.
- '메모리 버퍼 오버플로우', 'Null Pointer 역참조'는 LLVM-Pass와 관련하여 일반적인 구현방법이 비교적 알려져 있는 상태이므로 해당 방법을 참조하여 최대한 기능 구현에 집중했습니다. 참고한 사항은 아래와 같습니다.
  - https://github.com/monokles/llvm-nullptr
  - https://github.com/endvroy/buffer-overflow-detector
- 'Use-after-Free'의 경우 직접적인 샘플코드가 없어 기본적인 알고리즘을 참고로 직접구현을 시도하였습니다.

## Prerequisite
- 기능 구현과 실행에는 LLVM과 Clang이 필요합니다. LLVM 초기빌드는 빌드환경에 따라 매우 많은 시간을 필요로 할 수 있습니다.
- LLVM : https://llvm.org/docs/GettingStarted.html
- Clang : https://clang.llvm.org/get_started.html

## Basic Usages
- LLVM-Pass 작성 후 Pass 파일을 .so 파일로 만들기 위해서는, llvm이 build된 directory에서 make합니다.
```
cd /llvm-project/build
make
```
- 검사할 c code를 LLVM-IR(.ll)로 변환하는 것은 clang을 사용합니다.
```
clang -O0 -S –emit-llvm sample.c –o sample.ll
```
- .ll 파일을 pass를 통해 검증하는 것은 opt를 사용합니다.
```
opt –load /llvm-project/build/lib/[your-pass].so –[your-pass-command] sample.ll
```

## Core Implementation Description
### 1.메모리 버퍼 오버플로우 구현
- 잠재적으로 버퍼 오버플로우가 일어날 수 있는 값의 범위를 알려줍니다. 순서대로 context, 함수, 접근하는 line, 버퍼 사이즈, 접근 가능한 범위를 출력합니다.
- 테스트 하기 위한 코드와 출력결과는 다음과 같습니다.
```c
int main(int argc, char **argv) {
  unsigned buffer[4] = {0,0,0,0};
  return buffer[5];
}
```
```
, main, 5, 16, 20:20
```

### 2.Null Pointer 역참조 구현
- Null Pointer 역참조에서는 먼저 코드 상 모든 포인터 값을 추출해 벡터에 저장하여 저장된 값을 출력합니다.
- 그리고 저장된 값이 Null Pointer인지 검증하며, 맞다면 에러를 출력합니다. Pass의 core code와 출력결과는 다음과 같습니다.
```c++
virtual bool runOnFunction(Function &F){
  ptrValues.clear();
  errs() << "Considering function" << F.getName() << "!\n";
  extractPointerValues(F);
  dumpPtrValues();
  errs() << "\n ------------ STEP 2 \n";
  findBadPtrUsage();
  return false;
}
```
<img width="1089" alt="output" src="https://user-images.githubusercontent.com/41164017/146674717-42689fa7-dc50-4668-b073-3795379e447e.png">

### 3.Use-after-Free 구현
- Use-after-Free는 4단계로 나누었습니다. 이 중 3단계 일부까지 구현을 진행했습니다.
  - (1) free( ) 된 pointer를 포함하는 instruction의 추출
  - (2) call instruction 중 free, malloc이 아닌 실질적인 기능 instruction의 추출
  - (3) 기능 instruction의 operand 추출
  - (4) 기능 instruction이 사용하는 operand의 pointer 상태 확인
#### 3-1.free( ) 된 pointer를 포함하는 instruction의 추출
- call instruction 중 @free를 포함한 instruction을 추출합니다. 그리고 해당 instruction에서 실질적으로 free하는 pointer, 즉 @free의 실질적인 operand를 추출합니다. 이는 실제로 free가 된 pointer를 찾아서 추적하기 위함입니다.
- Pass의 core code와 출력결과는 다음과 같습니다.
```c++
if(isa<CallInst>(bbi))
{
  CallInst *tempi = cast<CallInst>(bbi);
  // bbi의 function이 free인지 확인
  StringRef callName = tempi->getCalledFunction()->getName();
  if(callName=="free")
  {
    errs() << "     Detected function :" << callName << "\n";
    errs() << "     Instruction value :" << *tempi << "\n";
    //free의 operand 추출
    for(Use &U :tempi->operands())
    {
      // free의 operand 중 free 함수가 아닌 실질적인 pointer 추출
      if((U.get())->getName()!="free")
      {
        Instruction* freeedOp = cast<Instruction>(U.get());
        errs() << "     free-ed operands :" << *(freeedOp) << "\n";
        Instruction* preorigin = cast<Instruction>(freeedOp->getOperand(0));
        errs() << "     pre-origin : " << *(preorigin) << "\n";
        Instruction* originPtr = cast<Instruction>(preorigin->getOperand(0));
        errs() << "     origin : " << *(originPtr) << "\n\n";
        freeedMap[originPtr] = true;
      }
    }
  }
}
```
<img width="638" alt="output1" src="https://user-images.githubusercontent.com/41164017/146674995-835aedc1-75e3-41e3-8e33-3e9cdb0ceaff.png">

#### 3-2.call instruction 중 free, malloc이 아닌 실질적인 기능 instruction의 추출
- (3-1)에서는 free된 pointer를 찾았다면 (3-2)에서는 실제로 이 pointer를 사용하는 기능 instruction을 찾아야 합니다. 기능 instruction을 찾아야 해당 instruction이 사용하는 pointer를 추적하고 그 pointer가 free되었는지 malloc 되었는지 확인할 수 있기 때문입니다.
- Pass의 core code와 출력결과는 다음과 같습니다.
```c++
if(isa<CallInst>(bbi))
{
  for(Use &U :bbi->operands())
  {
    // call insturction 중 free, malloc, 공백이 아닌 function 추출
    if(U.get()->getName()!="free" && U.get()->getName()!="malloc" && U.get()->getName()!="")
    {
      // 추출한 instruction은 향후 검증을 위해 변수에 저장
      userDefCallInsts.insert(&(*bbi));
    }
  }
}
```
<img width="597" alt="output2" src="https://user-images.githubusercontent.com/41164017/146675115-cf426305-a0ae-4ba3-9b9c-9b1905c3f5f2.png">

#### 3-3.기능 instruction의 operand 추출
- (3-3)에서는 (3-2)에서 추출한 instruction의 operand를 추적하여 사용자가 정의한 pointer를 사용하고 있는지 확인합니다. 이를 위해 우선 instruction의 모든 operand를 추출합니다.
- Pass의 core code와 출력결과는 다음과 같습니다.
```c++
for(BasicBlock::iterator bbi = bb->begin(), bbie = bb->end();bbi!=bbie;bbi++)
{
  errs() << *bbi << "\n";
  // bbi의모든 operand 추출
  for(Use &U :bbi->operands())
  {
    errs() << "   " << *(U.get()) << "\n";
  }
}
```
<img width="644" alt="output3" src="https://user-images.githubusercontent.com/41164017/146675187-21718fc0-fe81-43be-878d-c219682db69f.png">


## Conclusion
- LLVM이라는 새로운 환경에서 Secure Coding Rule을 구현하여 보안 취약점을 보완하는 기능을 구현해보았습니다. LLVM은 Well-Defined language이기에 보다 다양한 Back-end에 적용할 수 있고, 따라서 Baremetal 환경의 보안 취약점에 효과적으로 대응할 수 있다고 예상할 수 있습니다.
- 구현 중 'Use-after-Free'의 경우, 실질적인 operand 추출과 pointer 상태확인에 어려움을 겪어 끝까지 구현하지 못하였습니다.
- 향후 구현하지 못했던 기능을 보완하고 현재 Native Linux 환경에서 확장하여 ARM 기반의 Baremetal 환경에 적용하는 것을 목표로 합니다.

## Reference
- 강우석, 허기홍, "Infer를 이용한 보안 취약점 탐지용 정적 분석”,  한국정보과학회, 2021
- 김동준, 한선우, 신기성, 송미희, 조진성, "IoT 디바이스 취약점 분석”,  한국컴퓨터종합학술대회, 2019
- 박수현, 최종욱, "LLVM: 탑재소프트웨어 개발을 위한 차세대 컴파일러 기술", 항공우주산업기술동향
- Difference between Bare Metal vs. Embedded Linux : https://miscircuitos.com/difference-between-bare-metal-vs-embedded-linux
- 오크(ORK) – 난독화 컴파일러 도구 : https://engineering.linecorp.com/ko/blog/code-obfuscation-compiler-tool-ork-1
- 박우진, 조진성, "Baremetal 펌웨어 보안 강화 기법", 2020년 한국소프트웨어종합학술대회 논문집
- 박우진, 이한솔, 조진성, "LLVM 기반의 BareMetal IoT 디바이스 펌웨어 난독화", 2020년 한국컴퓨터종합학술대회 논문집
- 행정안전부, 한국인터넷진흥원, "전자정부 SW 개발·운영자를 위한 소프트웨어 개발보안 가이드"
- “LLVM Documentation”, https://llvm.org/doxygen/index.html
- "llvm-nullptr", https://github.com/monokles/llvm-nullptr
- "buffer-overflow-detector", https://github.com/endvroy/buffer-overflow-detector


