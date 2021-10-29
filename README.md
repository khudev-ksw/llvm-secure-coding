# LLVM-Pass를 통한 Secure Coding Rule 검사
Capstone Design 1 LLVM Project

## Introduction
LLVM-Pass를 이용하여 Secure Coding Rule을 고려한 코드를 삽입하여 취약점 보완

## Related Works
- 정적분석
- 퍼징
- 기호실행
- LLVM
- LLVM IR
- LLVM-Pass

## Target
- 메모리 버퍼 오버플로우 : 메모리 공간 사이즈 제한, 문자열 끝에 Null 패딩
- Null Pointer 역참조 : Null이 될 수 있느 객체에 대해 사전에 Null 검사 실행

## Implementation Flow
![기초조사서_구현방안_figure1](https://user-images.githubusercontent.com/41164017/139457573-a84ace85-7c58-4e4b-910e-d345ee615373.png)

## Implementation Environment
- Ubuntu 기반 Linux -> Arduino 등 Embedded Board
