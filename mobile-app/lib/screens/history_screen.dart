import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_theme.dart';
import '../providers/history_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HistoryProvider>().loadHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translation History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Clear History'),
                  content: const Text(
                      'Are you sure you want to delete all translation history?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<HistoryProvider>().clearHistory();
                        Navigator.pop(context);
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<HistoryProvider>(
        builder: (context, historyProvider, _) {
          if (historyProvider.history.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.history,
                    size: 64,
                    color: AppTheme.accentCyan,
                  ),
                  const SizedBox(height: 16),
                  const Text('No translation history yet'),
                  const SizedBox(height: 8),
                  Text(
                    'Your translations will appear here',
                    style: TextStyle(color: AppTheme.textGray),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: historyProvider.history.length,
            itemBuilder: (context, index) {
              final record = historyProvider.history[index];
              return Card(
                color: AppTheme.secondaryDark,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(record.sourceText),
                  subtitle: Text(
                    '${record.sourceLang.toUpperCase()} → ${record.targetLang.toUpperCase()}',
                    style: const TextStyle(color: AppTheme.accentCyan),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () =>
                        historyProvider.removeRecord(record.id),
                    color: AppTheme.errorRed,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}