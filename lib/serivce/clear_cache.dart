import 'package:filesharing/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

class ClearCachedFiles {
  void clearCachedFiles() async {
    // _resetState();
    try {
      bool? result = await FilePicker.platform.clearTemporaryFiles();
    } on PlatformException catch (e) {
      // _logException('Unsupported operation' + e.toString());
    } catch (e) {
      // _logException(e.toString());
    } finally {
      // setState(() => _isLoading = false);
    }
  }
}