# PolyLingua+ Setup Guide

## Prerequisites
- Flutter SDK 3.0+
- Dart 3.0+
- Node.js 18+
- Android Studio / Xcode
- Git

## Backend Setup
```bash
cd backend
npm install
cp .env.example .env
npm run dev
```

## Mobile App Setup (Flutter)

### 1. Get Dependencies
```bash
cd mobile-app
flutter pub get
```

### 2. Run on Android
```bash
flutter run
```

### 3. Run on iOS
```bash
flutter run -d iPhone
```

### 4. Build APK
```bash
flutter build apk --release
```

### 5. Build iOS
```bash
flutter build ios --release
```

## Configuration
- Update `lib/config/app_config.dart` with API endpoints
- Add API keys in `backend/.env`
- Configure Firebase (optional) for real-time features