---
tags: [혼공머신, 4장, 확률적경사하강법, SGDClassifier, 추가질문]
관련노트: "[[ch04]]"
---

# SGDClassifier 매개변수와 partial_fit 정리

> [[ch04|← 4장 원리 노트로 돌아가기]]

## random_state — 손실 함수가 아니라 "섞는 순서"

SGD는 매 에포크마다 샘플 순서를 무작위로 섞는다(`shuffle=True` 기본). 순서가 바뀌면 가중치가 고쳐지는 경로가 달라져 결과도 달라진다.

```
random_state   훈련     테스트      (loss='log_loss', max_iter=10)
    42         0.782    0.800
     0         0.748    0.800
     1         0.723    0.650
     7         0.689    0.650
```

`shuffle=False`로 끄면 random_state를 바꿔도 결과가 같다 → 랜덤성의 출처는 섞기. 목적은 **재현성**.

## tol — 자동 멈춤 기준

- 기본 `tol=0.001`, `n_iter_no_change=5`: 손실이 0.001 이상 안 줄어든 에포크가 **5번 연속**이면 멈춤
- `max_iter` 안에 이 조건을 못 채우면 `ConvergenceWarning`
- `tol=None`: 자동 멈춤 끔 → `max_iter`만큼 정확히 돈다

```
max_iter=100, tol=None   → 100 에포크   0.958 / 0.925   (책과 동일)
max_iter=100, tol=0.001  →  39 에포크   0.706 / 0.675
```

> [!warning] 멈춤 조건 만족 ≠ 가장 좋은 지점
> SGD는 손실이 들쭉날쭉 줄어서 자동 멈춤 지점이 좋지 않을 수 있다 → 그래프로 직접 골라 `tol=None`으로 그 횟수만큼 돌린다(조기 종료).

## fit vs partial_fit

```
                                   훈련     테스트
fit (max_iter=10)                  0.782    0.800
  → partial_fit 1번 (이어서)       0.798    0.825   ↑  (사용자 노트북 결과)
  → 다시 fit (처음부터 리셋)        0.782    0.800
```
(책은 0.798 / 0.775 — 버전 차이)

## partial_fit에 classes가 필요한 이유

`coef_`는 (클래스 수, 특성 수) 표라서 **처음에 줄 수를 정해야** 한다. partial_fit은 데이터 일부만 보므로
첫 묶음에 없는 클래스가 나중에 나오면 넣을 줄이 없다 → 첫 호출 때 전체 클래스 목록을 알려준다.

| 상황 | classes 필요? |
|---|---|
| `fit()` 후 `partial_fit` | ❌ (`classes_`에 이미 저장됨) |
| 새 모델에 첫 `partial_fit` | ✅ (안 주면 `classes must be passed on the first call`) |

## np.unique — 중복 제거 + 정렬

```
입력 : 'Perch' 'Bream' 'Perch' 'Smelt' 'Bream'
결과 : ['Bream' 'Perch' 'Smelt']      ← 중복 제거 + 알파벳순
```

| | `pd.unique` (04-1) | `np.unique` |
|---|---|---|
| 순서 | 처음 등장한 순서 | 알파벳순 (= sklearn `classes_` 순서) |
