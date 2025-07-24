#!/bin/bash

# 실시간 채팅 프로젝트 최초 실행 자동화 스크립트
# 사용법: bash setup.sh

set -e

## 1. Node.js, MongoDB, Redis 설치 및 서비스 활성화 (AWS EC2 Ubuntu 기준)
echo "[AWS 자동화] Node.js(v18+), MongoDB, Redis를 설치합니다."
sudo apt update && sudo apt install -y nodejs npm mongodb redis-server
echo "[AWS 자동화] MongoDB, Redis를 부팅시 자동 시작하도록 설정합니다."
sudo systemctl enable mongodb
sudo systemctl enable redis-server

# 2. 프로젝트 클론
# (이미 클론된 경우 생략)
# git clone <REPO_URL>
# cd <PROJECT_DIR>


## 2. 프로젝트 패키지 설치 및 초기화
echo "[AWS 자동화] 프로젝트 루트 패키지 설치 및 초기화"
npm install
npm run setup


## 3. 환경 변수 파일 자동 생성
echo "[AWS 자동화] 환경 변수 파일을 생성합니다."
cat <<EOF > backend/.env
MONGO_URI=mongodb://localhost:27017/bootcampchat
JWT_SECRET=your_jwt_secret
REDIS_HOST=localhost
REDIS_PORT=6379
ENCRYPTION_KEY=your_encryption_key
PASSWORD_SALT=your_password_salt
EOF

cat <<EOF > frontend/.env.local
NEXT_PUBLIC_API_URL=http://goorm-ktb-009.goorm.team
NEXT_PUBLIC_ENCRYPTION_KEY=your_encryption_key
NEXT_PUBLIC_PASSWORD_SALT=your_password_salt
EOF


## 4. MongoDB, Redis 실행 및 보안 설정 예시
echo "[AWS 자동화] MongoDB, Redis를 실행합니다."
sudo systemctl start mongodb
sudo systemctl start redis-server

# Redis 보안(비밀번호) 설정 예시
echo "requirepass your_redis_password" | sudo tee -a /etc/redis/redis.conf
sudo systemctl restart redis-server

# MongoDB 인증 설정은 별도 작업 필요 (기본은 인증 없음)


## 5. 서버 실행 (운영/배포 모드)
echo "[AWS 자동화] 프론트엔드/백엔드 서버를 실행합니다."
cd backend && npm install && npm start &
cd ../frontend && npm install && npm run build && npm start &
