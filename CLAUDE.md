# 프로젝트 개요

『혼자 공부하는 머신러닝+딥러닝』(박해선, 한빛미디어) 완독 실습을 위한 개인 학습 저장소.

**공부 목적**: 코드를 따라 치는 데서 그치지 않고 **원리까지 이해**하는 것. 사용자는 "왜 이렇게
되는가"(수학적 근거, 내부 동작, 문법 구조)를 자주 묻는다.

사용자 로컬 환경: Windows, VS Code + Jupyter 확장, Python 3.14, `venv` 가상환경.

## 책 판(edition)과 참고 저장소

| 범위 | 판 | 공식 코드 저장소 | 노트북 파일명 |
|---|---|---|---|
| 1~2장 | 초판(2020, 개정 전) | `rickiepark/hg-mldl` | `2-1.ipynb` 형식 |
| **3장부터** | **개정판(2025)** | **`rickiepark/hg-mldl2`** | `03-1.ipynb` 형식 (7장~ PyTorch 버전 있음, 10장 트랜스포머/LLM 추가) |

- 데이터·책 코드를 사용자에게 줄 때는 **기억으로 쓰지 말고 반드시 해당 저장소에서 확인한 뒤** 준다.
  (과거에 `perch_weight` 값을 기억으로 줬다가 3개가 빠져서 에러 난 적 있음)
- **판이 다르면 코드가 다르다.** 예: 4-1에서 초판은 `fish_target = fish['Species'].to_numpy()` +
  `train_target[indexes]`를 쓰지만, 개정판은 `fish['Species']`(pandas 그대로) + `train_target.iloc[indexes[0]]`를
  쓴다. 3장부터는 반드시 `hg-mldl2` 기준으로 판단할 것.
- 두 저장소는 클라우드 환경의 **설정 스크립트**(`setup/cloud_setup.sh`)가 세션 시작 시 `/home/user/rickiepark/`에
  자동으로 clone한다. 세션 시작 후 `ls /home/user/rickiepark`로 확인하고, 없으면(스크립트 미적용·실패)
  `bash setup/cloud_setup.sh`를 직접 실행한다. 클라우드 환경 사용법 전반은 `notes/tools/클라우드-환경.md` 참고.
- 노트북 셀 내용 확인: `python3 -c "import json; nb=json.load(open('경로')); ..."`로 cells를 출력해서 본다.

## 현재 진도 (다음 세션은 여기서 이어서)

- **4장 04-1 로지스틱 회귀 — 개념 학습 완료** (불리언 인덱싱, 이진 분류 학습 원리, decision_function/expit,
  다중 분류 softmax와 행렬 형태의 가중치 수정까지 이해함). 노트: `notes/ch04.md` + `notes/extra/ch04-*.md`
- 04-1 실습도 `logistic_regression.ipynb` 마지막 softmax 셀까지 **완료·push** (결과 모두 책과 일치).
  사용자 노트북은 `fish['Species'].to_numpy()`(초판 방식)를 써서 `train_target`이 numpy 배열임. 문제없이 동작함.
- **04-2 확률적 경사 하강법 — 개념·실습 완료** (`ch04_logistic_regression/stochastic_gradient.ipynb`,
  `tol=None` 100 에포크 셀까지 실행·push, 0.958 / 0.925 책과 일치). 노트: `notes/ch04.md`의 `## 04-2` +
  `notes/extra/ch04-손실값과-기울기.md`, `ch04-sgd-매개변수.md`, `ch04-sgd-경고와-전처리.md`.
  - `loss='hinge'` 셀은 개념만 설명했고 노트북에서는 아직 실행 안 함 (원하면 실행 결과만 확인: 책 0.950 / 0.925).
- **5장 05-1 결정 트리 — 개념·실습 완료** (`ch05_tree_algorithm/decission_tree.ipynb`, 점수 모두 책과 일치).
  - 노트북 18번 셀 `plot_tree(feature_names=['alcohol', 'pH', 'sugar'])` 순서가 틀려 있음(에러 없이 이름만 잘못 붙음) → 노트에 기록, 사용자에게 안내함.
- **현재: 05-2 교차 검증과 그리드 서치 — 그리드 서치까지 진행** (`ch05_tree_algorithm/counter_check_tree.ipynb`).
  - 매개변수 1개 그리드 서치까지 실행 완료. 3개 동시(1350조합×5폴드=6750 fit) 셀은 오래 걸려서 사용자가 중단(KeyboardInterrupt).
    컨테이너 4코어 기준 약 1분 → 기다리면 됨. 결과: max_depth 14, min_impurity_decrease 0.0004, min_samples_split 12 / CV 0.868 / 테스트 0.862.
  - **다음: 3개 매개변수 그리드 서치 재실행 → 랜덤 서치(`RandomizedSearchCV`, scipy `uniform`/`randint`) → 05-3 트리의 앙상블.**
  - 5장 노트: `notes/ch05.md` + `notes/extra/ch05-데이터-모양과-문법.md`, `ch05-트리-학습-원리.md`, `ch05-실습-실수-모음.md`, `ch05-검증과-그리드서치.md`.
