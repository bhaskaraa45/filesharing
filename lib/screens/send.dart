import 'dart:io';

import 'package:filesharing/colors.dart';
import 'package:filesharing/screens/qr_gen.dart';
import 'package:filesharing/server/wifi_info.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:path/path.dart';

class SendScreen extends StatefulWidget {
  const SendScreen({super.key, required this.file, required this.width});
  final File file;
  final double width;

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  String fileLength = '0 B';
  String ipAddress = 'localhost';

  @override
  void initState() {
    super.initState();
    getLength(widget.file);
    getIp();
  }

  getIp() async {
    String iPv4 = await WifiInfo().getIpV4Address();
    setState(() {
      ipAddress = iPv4;
    });
  }

  Widget sendButton(Size size, BuildContext context) {
    return Container(
      width: size.width * 0.4 > 280 ? 280 : size.width * 0.4,
      // height: size.width*0.15 ,
      height: size.width * 0.15 > 80 ? 80 : size.width * 0.15,
      decoration: BoxDecoration(
          color: MyColors().primary, borderRadius: BorderRadius.circular(12)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
            showModalBottomSheet(
              enableDrag: false,
              isDismissible: false,
                context: context,
                builder: (context) {
                  return QrGenerate(
                    ipAddress: ipAddress,
                  );
                });
          },
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Text(
              'Send',
              style: TextStyle(
                  fontSize: size.width * 0.08 > 56 ? 56 : size.width * 0.08,
                  color: MyColors().white_,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  Widget cancelButton(Size size, BuildContext context) {
    return Container(
      width: size.width * 0.4 > 280 ? 280 : size.width * 0.4,
      height: size.width * 0.15 > 80 ? 80 : size.width * 0.15,
      decoration: BoxDecoration(
          border: Border.all(color: MyColors().primary, width: 1.5),
          color: MyColors().white_,
          borderRadius: BorderRadius.circular(12)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Text(
              'Cancel',
              style: TextStyle(
                  fontSize: size.width * 0.08 > 56 ? 56 : size.width * 0.08,
                  color: MyColors().primary,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: [
      drawerSroke(size),
      Text('Selected Item',
          style: TextStyle(
              color: MyColors().textColor,
              fontSize: size.width * 0.05 > 52 ? 52 : size.width * 0.05,
              fontWeight: FontWeight.w600)),
      // itemCard(widget.file)
      Expanded(child: itemCard(widget.file, size)),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          cancelButton(size, context),
          sendButton(size, context),
        ],
      ),
      const SizedBox(
        height: 16,
      ),
    ]);
  }

  void getLength(File file) async {
    int fileSizeInBytes = await file.length();
    double fileSizeInKB = fileSizeInBytes / 1024;
    double fileSizeInMB = fileSizeInKB / 1024;
    double fileSizeInGB = fileSizeInMB / 1024;

    if (fileSizeInGB > 0.9) {
      setState(() {
        fileLength = '${fileSizeInGB.toStringAsFixed(2)} GB';
      });
    } else if (fileSizeInMB > 1) {
      setState(() {
        fileLength = '${fileSizeInMB.toStringAsFixed(2)} MB';
      });
    } else if (fileSizeInKB > 1) {
      setState(() {
        fileLength = '${fileSizeInKB.toStringAsFixed(2)} KB';
      });
    } else {
      setState(() {
        fileLength = '${fileSizeInBytes..toStringAsFixed(2)} B';
      });
    }
  }

  bool _doesTextOverflow(String text, TextStyle style, double maxWidth) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    return textPainter.didExceedMaxLines;
  }

  Widget textWidget(String text, Size size) {
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        // Check if the text overflows
        bool textOverflows = _doesTextOverflow(
            text,
            TextStyle(
                color: MyColors().textColor,
                fontSize: size.width * 0.048 > 42 ? 42 : size.width * 0.048,
                fontWeight: FontWeight.w400),
            constraints.maxWidth);

        return textOverflows
            ? Marquee(
                text: text,
                style: TextStyle(
                    color: MyColors().textColor,
                    // fontSize: size.width * 0.048,
                    fontSize: size.width * 0.048 > 42 ? 42 : size.width * 0.048,
                    fontWeight: FontWeight.w400),
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                blankSpace: 30.0,
                velocity: 50,
                pauseAfterRound: const Duration(seconds: 1),
                startPadding: 20.0,
                accelerationDuration: const Duration(milliseconds: 1),
                accelerationCurve: Curves.linear,
                decelerationDuration: const Duration(milliseconds: 500),
                decelerationCurve: Curves.easeOut,
              )
            : Container(
                alignment: Alignment.topLeft,
                child: Text(text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: MyColors().textColor,
                        fontSize:
                            size.width * 0.048 > 42 ? 42 : size.width * 0.048,
                        fontWeight: FontWeight.w400)),
              );
      }),
    );
  }

  Widget itemCard(File file, Size size) {
    String fileName = file.uri.pathSegments.last;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(
            maxWidth: 140,
            maxHeight: 140,
          ),
          margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
          alignment: Alignment.topLeft,
          height: size.width * 0.15,
          width: size.width * 0.15,
          // decoration: const BoxDecoration(color: Colors.amber),
          child: iconWidget(size),
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: textWidget(fileName, size)),
              Container(
                  margin: EdgeInsets.fromLTRB(
                      0,
                      size.width * 0.07 > 60 ? 60 + 12 : size.width * 0.07 + 12,
                      0,
                      0),
                  child: Text(fileLength,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: MyColors().textColor.withOpacity(0.8),
                          fontSize:
                              size.width * 0.04 > 36 ? 36 : size.width * 0.04,
                          fontWeight: FontWeight.w400))),
            ],
          ),
        ),
      ],
    );
  }

  Widget iconWidget(Size size) {
    String ext = extension(widget.file.path).toLowerCase();

    if (ext == '.jpg' || ext == '.png' || ext == '.jpeg') {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: MyColors().primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(widget.file)),
      );
    }

    var icondata = getFileType(ext);

    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: MyColors().primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icondata,
          size: size.width * 0.13 > 130 ? 130 : size.width * 0.13,
          color: MyColors().white_,
        ));
  }

  IconData getFileType(String ext) {
    switch (ext) {
      case '.txt':
        return (Icons.title);
      case '.pdf':
      case '.doc':
      case '.docx':
        return (Icons.description);
      case '.mp3':
        return (Icons.music_note);
      case '.mp4':
      case '.mkv':
        return (Icons.movie_creation_outlined);
      default:
        return (Icons.file_copy_rounded);
    }
  }

  // Widget selectedFiles() {
  //   return ListView.builder(
  //     itemCount: widget.file.,
  //     itemBuilder: (context, index) {
  //     return null;
  //   });
  // }

  Widget drawerSroke(Size size) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      height: 5,
      width: size.width * 0.2,
      decoration: BoxDecoration(
          color: MyColors().textColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(100)),
    );
  }
}
