import 'dart:io';
import 'dart:convert';

class FileSender {
  Future<String> readFileContent(String filePath) async {
    try {
      File file = File(filePath);

      if (await file.exists()) {
        var fileStream = file.openRead();
        var contentBuffer = StringBuffer();

        await for (List<int> chunk in fileStream) {
          contentBuffer.write(base64Encode(chunk));
        }

        return contentBuffer.toString();
      } else {
        throw Exception('File not found: $filePath');
      }
    } catch (e) {
      print('Error reading file content: $e');
      throw e;
    }
  }

  void sendFile(String receiverClientId, String filePath) async {
    try {
      String fileName = filePath.split(Platform.pathSeparator).last;
      String fileContent = await readFileContent(filePath);

      // Assuming connectedClients is a Map<String, WebSocket> where keys are client IDs
      // WebSocket receiverWebSocket = connectedClients[receiverClientId];

      // if (receiverWebSocket != null) {
      //   receiverWebSocket.add(json.encode({
      //     'action': 'receiveFile',
      //     'sender': 'user2',  // Sender's identifier
      //     'fileName': fileName,
      //     'fileContent': fileContent,
      //   }));
      // } else {
      //   print('Receiver not found: $receiverClientId');
      // }
    } catch (e) {
      print('Error sending file: $e');
    }
  }
}
