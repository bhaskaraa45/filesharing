// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:io';
import 'package:filesharing/provider/port_provider.dart';
import 'package:filesharing/screens/drawer.dart';
import 'package:filesharing/screens/end_drawer.dart';
import 'package:filesharing/screens/qr_scanner.dart';
import 'package:filesharing/screens/qr_scanner.dart';
import 'package:filesharing/screens/send.dart';
import 'package:filesharing/screens/web_get.dart';
import 'package:filesharing/server/server_side.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:universal_html/html.dart" as html;
import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:filesharing/colors.dart';
import 'package:filesharing/widgets/boxes_widget.dart';
import 'package:filesharing/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isFileSelected = false;
  File? selectedFile;
  List<html.File> selectedFilesWeb = [];

  Future<void> pickMultipleFiles(BuildContext context) async {
    // Show circular progress indicator while waiting for file picker result
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: false);

      if (result != null) {
        File file = File(result.files.single.path!);
        setState(() {
          selectedFile = file;
          isFileSelected = true;
        });
      } else {
        // User canceled the picker
        setState(() {
          selectedFile = null;
          isFileSelected = false;
        });
      }
    } finally {
      // Close the progress indicator dialog
      if (mounted) {
        Navigator.of(context).pop();
      }
    }

    // Continue with the rest of your logic
    showSendModal();
  }

  showSendModal() {
    if (isFileSelected) {
      showModalBottomSheet(
          isDismissible: false,
          context: context,
          builder: (context) {
            return SendScreen(
              ref: ref,
              width: MediaQuery.of(context).size.width,
              file: selectedFile ?? File(''),
            );
          });
    }
  }

  Future<void> pickMultipleFilesWithSpecificType(FileType type) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: false, type: type);
      if (result != null) {
        File file = File(result.files.single.path!);
        setState(() {
          selectedFile = file;
          isFileSelected = true;
        });
      } else {
        // User canceled the picker
        setState(() {
          selectedFile = null;
          isFileSelected = false;
        });
      }
    } finally {
      if (mounted) {
        Navigator.of(context).pop();
      }
    }

    showSendModal();
  }

  List<Color> bgColors = [
    MyColors().box1,
    MyColors().box2,
    MyColors().box3,
    MyColors().box4,
  ];
  List<Color> colors = [
    MyColors().box1MainColor,
    MyColors().box2MainColor,
    MyColors().box3MainColor,
    MyColors().box4MainColor,
  ];
  List<IconData> icons = [
    Icons.play_arrow,
    Icons.music_note,
    Icons.image,
    Icons.file_present_rounded,
  ];
  List<String> titles = ['Videos', 'Music', "Images", 'Files'];

  Future<void> pickVideos() async {
    // print('Hello World!');
    if (kIsWeb) {
      // List<html.File> files = await webPicker.pickVideos();
      // setState(() {
      //   selectedFilesWeb = files;
      // });
      showCannotSendThroughWeb();
    } else {
      await pickMultipleFilesWithSpecificType(FileType.video);
    }
  }

  Future<void> pickMusic() async {
    if (kIsWeb) {
      // List<html.File> files = await webPicker.pickMusic();
      // setState(() {
      //   selectedFilesWeb = files;
      // });
      showCannotSendThroughWeb();
    } else {
      await pickMultipleFilesWithSpecificType(FileType.audio);
    }
  }

  Future<void> pickImages() async {
    if (kIsWeb) {
      // List<html.File> files = await webPicker.pickImages();
      // setState(() {
      //   selectedFilesWeb = files;
      // });
      showCannotSendThroughWeb();
    } else {
      await pickMultipleFilesWithSpecificType(FileType.image);
    }
  }

  Future<void> pickFiles() async {
    if (kIsWeb) {
      // List<html.File> files = await webPicker.pickFiles();
      // setState(() {
      //   selectedFilesWeb = files;
      // });
      showCannotSendThroughWeb();
    } else {
      await pickMultipleFiles(context);
    }
  }

  void func() {
    print('Hello Web');
  }

  bool isLinkHover = false;
  bool isLinkClicked = false;

  openBrowser() async {
    launchUrlString('http://fileshare-aa45.netlify.app');
  }

  showCannotSendThroughWeb() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(
                'File Share Notice',
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: MyColors().textColor),
              ),
              content: RichText(
                  text: TextSpan(
                      text:
                          'You can receive files through the website. However,',
                      style:
                          TextStyle(fontSize: 16, color: MyColors().textColor),
                      children: [
                    TextSpan(
                      text:
                          ' to send files, please download our mobile or desktop apps.',
                      style: TextStyle(
                          fontSize: 16,
                          color: MyColors().primary,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic),
                    ),
                    TextSpan(
                      text: ' Thank you!',
                      style:
                          TextStyle(fontSize: 16, color: MyColors().textColor),
                    ),
                  ])),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close')),
                TextButton(
                  onPressed: () {
                    //TODO: add download link according to platform
                  },
                  child: Text('Download'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String userName = ref.watch(usernameProvider) ?? 'User';
    return Scaffold(
      drawer: const SideDrawer(),
      endDrawer: const EndDrawer(),
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: MyColors().white_),
      ),
      backgroundColor: MyColors().white_,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                          child: SvgIcon(
                            'assets/icons/hamburger.svg',
                            size: 20,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SvgIcon(
                            'assets/icons/User.svg',
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(8, 32, 8, 0),
                    child: RichText(
                        text: TextSpan(
                            text: "Hello\n",
                            style: TextStyle(
                                fontSize: 28, color: MyColors().textColor),
                            children: <TextSpan>[
                          TextSpan(
                            text: userName,
                            style: TextStyle(
                                fontSize: 32,
                                color: MyColors().textColor,
                                fontWeight: FontWeight.w500),
                          )
                        ])),
                  ),
                  Container(
                    constraints: const BoxConstraints(minHeight: 160),
                    margin: const EdgeInsets.fromLTRB(8, 32, 8, 0),
                    height: height * 0.25,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: MyColors().primary,
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'File Transfer',
                              style: TextStyle(
                                  color: MyColors().white_,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              'Transfer file with friends in quick ways',
                              style: TextStyle(
                                  color: MyColors().white_,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: height * 0.06,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  constraints: const BoxConstraints(minHeight: 30),
                                  height: height * 0.045,
                                  width: width * 0.35,
                                  decoration: BoxDecoration(
                                      color: MyColors().secondary,
                                      borderRadius: BorderRadius.circular(1000)),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        if (kIsWeb) {
                                          showCannotSendThroughWeb();
                                        } else {
                                          pickFiles();
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(1000),
                                      child: Center(
                                        child: Text(
                                          'Send',
                                          style: TextStyle(
                                              color: MyColors().white_,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  constraints: const BoxConstraints(minHeight: 30),
                                  height: height * 0.045,
                                  width: width * 0.35,
                                  decoration: BoxDecoration(
                                      color: MyColors().secondary,
                                      borderRadius: BorderRadius.circular(1000)),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        if (kIsWeb) {
                                          showModalBottomSheet(
                                              isDismissible: false,
                                              enableDrag: false,
                                              context: context,
                                              builder: (ctx) =>
                                                  const WebGetSheet());
                                        } else if (Platform.isAndroid ||
                                            Platform.isIOS) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      const Scanner()));
                                        } else {
                                          showModalBottomSheet(
                                              isDismissible: false,
                                              enableDrag: false,
                                              context: context,
                                              builder: (ctx) =>
                                                  const WebGetSheet());
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(1000),
                                      child: Center(
                                        child: Text(
                                          'Receive',
                                          style: TextStyle(
                                              color: MyColors().white_,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(8, 32, 8, 0),
                    child: Boxes(
                        bgColors: bgColors,
                        colors: colors,
                        count: 4,
                        functionList: [
                          pickVideos,
                          pickMusic,
                          pickImages,
                          pickFiles,
                        ],
                        icons: icons,
                        titles: titles),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(8, 32, 8, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColors().footerBox,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 12, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: width - 130 - 88 - 5,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Web Share',
                                    style: TextStyle(
                                      color: MyColors().primary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Now Easy ways to share files with browser',
                                    style: TextStyle(
                                      color: MyColors().textColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  MouseRegion(
                                    onEnter: (_) {
                                      setState(() {
                                        isLinkHover = true;
                                      });
                                    },
                                    onExit: (_) {
                                      setState(() {
                                        isLinkHover = false;
                                      });
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        openBrowser();
                                        setState(() {
                                          isLinkClicked = true;
                                        });
                                      },
                                      child: Text(
                                        'Click here',
                                        style: TextStyle(
                                          color: isLinkClicked
                                              ? const Color(0xff551A8B)
                                              : const Color(0xff0000EE),
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w400,
                                          decoration: isLinkHover
                                              ? TextDecoration.underline
                                              : null,
                                          decorationColor: isLinkClicked
                                              ? const Color(0xff551A8B)
                                              : const Color(0xff0000EE),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                            Container(
                              width: 130,
                              child: Image.asset('assets/icons/web.png'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // showImage()
                ],
              ),
            );
          }
        ),
      )),
    );
  }
}
