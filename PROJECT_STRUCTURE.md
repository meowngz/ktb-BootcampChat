# 프로젝트 파일 구조 및 설명

이 문서는 `ktb-BootcampChat` 프로젝트의 주요 폴더 및 파일 구조와 각 파일/폴더의 역할을 간략히 설명합니다.

## 루트 디렉토리
- `README.md`: 프로젝트 소개, 설치/실행/사용법, 기술 스택 등 안내 문서
- `package.json`: 루트 패키지 관리 및 스크립트
- `generate_code.js`: 코드 생성 관련 스크립트
- `20250430_code.txt`, `vapor-ui-llm-full.txt`: 참고 코드/문서 파일
- `arkain.manifest`, `goorm.manifest`: 배포/환경설정 관련 매니페스트

## backend/
Node.js 기반 서버 코드
- `server.js`: 백엔드 서버 진입점
- `package.json`: 백엔드 패키지 관리
- `config/keys.js`: 환경 변수 및 키 관리
- `controllers/`: 인증, 파일, 사용자 등 API 컨트롤러
- `middleware/`: 인증, 파일 업로드 등 미들웨어
- `models/`: Mongoose 모델 (User, Room, Message, File 등)
- `routes/`: API 라우터 (auth, files, message, rooms, users 등)
- `services/`: AI, 파일, 세션 등 서비스 로직
- `sockets/chat.js`: 실시간 채팅 소켓 핸들러
- `utils/`: 암호화, Redis 클라이언트 등 유틸리티

## frontend/
Next.js 기반 프론트엔드 코드
- `package.json`: 프론트엔드 패키지 관리
- `next.config.js`: Next.js 설정
- `components/`: UI 컴포넌트 (Navbar, Toast, Modal 등)
- `hooks/`: 커스텀 훅 (채팅, 파일, 소켓 등)
- `middleware/withAuth.js`: 인증 미들웨어
- `pages/`: 라우트별 페이지 (index, login, chat, profile 등)
- `public/images/`: 정적 이미지 파일
- `services/`: API, 소켓 등 서비스
- `styles/globals.css`: 글로벌 스타일
- `utils/`: 유틸리티 함수

## e2e/
Playwright 기반 E2E 테스트 코드 및 테스트 데이터
- `test/`: 기능별 테스트 스크립트 (auth, chatrooms, files 등)
- `fixtures/`: 테스트용 문서/이미지/미디어 파일
- `helpers/`: 테스트 헬퍼 함수
- `playwright.config.ts`: Playwright 설정
- `run.sh`: 테스트 실행 스크립트

## 기타
- `docs/`: 문서 및 가이드

---

### 참고
- MongoDB, Redis, Node.js, Next.js 등 다양한 기술 스택을 활용한 실시간 채팅/파일 공유/AI 챗봇 기능을 지원합니다.
- 각 폴더/파일의 상세 역할은 README.md 및 소스코드 주석을 참고하세요.
