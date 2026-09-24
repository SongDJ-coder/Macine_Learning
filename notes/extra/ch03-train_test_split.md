---
tags: [혼공머신, 3장, sklearn, 추가질문]
관련노트: "[[ch03]]"
---

# train_test_split 자세히 뜯어보기

> [[ch03|← 3장 원리 노트로 돌아가기]]

**Q: train_test_split 함수를 다시 설명해줄래?**

`train_test_split`은 예전에 손으로 했던 "인덱스 섞고 잘라서 훈련/테스트 나누기"를
한 번에 대신 해주는 사이킷런 함수.

### 예전에 직접 했던 것
```python
np.random.seed(42)
index = np.arange(49)
np.random.shuffle(index)
train_input = input_arr[index[:35]]
test_input = input_arr[index[35:]]
train_target = target_arr[index[:35]]
test_target = target_arr[index[35:]]
```

### train_test_split으로 압축
```python
train_input, test_input, train_target, test_target = train_test_split(
    perch_length, perch_weight, random_state=42)
```

- **입력**: 특성(X)과 정답(y) 배열을 같이 넣음. 내부적으로 **같은 셔플 순서**를
  두 배열에 동시에 적용해서, 짝(길이[i], 무게[i])이 절대 어긋나지 않게 함.
- **출력 순서 (헷갈리기 쉬움)**: `(첫 번째 입력의 훈련분, 첫 번째 입력의 테스트분,
  두 번째 입력의 훈련분, 두 번째 입력의 테스트분)` — "train 것들 먼저, test 것들
  나중"이 아니라 **입력 순서대로 (훈련,테스트) 쌍이 반복**되는 구조.

### 주요 옵션
- `test_size`: 테스트 세트 비율. 기본값 `0.25`.
- `random_state=42`: 셔플에 쓰는 난수 시드 고정 → 실행할 때마다 같은 결과 재현.
- `shuffle=True`(기본값): 자르기 전에 랜덤 섞음 → 샘플링 편향을 기본적으로 막아줌.
- `stratify=y`: (분류일 때) 클래스 비율까지 유지 — [[extra/ch02-stratify]] 참고.

> [!tip] 정리
> "셔플 + 비율대로 자르기 + 훈련/테스트 대응관계 유지"를 한 줄로 대신 해주는 함수.
> 차원(1차원/2차원) 자체는 안 건드림 — 원래 모양 그대로 개수만 나눔.
