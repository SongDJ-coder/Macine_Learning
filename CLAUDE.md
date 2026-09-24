# 프로젝트 개요

『혼자 공부하는 머신러닝+딥러닝』(박해선, 한빛미디어) 완독 실습을 위한 개인 학습 저장소.
1~6장은 개정 전 판 기준으로 진행 중.

사용자 로컬 환경: Windows, VS Code + Jupyter 확장, Python 3.14, `venv` 가상환경.

## 역할 분담

- **사용자**: `chXX_.../*.ipynb`에 책 실습 코드를 직접 작성·실행. Claude는 이 코드를 미리 만들지 않는다.
- **Claude**: `notes/chXX.md`에 원리·개념 정리만 담당. 사용자가 요청했을 때만 작성/수정한다.
- Claude는 사용자가 먼저 요청하기 전까지 새 파일이나 코드를 미리 만들지 않는다 (스캐폴딩 금지).

## 작업 흐름 (동기화)

- 사용자는 로컬에서 코드 작성 후 직접 `git add / commit / push`.
- Claude는 사용자 요청 시 `git fetch` + `git merge --ff-only`로 최신 코드를 확인한 뒤 답변한다.
- 노트(`notes/chXX.md`) 업데이트는 매 질문마다 즉시 하지 않고 아래 시점에 배치 처리한다:
  1. 사용자가 "오늘은 여기까지" 등으로 세션 종료를 알릴 때
  2. 대화가 길어져서 한 번에 정리하지 않으면 내용을 놓칠 것 같을 때
  3. 사용자가 명시적으로 "지금 바로 정리해줘"라고 요청할 때 (예외)

## notes/chXX.md 작성 규칙

- 파일 상단에 YAML frontmatter 포함: `tags`, `book`, `chapter`, `title`
- 헤더는 책의 절 번호 그대로 사용 (예: `## 01-3 ...`)
- 이모지는 챕터/큰 섹션 제목 정도에만 최소한으로 사용. 남발 금지 (문단마다 넣지 않음)
- 개념 비교는 표(table), 알고리즘 동작 단계는 코드블록 텍스트 다이어그램으로 시각화
- 핵심 요약은 `> [!tip]`, 한계/주의는 `> [!warning]`, 정의/개요는 `> [!info]` 같은 Obsidian callout 사용
- 대화 중 사용자가 추가로 던진 질문은 **메인 노트에 인라인으로 적지 않고**, `notes/extra/`에
  별도 파일로 분리한다.
  - 파일명: `notes/extra/chXX-주제.md` (주제는 짧은 한글 슬러그, 예: `ch01-fit-필요성.md`)
  - extra 노트 상단에 `[[chXX|← N장 원리 노트로 돌아가기]]` 형태로 메인 노트 역링크 추가
  - 메인 노트(`notes/chXX.md`)에는 질문이 발생한 바로 그 지점에
    `> [!question] 추가 질문` 콜아웃 + `[[extra/chXX-주제|질문 요약]]` wikilink만 삽입
  - 이렇게 메인 스트림은 짧게 유지하고, 곁가지 질문은 클릭해서 넘어가 보는 구조로 관리
- 문서 끝에 다음 챕터로 가는 `[[chXX+1]]` wikilink 추가
- Obsidian vault로 바로 열어볼 수 있어야 하므로 순수 마크다운 + 위 문법만 사용 (플러그인 전용 문법 지양)
- 사용자의 실습 코드(`.ipynb`)는 건드리지 않는다 — 노트 파일만 관리 대상

## 커밋/푸시

- `notes/` 변경 시 Claude가 직접 git add/commit/push
- 원격 브랜치: `claude/ml-dl-learning-support-y95l9c`
- 커밋 메시지는 한국어로 간단히 작성

## 대화 톤

- 채팅 응답은 음슴체, 불필요한 수식어·부사 최소화

## 참고: 이미 해결된 환경 이슈

- VS Code에서 Jupyter 커널 목록에 `venv`가 안 뜨는 문제 → 원인은 **Workspace Trust(제한 모드)**.
  `Ctrl+Shift+P` → `Workspaces: Manage Workspace Trust` → Trust 선택 → 창 재시작으로 해결됨.
  (Python/Python Environments 확장은 신뢰 안 된 워크스페이스에서 자동으로 꺼짐)
- Windows 한국어 로케일(`cp949`)에서 `sklearn` 모델 객체를 노트북에 그냥 출력하면
  `UnicodeDecodeError`가 날 수 있음 → `sklearn.set_config(display='text')`로 해결.
