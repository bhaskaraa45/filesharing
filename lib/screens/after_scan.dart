import 'package:filesharing/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AfterScanSheet extends StatefulWidget {
  const AfterScanSheet({super.key, required this.url});
  final String url;

  @override
  State<AfterScanSheet> createState() => _AfterScanSheetState();
}

class _AfterScanSheetState extends State<AfterScanSheet> {
  String getIpAddress(String url) {
    Uri uri = Uri.parse(url);
    String ipAddress = uri.host;
    return ipAddress;
  }

  int getPort(String url) {
    Uri uri = Uri.parse(url);
    if (uri.hasPort) {
      return uri.port;
    }
    return 8080;
  }

  void openTheUrl() async{
    Uri uri = Uri.parse(widget.url);
    await launchUrl(uri);
  }

  Widget content() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
            text:
                "**Make sure your connect with the file sender through local network.",
            style: TextStyle(
                color: MyColors().box1MainColor,
                fontStyle: FontStyle.italic,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          )),
          const SizedBox(
            height: 40,
          ),
          SelectableText.rich(TextSpan(
              text: "Local IP address:  ",
              style: TextStyle(
                  color: MyColors().textColor,
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
              children: [
                TextSpan(
                  text: getIpAddress(widget.url),
                  style: TextStyle(
                      color: MyColors().primary,
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: '\nPort: ',
                  style: TextStyle(
                      color: MyColors().textColor,
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  text: '${getPort(widget.url)}',
                  style: TextStyle(
                      color: MyColors().primary,
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ])),
        ],
      ),
    );
  }

  Widget getButton(Size size, BuildContext context) {
    return Container(
      width: size.width * 0.4 > 280 ? 280 : size.width * 0.4,
      // height: size.width*0.15 ,
      height: size.width * 0.12 > 72 ? 72 : size.width * 0.12,
      decoration: BoxDecoration(
          color: MyColors().primary, borderRadius: BorderRadius.circular(36)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            openTheUrl();
            // Navigator.pop(context);
            // showModalBottomSheet(
            //   enableDrag: false,
            //   isDismissible: false,
            //     context: context,
            //     builder: (context) {
            //       return QrGenerate(
            //         ipAddress: ipAddress,
            //       );
            //     });
          },
          borderRadius: BorderRadius.circular(36),
          child: Center(
            child: Text(
              'Accept',
              style: TextStyle(
                  fontSize: size.width * 0.06 > 42 ? 42 : size.width * 0.06,
                  color: MyColors().white_,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }

  Widget cancelButton(Size size, BuildContext context) {
    return Container(
      width: size.width * 0.4 > 280 ? 280 : size.width * 0.4,
      height: size.width * 0.12 > 72 ? 72 : size.width * 0.12,
      decoration: BoxDecoration(
          border: Border.all(color: MyColors().primary, width: 1.5),
          color: MyColors().white_,
          borderRadius: BorderRadius.circular(36)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(36),
          child: Center(
            child: Text(
              'Cancel',
              style: TextStyle(
                  fontSize: size.width * 0.06 > 42 ? 42 : size.width * 0.06,
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
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          drawerSroke(size),
          content(),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              cancelButton(size, context),
              getButton(size, context),
            ],
          ),
          const SizedBox(
            height: 20,
          )
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
