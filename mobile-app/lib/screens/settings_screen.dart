import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_theme.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, _) {
          return ListView(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'General',
                  style: TextStyle(
                    color: AppTheme.accentCyan,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildSwitchTile(
                context,
                icon: Icons.language,
                title: 'Auto-Detect Language',
                value: settingsProvider.autoDetect,
                onChanged: (value) =>
                    settingsProvider.updateAutoDetect(value),
              ),
              _buildSwitchTile(
                context,
                icon: Icons.volume_up,
                title: 'Text-to-Speech',
                value: settingsProvider.textToSpeechEnabled,
                onChanged: (value) =>
                    settingsProvider.updateTextToSpeech(value),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Display',
                  style: TextStyle(
                    color: AppTheme.accentCyan,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildSwitchTile(
                context,
                icon: Icons.brightness_4,
                title: 'Dark Mode',
                value: settingsProvider.darkMode,
                onChanged: (value) =>
                    settingsProvider.updateDarkMode(value),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'About',
                  style: TextStyle(
                    color: AppTheme.accentCyan,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('App Version'),
                    Text(
                      '1.0.0',
                      style: TextStyle(color: AppTheme.accentCyan),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.accentCyan),
          const SizedBox(width: 16),
          Expanded(child: Text(title)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.accentCyan,
          ),
        ],
      ),
    );
  }
}