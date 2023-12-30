import 'package:filesharing/provider/port_provider.dart';
import 'package:filesharing/screens/home.dart';
import 'package:filesharing/serivce/clear_cache.dart';
import 'package:filesharing/serivce/device_info.dart';
import 'package:filesharing/server/wifi_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    // permission();
    getName();
    ClearCachedFiles().clearCachedFiles();
  }

  // permission() async {
  //   var status = await Permission.storage.request();
  //   if (status != PermissionStatus.granted) {
  //     print('Permission denied');
  //     return;
  //   }
  // }
  getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('name');

    if (username != null) {
      ref.read(usernameProvider.notifier).state = username;
    } else {
      String defaultName = await getDeviceDetails();
      if (defaultName == 'null') {
        String ip = await WifiInfo().getIpV4Address();
        // setState(() {
          defaultName = 'User-$ip';
        // });
      }
      ref.read(usernameProvider.notifier).state = defaultName;
      await prefs.setString('name', defaultName);
    }
  }

  getDeviceDetails() async {
    Map<String, dynamic> info = await DeviceInfo().initPlatformState();
    String userName = '${info['name']}';
    return userName;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'File Sharing',
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