- 컨테이너 재현용 와인 데이터: `https://raw.githubusercontent.com/rickiepark/hg-mldl/master/wine.csv` (bit.ly는 403).
- 이번 세션에 효과 있었던 방식: 단계별로 끊어 설명하고 사용자가 "다음"이라고 하면 넘어가기 +
  단계마다 matplotlib 이미지(행렬곱 색칠, 소프트맥스 막대, 오차 히트맵, 결정 경계 변화). 이미지는 `notes/extra/img/`에 보관.

## 사용자 폴더 구조

- `ch01_my_first_ml/`, `ch02_handling_data/`, `ch03_recursion_model/`, `ch04_logistic_regression/`, `ch05_tree_algorithm/` — 사용자가 직접 만든 실습 노트북
- `linear_regression.ipynb` — 사용자가 루트로 옮겨둔 3-2 노트북 (건드리지 않음)
- `notes/chXX.md` + `notes/extra/` — Claude가 관리하는 원리 노트 (Obsidian vault)
- `notes/tools/` — 책 내용이 아닌 도구 사용법 노트 (클라우드 환경, git 등)
- `setup/cloud_setup.sh` — 클라우드 환경의 설정 스크립트 원본. 사용자가 이 내용을 환경 설정에 붙여넣어 쓴다.
  스크립트를 고치면 사용자에게 환경 설정에도 다시 붙여넣으라고 안내할 것.

## 역할 분담

- **사용자**: `chXX_.../*.ipynb`에 책 실습 코드를 직접 작성하고 실행한 뒤, 직접 `git add / commit / push`한다.
- **Claude**:
  - 질문에 원리와 개념으로 답한다. 코드는 사용자가 요청할 때만 준다.
  - 사용자 노트북(`.ipynb`)은 절대 만들거나 수정하지 않는다. 새 파일도 요청 전에는 만들지 않는다 (스캐폴딩 금지).
  - `notes/`의 원리 노트만 작성하고 관리한다.

## 답변 방식 (사용자 선호, 반드시 지킬 것)

- **음슴체, 짧게.** 질문의 핵심에만 답한다. 답이 길어지면 사용자가 요점을 놓친다.
- **"이해 안 됨" 신호가 오면 같은 설명을 반복하지 말고**, 작은 숫자 예시로 처음부터 다시 설명한다.
  그래도 어려우면 시각화로 설명한다 (아래 참고).
- 수학적인 "왜" 질문(증명, 행렬 유도, 확률 성질 등)에는 수식과 직관을 함께 준다.
- **질문받은 코드는 오타부터 확인한다.** 자주 나온 실수: `kneighbers`, `trainsform`, `random=`(→`random_state=`),
  `matplotlib.pylot`, `'Weigh'`, `idexes`, 쉼표 위치(`50*lr.coef_, +lr.intercept_`).
- **추측으로 답하지 말고**, 사용자가 push한 실제 노트북을 fetch해서 확인한 뒤 답한다.
  셀의 `execution_count`가 `None`이면 실행되지 않은 셀이다.
- 사용자가 책과 다르게 실험한 결과(예: 열 순서를 바꾼 뒤의 coef_)를 물으면, 직접 venv에서 재현해서 검증한다.
- 사용자가 "이해했어"라고 요약하면, 맞는 부분과 틀린 부분을 짚어서 확인해준다.

## 시각화 설명 방법

행렬, 차원, 인덱싱, 수식처럼 말로 이해가 잘 안 되는 개념은 그림으로 설명한다.

1. **텍스트 다이어그램** (기본): 배열 모양과 행/열을 코드블록으로 그리고, 화살표(`→`, `↑`)로 대응 관계를 표시한다.
   ```
   arr = [[1, 2],      arr[2]   → [5, 6]     shape (2,)   ← 정수 인덱싱: 차원 사라짐
          [3, 4],      arr[2:3] → [[5, 6]]   shape (1, 2) ← 슬라이스: 차원 유지
          [5, 6]]
   ```
2. **matplotlib 그래프 이미지** (수식이나 기하적 개념일 때): 스크래치패드에서 그려서 `SendUserFile`로 전송한다.
   - 한글 폰트: `fm.fontManager.addfont('/usr/share/fonts/truetype/wqy/wqy-zenhei.ttc')` 후
     `plt.rcParams['font.family'] = 'WenQuanYi Zen Hei'`, `plt.rcParams['axes.unicode_minus'] = False`
   - 전송 전에 `Read`로 이미지를 직접 보고 글자 깨짐과 가독성을 확인한다.
   - 예시: 최소제곱법 설명 때 "잔차 시각화 + SSE(w,b) 등고선 밥그릇" 2패널 그림을 만들어 효과가 있었음.
