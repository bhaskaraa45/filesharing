import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EndDrawer extends StatefulWidget {
  const EndDrawer({super.key});

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Drawer());
  }
}
