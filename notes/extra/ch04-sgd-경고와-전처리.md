---
tags: [혼공머신, 4장, 표준화, 경고, 추가질문]
관련노트: "[[ch04]]"
---

# 스케일러는 왜 train에만 fit하나 / 실습 중 나온 경고

> [[ch04|← 4장 원리 노트로 돌아가기]]

## StandardScaler: fit은 "자"를 만드는 단계

```
fit(train)       → 평균, 표준편차 계산·저장       ← 자 만들기 (데이터는 안 바뀜)
transform(train) → (값 − 평균) / 표준편차
transform(test)  → 같은 자로 재기
```

1. **같은 자로 재야 의미가 같다**: train 무게 100, 200, 300 (평균 200) → test 200은 train 자로 0.0 = "평균 크기".
   test 자로 재면 같은 숫자의 의미가 달라진다.
2. **test = 아직 못 본 미래 데이터**: 실제로 생선이 한 마리씩 들어오면 평균을 낼 수 없으니 결국 훈련 때의 자를 쓴다.
   test로 fit하면 시험 문제를 미리 보는 것(정보 누설).

## DataConversionWarning: A column-vector y was passed

```python
fish_target = fish[['Species']]   # ❌ 대괄호 2겹 → (159, 1) 2차원 "열 벡터"
fish_target = fish['Species']     # ✅ 대괄호 1겹 → (159,)   1차원
```

특성은 `[[...]]`(2차원), 정답은 `[...]`(1차원). 고친 뒤 **그 셀부터 다시 실행**해야 반영된다.

## ConvergenceWarning: Maximum number of iteration reached

`max_iter` 안에 멈춤 조건(`tol`)을 못 채웠다는 뜻. 결과가 틀렸다는 게 아니다.
04-2의 `max_iter=10`에서는 책에서도 뜨는 **의도된 경고** ([[extra/ch04-sgd-매개변수|tol 정리]] 참고).
