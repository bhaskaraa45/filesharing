import 'package:filesharing/colors.dart';
import 'package:flutter/material.dart';

class Boxes extends StatelessWidget {
  const Boxes({
    super.key,
    required this.bgColors,
    required this.colors,
    required this.count,
    required this.functionList,
    required this.icons,
    required this.titles,
  });
  final int count;
  final List<Color> colors;
  final List<Color> bgColors;
  final List<IconData> icons;
  final List<String> titles;
  final List<VoidCallback> functionList;

  Widget oneBox(Color bgColor, Color color, IconData icon, String title,
      VoidCallback onTap, Size size) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
          height: size.width * 0.17,
          width: (size.width - 74) / 2,
          decoration: BoxDecoration(
              color: bgColor, borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: size.width * 0.03,
              ),
              Container(
                  height: size.width * 0.13,
                  width: size.width * 0.13,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ], color: color, borderRadius: BorderRadius.circular(100000)),
                  child: Icon(
                    icon,
                    color: MyColors().white_,
                    size: size.width * 0.1,
                  )),
              SizedBox(
                width: size.width * 0.02,
              ),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: size.width * 0.05,
                      color: color,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          )),
    );
  }

  Widget twoBoxes(int i, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        oneBox(
            bgColors[i], colors[i], icons[i], titles[i], functionList[i], size),
        oneBox(bgColors[i + 1], colors[i + 1], icons[i + 1], titles[i + 1],
            functionList[i + 1], size)
      ],
    );
  }

  List<Widget> listOfItems(Size size) {
    return [
      for (int i = 0; i < count - 1; i += 2) ...[
        twoBoxes(i, size),
        SizedBox(
          height: size.height * 0.008,
        ),
      ]
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: listOfItems(size),
    );
  }
}
