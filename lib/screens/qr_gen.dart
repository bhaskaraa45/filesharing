import 'dart:io';

import 'package:filesharing/colors.dart';
import 'package:filesharing/provider/port_provider.dart';
import 'package:filesharing/server/server_side.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGenerate extends ConsumerStatefulWidget {
  const QrGenerate({
    super.key,
    required this.ipAddress,
  });
  final String ipAddress; //TODO: add null safety , (later)
  // final int port;

  @override
  ConsumerState<QrGenerate> createState() => _QrGenerateState();
}

class _QrGenerateState extends ConsumerState<QrGenerate> {
  Widget content(Size size, int port) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(18, 12, 18, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
                text: TextSpan(
                    text: "Scan this QR (You can use any Scanner, ",
                    style: TextStyle(
                      color: MyColors().textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                  TextSpan(
                    text: "prefer our app",
                    style: TextStyle(
                      color: MyColors().primary,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text:
                        ") or you can open the below link on your favourite browser to get the",
                    style: TextStyle(
                      color: MyColors().textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: " shared file",
                    style: TextStyle(
                      color: MyColors().primary,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ])),
            SelectableText(
              "\nhttp://${widget.ipAddress}:$port/getFile",
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Spacer(),
            const SizedBox(
              height: 48,
            ),
            closeServer(size),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget closeServer(Size size,) {
    return Container(
      width: double.infinity,
      height: size.width * 0.13 > 76 ? 76 : size.width * 0.13,
      decoration: BoxDecoration(
          color: MyColors().white_,
          border: Border.all(color: MyColors().primary),
          borderRadius: BorderRadius.circular(36)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            //TODO:close server
            ServerSide(
              ref
            ).closeServer();
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(36),
          child: Center(
            child: Text('Close Server',
                style: TextStyle(
                  fontSize: size.width * 0.07 > 52 ? 52 : size.width * 0.07,
                  color: MyColors().primary,
                  fontWeight: FontWeight.w500,
                )),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int port = ref.watch(portProvider);
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          drawerSroke(size),
          const SizedBox(
            height: 8,
          ),
          QrImageView(
            data: 'http://${widget.ipAddress}:$port/getFile',
            version: QrVersions.auto,
            size: 180.0,
          ),
          content(size, port)
        ],
      ),
    );
  }

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
