import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import '../config/app_theme.dart';
import '../providers/translation_provider.dart';
import '../widgets/language_selector.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  late stt.SpeechToText _speechToText;
  late FlutterTts _flutterTts;

  String _sourceLang = 'en';
  String _targetLang = 'zh';
  bool _isListening = false;
  bool _isTranslating = false;

  @override
  void initState() {
    super.initState();
    _speechToText = stt.SpeechToText();
    _flutterTts = FlutterTts();
    _initializeSpeech();
  }

  void _initializeSpeech() async {
    await _speechToText.initialize();
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speechToText.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speechToText.listen(
          onResult: (result) {
            setState(() {
              _sourceController.text = result.recognizedWords;
              if (result.finalResult) _isListening = false;
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speechToText.stop();
    }
  }

  void _swapLanguages() {
    setState(() {
      final temp = _sourceLang;
      _sourceLang = _targetLang;
      _targetLang = temp;
    });
  }

  void _translate() async {
    if (_sourceController.text.isEmpty) return;
    setState(() => _isTranslating = true);
    try {
      final provider = context.read<TranslationProvider>();
      final result = await provider.translate(
        _sourceController.text,
        _sourceLang,
        _targetLang,
      );
      _targetController.text = result;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Translation failed: $e')),
      );
    } finally {
      setState(() => _isTranslating = false);
    }
  }

  void _playTranslation() async {
    if (_targetController.text.isNotEmpty) {
      await _flutterTts.setLanguage(_targetLang);
      await _flutterTts.speak(_targetController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Translator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LanguageSelector(
              label: 'From',
              language: _sourceLang,
              onLanguageChanged: (lang) => setState(() => _sourceLang = lang),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _sourceController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter text or tap microphone to speak',
                filled: true,
                fillColor: AppTheme.secondaryDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppTheme.accentCyan),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _startListening,
                  icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                  label: Text(_isListening ? 'Listening...' : 'Mic'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _sourceController.clear(),
                  icon: const Icon(Icons.clear),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.secondaryDark,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.accentCyan, width: 2),
                ),
                child: IconButton(
                  onPressed: _swapLanguages,
                  icon: const Icon(Icons.swap_vert),
                  color: AppTheme.accentCyan,
                  iconSize: 28,
                ),
              ),
            ),
            const SizedBox(height: 20),
            LanguageSelector(
              label: 'To',
              language: _targetLang,
              onLanguageChanged: (lang) => setState(() => _targetLang = lang),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _targetController,
              readOnly: true,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Translation will appear here',
                filled: true,
                fillColor: AppTheme.secondaryDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppTheme.accentCyan),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isTranslating ? null : _translate,
                icon: const Icon(Icons.translate),
                label: Text(_isTranslating ? 'Translating...' : 'Translate'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _sourceController.dispose();
    _targetController.dispose();
    _speechToText.stop();
    _flutterTts.stop();
    super.dispose();
  }
}