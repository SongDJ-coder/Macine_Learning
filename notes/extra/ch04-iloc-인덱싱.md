---
tags: [혼공머신, 4장, pandas, 추가질문]
관련노트: "[[ch04]]"
---

# .iloc은 왜 쓰나 (초판/개정판 차이)

> [[ch04|← 4장 원리 노트로 돌아가기]]

```python
print(train_target.iloc[indexes[0]])
```

## .iloc = "번호표 무시하고 순서로 찾기"

pandas는 각 행에 **번호표(인덱스 라벨)**를 붙여 관리한다. 처음엔 0, 1, 2, ...이지만,
`train_test_split`이 행을 섞어도 **번호표는 원래 것을 그대로 들고 간다.**

```
fish_target (원본)       train_target (섞인 뒤)
번호표  값               순서  번호표  값
  0   Bream               0     47   Bream
  1   Bream               1      3   Perch
  2   Bream               2    112   Smelt
 ...                     ...
```

`kneighbors()`가 돌려준 `indexes`는 **"train 안에서 순서상 몇 번째"**라는 뜻이다.

| 코드 | 찾는 방식 | 결과 |
|---|---|---|
| `train_target[2]` (Series) | 번호표가 2인 행 | 섞여서 엉뚱한 행이거나 없을 수 있음 |
| `train_target.iloc[2]` | 순서상 2번째 행 | 정확함 |

그래서 순서 번호인 `indexes`와 짝을 맞추려면 `.iloc`을 써야 한다.

## 초판과 개정판의 차이

| | 초판 (`hg-mldl`) | 개정판 (`hg-mldl2`) |
|---|---|---|
| 정답 데이터 | `fish['Species'].to_numpy()` (numpy 배열) | `fish['Species']` (pandas Series) |
| 이웃 확인 | `train_target[indexes]` | `train_target.iloc[indexes[0]]` |

numpy 배열에는 번호표가 없어서(순서 = 인덱스) 그냥 대괄호로 되고, pandas Series는 `.iloc`이 필요하다.
둘 다 결과는 같다. **3장부터는 개정판 기준이므로 `.iloc`을 쓰는 게 책과 일치한다.**
