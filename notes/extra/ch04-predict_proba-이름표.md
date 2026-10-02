---
tags: [혼공머신, 4장, numpy, pandas, 추가질문]
관련노트: "[[ch04]]"
---

# predict_proba 결과 열에 클래스 이름을 붙이려면?

> [[ch04|← 4장 원리 노트로 돌아가기]]

**Q: `proba` 배열 맨 위에 `kn.classes_`를 한 줄 붙이고 싶은데, `proba.append[0] = kn.classes_` 하면 되나?**

안 된다. 이유는 세 가지다.

1. **numpy 배열에는 `.append()`가 없다.** `append`는 파이썬 리스트의 기능이라서
   `AttributeError: 'numpy.ndarray' object has no attribute 'append'`가 난다.
2. `append[0]`처럼 대괄호를 쓰는 것도 문법에 맞지 않는다 (함수 호출은 괄호 `()`를 쓴다).
3. numpy에서 위에 한 줄을 쌓는 방법은 `np.vstack([kn.classes_, proba])`인데, **numpy 배열은
   한 가지 타입만 담을 수 있어서** 문자열(클래스 이름)과 섞는 순간 숫자까지 전부 문자열로 바뀐다.

## 이름표가 붙은 표는 pandas로

```python
import pandas as pd
df = pd.DataFrame(proba, columns=kn.classes_)
print(df)
```
```
   Bream  Parkki  Perch  Pike  Roach  Smelt  Whitefish
0    0.0     0.0    1.0   0.0    0.0    0.0        0.0
1    0.0     0.0    0.0   0.0    0.0    1.0        0.0
3    0.0     0.0 0.6667   0.0 0.3333    0.0        0.0
...
```
숫자는 숫자 그대로 두고 컬럼 이름만 붙는다. `pd.DataFrame(데이터, columns=이름들)`이
"2차원 배열에 이름표 붙이기"의 표준 방법이다.

## 한 샘플씩 보고 싶을 때 — zip

```python
for name, p in zip(kn.classes_, proba[0]):   # proba[0]: 0번째 샘플의 확률 7개
    print(name, p)
```
`zip(a, b)`는 두 배열을 **같은 위치끼리 짝지어서** 하나씩 꺼내준다.
