#!/bin/bash
# AWS EC2 최초 환경 준비 스크립트
set -e

echo "[AWS 자동화] Node.js(v18+), MongoDB, Redis를 설치합니다."
sudo apt update && sudo apt install -y nodejs npm mongodb redis-server

echo "[AWS 자동화] MongoDB, Redis를 부팅시 자동 시작하도록 설정합니다."
sudo systemctl enable mongodb
sudo systemctl enable redis-server

echo "[AWS 자동화] 프로젝트 루트 패키지 설치 및 초기화"
npm install
npm run setup

echo "[AWS 자동화] 환경 변수 파일을 생성합니다."

# 안전한 키/비밀번호 자동 생성
JWT_SECRET=$(openssl rand -base64 32)
ENCRYPTION_KEY=$(openssl rand -base64 32)
PASSWORD_SALT=$(openssl rand -hex 16)
REDIS_PASSWORD=$(openssl rand -base64 16)

cat <<EOF > backend/.env
MONGO_URI=mongodb://localhost:27017/bootcampchat
JWT_SECRET=$JWT_SECRET
REDIS_HOST=localhost
REDIS_PORT=6379
ENCRYPTION_KEY=$ENCRYPTION_KEY
PASSWORD_SALT=$PASSWORD_SALT
EOF

cat <<EOF > frontend/.env.local
NEXT_PUBLIC_API_URL=http://goorm-ktb-009.goorm.team
NEXT_PUBLIC_ENCRYPTION_KEY=$ENCRYPTION_KEY
NEXT_PUBLIC_PASSWORD_SALT=$PASSWORD_SALT
EOF

echo "[AWS 자동화] MongoDB, Redis를 실행합니다."
sudo systemctl start mongodb
sudo systemctl start redis-server

# Redis 보안(비밀번호) 설정
echo "requirepass $REDIS_PASSWORD" | sudo tee -a /etc/redis/redis.conf
sudo systemctl restart redis-server
# MongoDB 인증 설정은 별도 작업 필요 (기본은 인증 없음)
