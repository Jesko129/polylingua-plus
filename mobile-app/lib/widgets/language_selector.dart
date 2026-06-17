import 'package:flutter/material.dart';
import '../config/app_config.dart';
import '../config/app_theme.dart';

class LanguageSelector extends StatelessWidget {
  final String language;
  final ValueChanged<String> onLanguageChanged;
  final String? label;

  const LanguageSelector({
    super.key,
    required this.language,
    required this.onLanguageChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final currentLang = AppConfig.supportedLanguages[language] ?? 'English';
    final currentFlag = AppConfig.languageFlags[language] ?? '🇬🇧';

    return DropdownButton<String>(
      value: language,
      onChanged: (String? newLang) {
        if (newLang != null) {
          onLanguageChanged(newLang);
        }
      },
      underline: Container(height: 2, color: AppTheme.accentCyan),
      dropdownColor: AppTheme.secondaryDark,
      items: AppConfig.supportedLanguages.entries.map((entry) {
        return DropdownMenuItem<String>(
          value: entry.key,
          child: Row(
            children: [
              Text(
                AppConfig.languageFlags[entry.key] ?? '',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 10),
              Text(
                entry.value,
                style: const TextStyle(color: AppTheme.textWhite),
              ),
            ],
          ),
        );
      }).toList(),
      icon: const Icon(Icons.arrow_drop_down, color: AppTheme.accentCyan),
    );
  }
}