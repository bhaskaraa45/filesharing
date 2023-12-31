import 'package:filesharing/colors.dart';
import 'package:filesharing/provider/port_provider.dart';
import 'package:filesharing/server/wifi_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SideDrawer extends ConsumerStatefulWidget {
  const SideDrawer({super.key});

  @override
  ConsumerState<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends ConsumerState<SideDrawer> {
  getIpV4Address() async {
    String ip = await WifiInfo().getIpV4Address();
    setState(() {
      IPv4 = ip;
    });
  }

  String IPv4 = 'undefined';
  @override
  void initState() {
    super.initState();
    getIpV4Address();
  }

  @override
  Widget build(BuildContext context) {
    String name = ref.watch(usernameProvider) ?? 'User';
    return SafeArea(
        child: Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text(
                name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              accountEmail: SelectableText(
                IPv4,
                style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300),
              )),
        ],
      ),
    ));
  }
}
