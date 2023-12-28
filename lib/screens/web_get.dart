import 'package:filesharing/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class WebGetSheet extends StatefulWidget {
  const WebGetSheet({super.key});

  @override
  State<WebGetSheet> createState() => _WebGetSheetState();
}

class _WebGetSheetState extends State<WebGetSheet> {
  TextEditingController ipController = TextEditingController();
  TextEditingController portController = TextEditingController();
  bool isEnable = false;

  changeButtonStatue(String str) {
    if (regularExpressionMatch(ipController.text) &&
        portValidation(portController.text)) {
      setState(() {
        isEnable = true;
      });
    } else {
      setState(() {
        isEnable = false;
      });
    }
  }

  void openTheUrl() async {
    String url = getUrl();
    Uri uri = Uri.parse(url);
    await launchUrl(uri);
  }

  urlMatch(String input) {
    RegExp regExp = RegExp(
        r'^http:\/\/((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?):\d{1,5}\/getFile$');
    return regExp.hasMatch(input);
  }

  getUrl() {
    String url = 'http://${ipController.text}:${portController.text}/getFile';
    if (urlMatch(url)) {
      return url;
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Center(
        child: Text('Something went wrong!'),
      )));
    }
  }

  bool regularExpressionMatch(String input) {
    RegExp regExp = RegExp(
        r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
    return regExp.hasMatch(input);
  }

  bool portValidation(String portString) {
    RegExp portPattern = RegExp(r'^[1-9]\d*$');

    if (portPattern.hasMatch(portString)) {
      int portNumber = int.parse(portString);
      if (portNumber >= 1 && portNumber <= 65535) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
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
          TextFormField(
            onChanged: (value) {
              changeButtonStatue(value);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return null;
              } else {
                if (!regularExpressionMatch(value)) {
                  return 'Invalid IPv4 address';
                }
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: ipController,
            keyboardType: TextInputType.number,
            cursorColor: MyColors().secondary,
            decoration: InputDecoration(
              hintText: 'Enter IP address e.g., 192.168.0.1',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: BorderSide(
                  color: MyColors().primary,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: BorderSide(
                  color: MyColors().primary,
                  width: 2.5,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: BorderSide(
                  color: MyColors().primary,
                  width: 1.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            onChanged: (value) {
              changeButtonStatue(value);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return null;
              } else {
                if (!portValidation(value)) {
                  return 'Invalid Port';
                }
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: portController,
            keyboardType: TextInputType.number,
            cursorColor: MyColors().secondary,
            decoration: InputDecoration(
              hintText: 'Enter Port eg. 8080',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: BorderSide(
                  color: MyColors().primary,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: BorderSide(
                  color: MyColors().primary,
                  width: 2.5,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: BorderSide(
                  color: MyColors().primary,
                  width: 1.0,
                ),
              ),
            ),
          ),
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
          color: isEnable
              ? MyColors().primary
              : MyColors().textColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(36)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnable
              ? () {
                  openTheUrl();
                  // Navigator.pop(context);
                }
              : null,
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
        children: [
          drawerSroke(size),
          content(),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              cancelButton(size, context),
              getButton(size, context),
            ],
          ),
          const SizedBox(
            height: 22,
          ),
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
