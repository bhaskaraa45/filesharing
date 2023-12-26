import 'package:filesharing/colors.dart';
import 'package:filesharing/widgets/boxes_widget.dart';
import 'package:filesharing/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    Icons.play_arrow,
    Icons.play_arrow,
    Icons.play_arrow,
  ];
  List<String> titles = ['Videos', 'Music', "Images", 'Files'];

  void func() {
    print('Hello World!');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: MyColors().primary),
      ),
      backgroundColor: MyColors().white_,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
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
                      onTap: () {},
                      borderRadius: BorderRadius.circular(14),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SvgIcon(
                          'assets/icons/search-normal.svg',
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
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
                        text: "Bhaskar Mandal",
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
                            InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(1000),
                              child: Container(
                                constraints:
                                    const BoxConstraints(minHeight: 30),
                                height: height * 0.045,
                                width: width * 0.35,
                                decoration: BoxDecoration(
                                    color: MyColors().secondary,
                                    borderRadius: BorderRadius.circular(1000)),
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
                            InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(1000),
                              child: Container(
                                constraints:
                                    const BoxConstraints(minHeight: 30),
                                height: height * 0.045,
                                width: width * 0.35,
                                decoration: BoxDecoration(
                                    color: MyColors().secondary,
                                    borderRadius: BorderRadius.circular(1000)),
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
                    functionList: [func, func, func, func],
                    icons: icons,
                    titles: titles),
              )
            ],
          ),
        ),
      )),
    );
  }
}
