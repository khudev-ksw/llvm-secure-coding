# Capstone Design 1 LLVM Project : LLVM-Pass로 Secure Coding Rule 준수 여부 검사
## Introduction
IoT device는 보안 기술 적용의 어려움으로 보안상 취약점이 많습니다. 이를 해결하기 위해 많은 방법들 개발되고 있으며, 그 중 본 연구에서는 Linux 환경에서 LLVM-Pass를 통해 Secure Coding Rule을 검사하는 기능을 구현해보았습니다. 궁극적으로는 ARM 등 Baremetal System에 LLVM을 적용하여 Secure Coding Rule을 준수하는 code verification tool 제작을 목표로 합니다.

## Related Works
- 정적분석, 퍼징, 기호실행 등 취약점 탐지 방법
- LLVM, LLVM IR, LLVM-Pass : https://llvm.org

## Target
- 메모리 버퍼 오버플로우 : 메모리 공간 사이즈 제한, 문자열 끝에 Null 패딩
- Null Pointer 역참조 : Null이 될 수 있느 객체에 대해 사전에 Null 검사 실행

## Implementation Flow
![기초조사서_구현방안_figure1](https://user-images.githubusercontent.com/41164017/139457573-a84ace85-7c58-4e4b-910e-d345ee615373.png)

## Implementation Environment
- Ubuntu 기반 Linux -> Arduino 등 Embedded Board