3. 재현과 그래프에는 설정 스크립트가 만든 가상환경 **`/home/user/ml-venv`**를 쓴다
   (`/home/user/ml-venv/bin/python ...`). numpy, pandas, matplotlib, scikit-learn이 설치돼 있다.
   없으면 `bash setup/cloud_setup.sh`로 만든다. 딥러닝 장부터는 스크립트의 `tensorflow torch` 줄 주석을 풀도록 안내한다.
   설정 스크립트가 일부만 적용된 세션도 있었음(hg-mldl2만 있고 ml-venv 없음). 그럴 땐 `bash setup/cloud_setup.sh`
   또는 임시로 `python3 -m venv venv && venv/bin/pip install numpy pandas matplotlib scikit-learn` (venv/는 gitignore됨).
4. 컨테이너에서는 `https://bit.ly/fish_csv_data`가 프록시에 막힌다(403). 재현할 때는
   `https://raw.githubusercontent.com/rickiepark/hg-mldl/master/fish.csv`를 받아서 쓴다 (같은 데이터).

## 작업 흐름 (동기화)

- Claude는 사용자 요청 시 `git fetch origin <브랜치>` + `git merge --ff-only`로 최신 코드를 확인한 뒤 답변한다.
- 사용자 push가 거부되면(Claude가 notes를 먼저 push한 경우) `git pull` 후 다시 push하라고 안내한다.
- 노트 업데이트는 매 질문마다 즉시 하지 않고 아래 시점에 배치 처리한다:
  1. 사용자가 "오늘은 여기까지", "오늘 공부한 내용 정리해줘" 등으로 세션 종료를 알릴 때
  2. 대화가 길어져서 한 번에 정리하지 않으면 내용을 놓칠 것 같을 때
  3. 사용자가 "꼭 정리해줘", "노트에 넣어줘"처럼 명시적으로 요청할 때

## notes/chXX.md 작성 규칙

- 파일 상단에 YAML frontmatter 포함: `tags`, `book`, `chapter`, `title`
- 헤더는 책의 절 번호 그대로 사용 (예: `## 04-1 ...`)
- 이모지는 챕터/큰 섹션 제목 정도에만 최소한으로 사용. 남발 금지
- 개념 비교는 표(table), 알고리즘 동작 단계는 코드블록 텍스트 다이어그램으로 시각화
- 핵심 요약은 `> [!tip]`, 한계/주의는 `> [!warning]`, 정의/개요는 `> [!info]` 같은 Obsidian callout 사용
- 대화 중 사용자가 추가로 던진 질문은 **메인 노트에 인라인으로 적지 않고** `notes/extra/`에 별도 파일로 분리한다.
  - 파일명: `notes/extra/chXX-주제.md` (주제는 짧은 한글 슬러그)
  - extra 노트 상단에 `[[chXX|← N장 원리 노트로 돌아가기]]` 역링크
  - 메인 노트에는 질문이 나온 지점에 `> [!question] 추가 질문` 콜아웃 + `[[extra/chXX-주제|질문 요약]]`만 삽입
- 책 범위 밖 심화 내용(수학 유도 등)은 extra 노트에 넣고 태그에 `심화`를 붙인다.
- 문서 끝에 다음 챕터로 가는 `[[chXX+1]]` wikilink 추가
- 순수 마크다운 + 위 문법만 사용 (플러그인 전용 문법 지양)

## 커밋/푸시

- `notes/`, `setup/`, `CLAUDE.md` 변경 시 Claude가 직접 git add/commit/push
- 원격 브랜치: `claude/ml-dl-learning-support-y95l9c`
- 커밋 메시지는 한국어로 간단히 작성
- 커밋 전에 fetch + ff-merge로 사용자 push를 먼저 반영한다.

## 참고: 이미 해결된 환경 이슈

- VS Code Jupyter 커널 목록에 `venv`가 안 뜸 → **Workspace Trust(제한 모드)** 때문.
  `Ctrl+Shift+P` → `Workspaces: Manage Workspace Trust` → Trust → 창 재시작.
- `sklearn` 모델 객체 출력 시 `UnicodeDecodeError: 'cp949'` → 노트북 맨 위에
  `import sklearn; sklearn.set_config(display='text')`. (원인: sklearn이 HTML 표시용 `estimator.js`를
  인코딩 지정 없이 열어서, 한국어 Windows 기본 인코딩 cp949로 UTF-8 파일을 읽으려다 실패)
- `pd.read_csv('https://...')`에서 `SSLCertVerificationError` → venv에서 `pip install pip-system-certs` 후
  **커널 재시작** (재시작 안 하면 적용 안 됨). 네트워크를 바꿔도 안 되는 로컬 인증서 저장소 문제였음.
- 셀 실행 시 `[*]`에서 멈춤 / "Interrupting Kernel" → 커널 Restart, 안 되면 `Developer: Reload Window`.
- `git commit`만 쳤더니 Vim이 열려서 못 빠져나옴 → `git config --global core.editor "code --wait"`로 변경 완료.
  앞으로는 `git commit -m "메시지"` 사용을 권장.
- 3-3의 `PolynomialFeatures(degree=5)` 결과가 책(테스트 -144)과 다르게 나옴(0.978) → 버그 아님,
  numpy/scipy 버전 차이(특성 55개 > 샘플 42개라 특이행렬, SVD 근사가 버전마다 다름). `notes/extra/ch03-degree5-버전차이.md` 참고.
