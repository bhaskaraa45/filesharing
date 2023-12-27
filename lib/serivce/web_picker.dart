import 'dart:async';
// import 'dart:html' as html;
import "package:universal_html/html.dart" as html;

class WebPicker {
  Future<List<html.File>> pickFiles() async {
    final html.FileUploadInputElement input = html.FileUploadInputElement()..multiple = true;

    final completer = Completer<List<html.File>>();

    input.onChange.listen((event) {
      final List<html.File> files = input.files!;

      completer.complete(files);

      for (var file in files) {
        print('File picked: ${file.name}');
      }
    });

    input.click();

    return completer.future;
  }
}
