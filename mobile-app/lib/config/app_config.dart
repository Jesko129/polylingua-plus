class AppConfig {
  static const String appName = 'PolyLingua+';
  static const String appVersion = '1.0.0';

  // API Configuration
  static const String apiBaseUrl = 'http://localhost:3000';
  static const String apiTranslateEndpoint = '/api/translate';
  static const String apiDetectLanguageEndpoint = '/api/detect-language';

  // Supported Languages
  static const Map<String, String> supportedLanguages = {
    'en': 'English',
    'zh': 'Mandarin Chinese',
    'tl': 'Filipino',
  };

  static const Map<String, String> languageFlags = {
    'en': '🇬🇧',
    'zh': '🇨🇳',
    'tl': '🇵🇭',
  };

  // Cache Configuration
  static const int maxHistoryItems = 500;
}