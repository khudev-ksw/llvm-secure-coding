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
- LLVM-Pass 작성 후 Pass 파일을 .so 파일을 만들기 위해서는, llvm이 build된 directory에서 make합니다.
```
cd /llvm-project/build
make
```
- 검사할 c code를 LLVM-IR(.ll)로 변환하는 것은 clang을 사용합니다.
```
clang -O0 -S –emit-llvm sample.c –o sample.ll
```
- .ll 파일을 pass를 통해 검증하는 것은 opt르 사용합니다.
```
opt –load /llvm-project/build/lib/[your-pass].so –[your-pass-command] sample.ll
```

## Core Implementation Description
### 1.메모리 버퍼 오버플로우 구현
- 잠재적으로 버퍼 오버플로우가 일어나 수 있는 값의 범위를 알려줍니다. 순서대로 context, 함수, 접근하는 line, 버퍼 사이즈, 접근 가능한 범위를 출력합니다.
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



## Result & Future

