import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../config/app_theme.dart';
import '../widgets/language_selector.dart';

class OCRScreen extends StatefulWidget {
  const OCRScreen({super.key});

  @override
  State<OCRScreen> createState() => _OCRScreenState();
}

class _OCRScreenState extends State<OCRScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  String? _imagePath;
  String _extractedText = '';
  String _translatedText = '';
  String _targetLang = 'en';
  bool _isProcessing = false;

  void _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: source);
      if (image != null) {
        setState(() => _imagePath = image.path);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Translation')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.secondaryDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.accentCyan, width: 2),
              ),
              child: _imagePath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(_imagePath!),
                        fit: BoxFit.cover,
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.image,
                            size: 64,
                            color: AppTheme.accentCyan,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'No image selected',
                            style: TextStyle(color: AppTheme.textGray),
                          ),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.photo_camera),
                  label: const Text('Camera'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Gallery'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_extractedText.isNotEmpty) ...
              [
                Text(
                  'Extracted Text',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.accentCyan,
                      ),
                ),
                const SizedBox(height: 10),
                TextField(
                  readOnly: true,
                  maxLines: 4,
                  initialValue: _extractedText,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppTheme.secondaryDark,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppTheme.accentCyan),
                    ),
                  ),
                ),
              ],
          ],
        ),
      ),
    );
  }
}