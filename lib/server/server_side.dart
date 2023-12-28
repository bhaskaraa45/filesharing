import 'dart:io';

import 'package:filesharing/provider/port_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServerSide {
  HttpServer? server; // Add a reference to the server instance
  WidgetRef ref;
  ServerSide(this.ref);

  void hostServer(int port) async {
    await closeServer();

    String ipAddress = "0.0.0.0";

    // Start the server
    server = await HttpServer.bind(ipAddress, port, shared: true);
    print("Local server is running on http://$ipAddress:$port");

    await for (HttpRequest request in server!) {
      handleRequest(request);
    }
  }

  void handleRequest(HttpRequest request) {
    try {
      if (request.method == 'GET') {
        if (request.uri.path == '/getFile') {
          serveFile(request);
        } else {
          // Handle other types of requests as needed
          request.response
            ..statusCode = HttpStatus.notFound
            ..write('Endpoint Not Found, please recheck it')
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

  void serveFile(HttpRequest request) async {
    String filePath = ref.watch(filePathProvider) ?? '';
    print('server will send this file: $filePath');
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

  // Method to close the server
  Future<void> closeServer() async {
    if (server != null) {
      await server!.close();
      print('Server closed.');
    }
  }
}
