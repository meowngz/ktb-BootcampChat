#!/bin/bash

# 실시간 채팅 프로젝트 최초 실행 자동화 스크립트
# 사용법: bash setup.sh

set -e

# 1. Node.js, MongoDB, Redis 설치 안내
# (macOS 기준, 직접 설치 필요)
echo "[안내] Node.js(v18+), MongoDB, Redis가 설치되어 있어야 합니다."
echo "[안내] Homebrew가 설치되어 있다면 아래 명령어로 설치 가능:"
echo "brew install node mongodb-community redis"

# 2. 프로젝트 클론
# (이미 클론된 경우 생략)
# git clone <REPO_URL>
# cd <PROJECT_DIR>

# 3. 패키지 설치
npm install
npm run setup

# 4. 환경 변수 파일 생성 (로컬 기본값)
cat <<EOF > backend/.env
MONGO_URI=mongodb://localhost:27017/bootcampchat
JWT_SECRET=your_jwt_secret
REDIS_HOST=localhost
REDIS_PORT=6379
ENCRYPTION_KEY=your_encryption_key
PASSWORD_SALT=your_password_salt
EOF

cat <<EOF > frontend/.env.local
NEXT_PUBLIC_API_URL=http://localhost:5001
NEXT_PUBLIC_ENCRYPTION_KEY=your_encryption_key
NEXT_PUBLIC_PASSWORD_SALT=your_password_salt
EOF

# 5. MongoDB, Redis 실행 안내
echo "[안내] MongoDB와 Redis를 실행하세요:"
echo "mongod --dbpath ~/data/db &"
echo "redis-server &"

# 6. 서버 실행
echo "[안내] 프론트엔드/백엔드 서버를 개발 모드로 실행합니다."
npm run dev
