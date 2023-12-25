import 'package:filesharing/colors.dart';
import 'package:filesharing/widgets/clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: MyColors().primary),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          CustomPaint(
            size: Size(
                width,
                (width * 1.513953488372093)
                    .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
            painter: RPSCustomPainter(),
          ),
        ],
      )),
    );
  }
}
