import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../config/app_config.dart';

class TranslationProvider extends ChangeNotifier {
  final Dio _dio = Dio();

  Future<String> translate(
    String text,
    String sourceLang,
    String targetLang,
  ) async {
    try {
      final response = await _dio.post(
        '${AppConfig.apiBaseUrl}${AppConfig.apiTranslateEndpoint}',
        data: {
          'text': text,
          'sourceLang': sourceLang,
          'targetLang': targetLang,
        },
      );
      return response.data['translatedText'] ?? '';
    } catch (e) {
      print('Translation error: $e');
      rethrow;
    }
  }

  Future<String> detectLanguage(String text) async {
    try {
      final response = await _dio.post(
        '${AppConfig.apiBaseUrl}${AppConfig.apiDetectLanguageEndpoint}',
        data: {'text': text},
      );
      return response.data['language'] ?? 'en';
    } catch (e) {
      print('Language detection error: $e');
      return 'en';
    }
  }
}