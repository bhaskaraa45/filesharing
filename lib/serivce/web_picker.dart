import 'dart:async';
// import 'dart:html' as html;
import "package:universal_html/html.dart" as html;

class WebPicker {
  Future<List<html.File>> pickFiles() async {
    final html.FileUploadInputElement input = html.FileUploadInputElement()
      ..multiple = true;

    final completer = Completer<List<html.File>>();

    input.onChange.listen((event) {
      final List<html.File> files = input.files!;

      completer.complete(files);
    });

    input.click();

    return completer.future;
  }

  Future<List<html.File>> pickFilesWithSpecificType(String type) async {
    final html.FileUploadInputElement input = html.FileUploadInputElement()
      ..multiple = true
      ..accept = type;

    final completer = Completer<List<html.File>>();

    input.onChange.listen((event) {
      final List<html.File> files = input.files!;

      completer.complete(files);
    });

    input.click();

    return completer.future;
  }

  Future<List<html.File>> pickVideos() async {
    final List<html.File> videoFiles =
        await pickFilesWithSpecificType('video/*');
    return videoFiles;
  }

  Future<List<html.File>> pickImages() async {
    final List<html.File> imageFiles =
        await pickFilesWithSpecificType('image/*');
    return imageFiles;
  }

  Future<List<html.File>> pickMusic() async {
    final List<html.File> audioFiles =
        await pickFilesWithSpecificType('audio/*');
    return audioFiles;
  }
}
