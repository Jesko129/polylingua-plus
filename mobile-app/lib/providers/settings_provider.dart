import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _autoDetect = true;
  bool _textToSpeechEnabled = true;
  bool _darkMode = true;

  bool get autoDetect => _autoDetect;
  bool get textToSpeechEnabled => _textToSpeechEnabled;
  bool get darkMode => _darkMode;

  Future<void> loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _autoDetect = prefs.getBool('autoDetect') ?? true;
      _textToSpeechEnabled = prefs.getBool('textToSpeech') ?? true;
      _darkMode = prefs.getBool('darkMode') ?? true;
      notifyListeners();
    } catch (e) {
      print('Error loading settings: $e');
    }
  }

  Future<void> updateAutoDetect(bool value) async {
    _autoDetect = value;
    await _saveSetting('autoDetect', value);
    notifyListeners();
  }

  Future<void> updateTextToSpeech(bool value) async {
    _textToSpeechEnabled = value;
    await _saveSetting('textToSpeech', value);
    notifyListeners();
  }

  Future<void> updateDarkMode(bool value) async {
    _darkMode = value;
    await _saveSetting('darkMode', value);
    notifyListeners();
  }

  Future<void> _saveSetting(String key, dynamic value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (value is bool) {
        await prefs.setBool(key, value);
      }
    } catch (e) {
      print('Error saving setting: $e');
    }
  }
}