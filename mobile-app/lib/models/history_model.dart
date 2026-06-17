class HistoryRecord {
  final String id;
  final String sourceText;
  final String translatedText;
  final String sourceLang;
  final String targetLang;
  final DateTime timestamp;
  final String type;

  HistoryRecord({
    required this.id,
    required this.sourceText,
    required this.translatedText,
    required this.sourceLang,
    required this.targetLang,
    required this.timestamp,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sourceText': sourceText,
      'translatedText': translatedText,
      'sourceLang': sourceLang,
      'targetLang': targetLang,
      'timestamp': timestamp.toIso8601String(),
      'type': type,
    };
  }

  factory HistoryRecord.fromJson(Map<String, dynamic> json) {
    return HistoryRecord(
      id: json['id'] ?? '',
      sourceText: json['sourceText'] ?? '',
      translatedText: json['translatedText'] ?? '',
      sourceLang: json['sourceLang'] ?? 'en',
      targetLang: json['targetLang'] ?? 'zh',
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toString()),
      type: json['type'] ?? 'text',
    );
  }
}