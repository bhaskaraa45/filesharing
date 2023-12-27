import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ClientSide {
//   connectToServer(String ipAddress, int port) async {
//     String serverUrl = 'http://$ipAddress:$port';
//     final Uri downloadFileUri = Uri.parse('$serverUrl/getFiles');
//     downloadFile(downloadFileUri);
//   }

//   Future<void> downloadFile(Uri downloadFileUri) async {
//   try {
//     final http.Client client = http.Client();
//     final http.Response response = await client.get(downloadFileUri);

//     print(response.statusCode);

//     if (response.statusCode == 200) {
//       // Save the file locally (replace 'path/to/save/file' with the desired local path)
//       Directory directory = await getDirectory();
//       File file = File(
//           '${directory.path}/${response.headers['content-disposition']!.split('"')[1]}');

//       // Open a file for writing
//       RandomAccessFile outputFile = await file.open(mode: FileMode.write);

//       // Write received bytes to the file
//       http.ByteStream(response.bodyBytes as Stream<List<int>>).listen(
//         (List<int> chunk) {
//           outputFile.writeFrom(Uint8List.fromList(chunk));
//           showDownloadProgress(outputFile.lengthSync(), response.contentLength);
//         },
//         onDone: () {
//           // Close the file when download is complete
//           outputFile.close();
//           client.close();
//           print('File downloaded successfully: ${file.path}');
//         },
//         onError: (error) {
//           // Handle error
//           print('Error during file download: $error');
//         },
//         cancelOnError: true,
//       );
//     } else {
//       // Handle error
//       print('Error downloading file: ${response.statusCode}');
//     }
//   } catch (e) {
//     // Handle exception
//     print('Exception during file download: $e');
//   }
// }

//   void showDownloadProgress(int received, int? total) {
//     total = total ?? -1;
//     if (total != -1) {
//       // Calculate the download percentage
//       double percentage = (received / total) * 100;
//       print('Download progress: ${percentage.toStringAsFixed(2)}%');
//     } else {
//       print('Download progress: $received bytes received');
//     }
//   }

//   Future<Directory> getDirectory() async {
//     Directory directory;

//     // Check for external storage permissions on Android 10+
//     if (Platform.isAndroid && await Permission.storage.request().isGranted) {
//       directory = await getExternalStorageDirectory() ??
//           Directory('/storage/emulated/0/aa45/download/');
//     } else {
//       directory = await getApplicationDocumentsDirectory();
//     }

//     print(directory.path);

//     return directory;
//   }
}
