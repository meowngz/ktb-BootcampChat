#!/bin/bash
# AWS EC2 서버 실행 스크립트
set -e

echo "[AWS 자동화] 프론트엔드/백엔드 서버를 실행합니다. 백엔드가 먼저 실행됩니다."
cd backend && npm install && npm start &
cd ../frontend && npm install && npm run build && npm start &
