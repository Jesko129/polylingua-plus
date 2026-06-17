import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/history_model.dart';

class HistoryProvider extends ChangeNotifier {
  List<HistoryRecord> _history = [];
  final int _maxItems = 500;

  List<HistoryRecord> get history => _history;

  Future<void> loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('translation_history');
      if (jsonString != null) {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        _history = jsonList
            .map((item) => HistoryRecord.fromJson(item))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      print('Error loading history: $e');
    }
  }

  Future<void> addRecord(
    String sourceText,
    String translatedText,
    String sourceLang,
    String targetLang,
    String type,
  ) async {
    try {
      final record = HistoryRecord(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        sourceText: sourceText,
        translatedText: translatedText,
        sourceLang: sourceLang,
        targetLang: targetLang,
        timestamp: DateTime.now(),
        type: type,
      );
      _history.insert(0, record);
      if (_history.length > _maxItems) {
        _history.removeRange(_maxItems, _history.length);
      }
      await _saveHistory();
      notifyListeners();
    } catch (e) {
      print('Error adding record: $e');
    }
  }

  Future<void> removeRecord(String id) async {
    try {
      _history.removeWhere((record) => record.id == id);
      await _saveHistory();
      notifyListeners();
    } catch (e) {
      print('Error removing record: $e');
    }
  }

  Future<void> clearHistory() async {
    try {
      _history.clear();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('translation_history');
      notifyListeners();
    } catch (e) {
      print('Error clearing history: $e');
    }
  }

  Future<void> _saveHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString =
          jsonEncode(_history.map((r) => r.toJson()).toList());
      await prefs.setString('translation_history', jsonString);
    } catch (e) {
      print('Error saving history: $e');
    }
  }
}