# PolyLingua+ API Documentation

## Backend Endpoints

### Translation

#### POST /api/translate
Translate text between languages.

**Request:**
```json
{
  "text": "Hello, how are you?",
  "sourceLang": "en",
  "targetLang": "zh"
}
```

**Response:**
```json
{
  "translatedText": "你好，你好吗？"
}
```

#### POST /api/detect-language
Detect the language of input text.

**Request:**
```json
{
  "text": "Bonjour, comment allez-vous?"
}
```

**Response:**
```json
{
  "language": "fr"
}
```

## Supported Languages
- **en** - English
- **zh** - Mandarin Chinese (Simplified)
- **tl** - Filipino/Tagalog