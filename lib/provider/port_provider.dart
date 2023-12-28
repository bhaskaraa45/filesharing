import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final portProvider = StateProvider<int>((ref) => 8080);
final serverProvider = StateProvider<HttpServer?>((ref) => null);
final filePathProvider = StateProvider<String?>((ref) => null);
final usernameProvider = StateProvider<String?>((ref) => null);