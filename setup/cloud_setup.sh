#!/bin/bash
# 혼공머신 학습용 클라우드 세션 준비 스크립트
#
# 사용법: Claude Code 클라우드 환경 설정의 "설정 스크립트" 칸에 이 내용을 붙여넣는다.
#         (세션 상단 클라우드 환경 메뉴 → 편집 → 설정 스크립트)
# 새 세션이 시작될 때마다 Claude Code보다 먼저 자동 실행된다.
# 이미 있는 건 건너뛰므로 여러 번 실행해도 안전하다. (첫 실행 약 40초, 이후 1초 이내)
# 저장소 폴더 위치에 의존하지 않도록 따로 떨어진 경로를 쓴다.

REF_DIR=/home/user/rickiepark     # 책 공식 코드 저장소를 둘 위치
VENV_DIR=/home/user/ml-venv       # 재현·그래프용 가상환경 위치

# (1) 책 공식 코드 저장소 받기 (데이터·코드 대조용)
#     hg-mldl  = 초판(1~2장), hg-mldl2 = 개정판(3장~)
mkdir -p "$REF_DIR"
for repo in hg-mldl hg-mldl2; do
  if [ ! -d "$REF_DIR/$repo" ]; then
    GIT_LFS_SKIP_SMUDGE=1 git clone --depth 1 "https://github.com/rickiepark/$repo" "$REF_DIR/$repo" \
      || echo "[setup] $repo clone 실패 (세션은 계속 진행)"
  fi
done

# (2) 가상환경 만들고 패키지 설치
if [ ! -x "$VENV_DIR/bin/python" ]; then
  python3 -m venv "$VENV_DIR"
fi
"$VENV_DIR/bin/pip" install -q --upgrade pip
"$VENV_DIR/bin/pip" install -q numpy pandas matplotlib scikit-learn \
  || echo "[setup] 패키지 설치 실패 (세션은 계속 진행)"

# (3) 나중에 필요해지면 아래 줄의 주석(#)을 풀어서 사용
# "$VENV_DIR/bin/pip" install -q tensorflow torch    # 7장 딥러닝부터

echo "[setup] 준비 완료"
