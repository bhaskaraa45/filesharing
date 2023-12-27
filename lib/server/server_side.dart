import 'dart:io';

class ServerSide {
  void hostServer(String filePath) async {
    String ipAddress = "0.0.0.0";
    int port = 8000;
    // Start the server
    HttpServer server = await HttpServer.bind(ipAddress, port, shared: true);
    print("Local server is running on http://$ipAddress:$port");

    await for (HttpRequest request in server) {
      handleRequest(request, filePath);
    }
  }

  void handleRequest(HttpRequest request, String filePath) {
    try {
      if (request.method == 'GET') {
        if (request.uri.path == '/getFile') {
          serveFile(request, filePath);
        } else {
          // Handle other types of requests as needed
          request.response
            ..statusCode = HttpStatus.notFound
            ..write('Not Found')
            ..close();
        }
      } else {
        request.response
          ..statusCode = HttpStatus.methodNotAllowed
          ..write('Method not allowed')
          ..close();
      }
    } catch (e) {
      print('Exception during request handling: $e');
    }
  }

  void serveFile(HttpRequest request, String filePath) async {
    File fileToServe = File(filePath);

    if (fileToServe.existsSync()) {
      var fileStream = fileToServe.openRead();

      request.response.headers
        ..add('Content-Type', 'application/octet-stream')
        ..add('Content-Disposition',
            'attachment; filename="${fileToServe.uri.pathSegments.last}"');

      await fileStream.pipe(request.response);

      await request.response.close();
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('File not found')
        ..close();
    }
  }
}
