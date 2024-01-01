import 'package:filesharing/colors.dart';
import 'package:filesharing/provider/port_provider.dart';
import 'package:filesharing/server/wifi_info.dart';
import 'package:filesharing/widgets/svg_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EndDrawer extends ConsumerStatefulWidget {
  const EndDrawer({super.key});

  @override
  ConsumerState<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends ConsumerState<EndDrawer> {
  getIpV4Address() async {
    String ip = await WifiInfo().getIpV4Address();
    setState(() {
      iPv4 = ip;
    });
  }

  String iPv4 = 'undefined';
  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      getIpV4Address();
    }
  }

  @override
  Widget build(BuildContext context) {
    String name = ref.watch(usernameProvider) ?? 'User';
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: MyColors().primary,
      content: Stack(
        alignment: Alignment.topRight,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(42),
              child: Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                    color: MyColors().white_,
                    borderRadius: BorderRadius.circular(42)),
                child: const Icon(Icons.close),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: size.height * 0.25,
                  width: double.infinity,
                  child: Center(child: userDetails(name, size)))
            ],
          ),
        ],
      ),
    );
  }

  Widget userDetails(String name, Size size) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.topCenter,
          height: size.height * 0.08,
          width: size.height * 0.08,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.height * 0.05),
              color: MyColors().box1MainColor.withOpacity(0.6)),
          child: const Center(
            child: SvgIcon(
              'assets/icons/user_white_bg.svg',
              size: 52,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: MyColors().white_,
                        fontSize: 21,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                // const SizedBox(width: 5,),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      showNameChangeDialog(size, name);
                    },
                    borderRadius: BorderRadius.circular(36),
                    child: Container(
                      padding: const EdgeInsets.only(top: 4),
                      margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: const SvgIcon(
                        'assets/icons/Pen.svg',
                        size: 19,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    'IP Address: $iPv4',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: MyColors().white_,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: iPv4));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Center(
                        child: Text('Copied!'),
                      )));
                    },
                    borderRadius: BorderRadius.circular(36),
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: const Icon(
                          Icons.copy_rounded,
                          size: 18,
                          color: Color(0xffC7C7C7),
                        )),
                  ),
                )
              ],
            ),
          ],
        )
      ],
    );
  }

  showNameChangeDialog(Size size, String name) {
    TextEditingController controller = TextEditingController(text: name);
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Container(
              height: 8,
            ),
            backgroundColor: MyColors().primary,
            content: content(size, controller),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: MyColors().white_),
                  )),
              TextButton(
                  onPressed: () async {
                    if (controller.text.trim().isNotEmpty) {
                      ref.watch(usernameProvider.notifier).state =
                          controller.text.trim();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('name', controller.text.trim());
                      if (mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Center(
                          child: Text('Your name has been changed'),
                        )));
                      }
                    }
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: MyColors().white_),
                  ))
            ],
          );
        });
  }

  Widget content(Size size, TextEditingController controller) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Name can\'t be null';
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        style: TextStyle(
            color: MyColors().white_,
            fontSize: 18,
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          label: const Text('Enter New Name'),
          labelStyle: TextStyle(color: MyColors().white_),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: MyColors().white_,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: MyColors().white_,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: MyColors().white_,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
