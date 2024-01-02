import 'package:flutter/material.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  String getDownloadLink(String os) {
    switch (os) {
      case 'android':
        return '';
      case 'linux':
        return '';
      case 'windows':
        return '';
      default: return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Downloads Screen')
          ],
        )
      )
    );
  }
}
