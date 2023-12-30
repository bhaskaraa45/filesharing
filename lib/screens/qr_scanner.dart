import 'dart:typed_data';

import 'package:filesharing/colors.dart';
import 'package:filesharing/screens/after_scan.dart';
import 'package:filesharing/screens/web_get.dart';
import 'package:filesharing/widgets/overlay.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;
  bool isDetected = false;
  String fetchedUrl = '';

  @override
  void initState() {
    _screenWasClosed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors().textColor.withOpacity(0.5),
        body: Stack(
          children: [
            MobileScanner(
              // allowDuplicates: false,
              controller: cameraController,
              // onDetect: ,
              onDetect: _foundBarcode,
            ),
            QRScannerOverlay(
                onTap: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                      isDismissible: false,
                      enableDrag: false,
                      context: context,
                      builder: (ctx) => const WebGetSheet());
                },
                overlayColour: MyColors().textColor.withOpacity(0.35))
          ],
        ));
  }

  void _foundBarcode(BarcodeCapture capture) async {
    if (!isDetected) {
      final List<Barcode> barcodes = capture.barcodes;
      final Uint8List? image = capture.image;
      for (final barcode in barcodes) {
        debugPrint('Barcode found! ${barcode.rawValue}');
        if (regularExpressionMatch(barcode.rawValue ?? '')) {
          setState(() {
            fetchedUrl = barcode.rawValue ?? '';
            isDetected = true;
          });
          Navigator.pop(context);
          showModalBottomSheet(
              isDismissible: false,
              enableDrag: false,
              context: context,
              builder: (ctx) {
                return AfterScanSheet(
                  url: fetchedUrl,
                );
              });
        }
      }

      // Navigator.pop(context);
    }
  }

  regularExpressionMatch(String input) {
    RegExp regExp = RegExp(
        r'^http:\/\/((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?):\d{1,5}\/getFile$');
    return regExp.hasMatch(input);
  }

  void _screenWasClosed() {
    _screenOpened = false;
  }
}
