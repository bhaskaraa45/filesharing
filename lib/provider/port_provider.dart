import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final portProvider = StateProvider<int>((ref) => 8080);
final serverProvider = StateProvider<HttpServer?>((ref) => null);
final filePathProvider = StateProvider<String?>((ref) => null);
final usernameProvider = StateProvider<String?>((ref) => null);

final portOtp =
    StateProvider<List<int>>((ref) => [8080, 3000, 8000, 8888, 5000, 10000, 20000]);
