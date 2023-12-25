import 'dart:ui' as ui;
import 'package:filesharing/colors.dart';
import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree
// CustomPaint(
//     size: Size(WIDTH, (WIDTH*1.513953488372093).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
//     painter: RPSCustomPainter(),
// )

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
            
Path path_0 = Path();
    path_0.moveTo(size.width*1.021065,size.height*0.4815422);
    path_0.cubicTo(size.width*1.021065,size.height*0.6834992,size.width*0.6257395,size.height*0.9230353,size.width*0.2134202,size.height*0.9767097);
    path_0.cubicTo(size.width*0.06990209,size.height*0.9953917,size.width*-0.2930884,size.height*1.055842,size.width*-0.1812607,size.height*0.8479263);
    path_0.cubicTo(size.width*-0.1812607,size.height*0.6459693,size.width*-0.07618605,size.height*0.1158661,size.width*0.3142023,size.height*0.1158661);
    path_0.cubicTo(size.width*0.7045930,size.height*0.1158661,size.width*1.021065,size.height*0.2795853,size.width*1.021065,size.height*0.4815422);
    path_0.close();

Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
paint_0_fill.color = MyColors().secondary.withOpacity(1.0);
canvas.drawPath(path_0,paint_0_fill);

Paint paint_1_fill = Paint()..style=PaintingStyle.fill;
paint_1_fill.color =  MyColors().secondary.withOpacity(1.0);
canvas.drawRect(Rect.fromLTWH(size.width*0.002189884,size.height*0.03379416,size.width*1.005070,size.height*0.5124931),paint_1_fill);

Path path_2 = Path();
    path_2.moveTo(size.width*1.020930,size.height*0.4400676);
    path_2.cubicTo(size.width*1.020930,size.height*0.6420246,size.width*0.6256047,size.height*0.8815607,size.width*0.2132856,size.height*0.9352350);
    path_2.cubicTo(size.width*0.06976744,size.height*0.9539171,size.width*-0.2932233,size.height*1.014367,size.width*-0.1813953,size.height*0.8064516);
    path_2.cubicTo(size.width*-0.1813953,size.height*0.6044946,size.width*-0.07632070,size.height*0.07439140,size.width*0.3140674,size.height*0.07439140);
    path_2.cubicTo(size.width*0.7044581,size.height*0.07439140,size.width*1.020930,size.height*0.2381106,size.width*1.020930,size.height*0.4400676);
    path_2.close();

Paint paint_2_fill = Paint()..style=PaintingStyle.fill;
paint_2_fill.color =  MyColors().primary.withOpacity(1.0);
canvas.drawPath(path_2,paint_2_fill);

Paint paint_3_fill = Paint()..style=PaintingStyle.fill;
paint_3_fill.color =  MyColors().primary.withOpacity(1.0);
canvas.drawRect(Rect.fromLTWH(size.width*-0.1767442,size.height*-0.007680492,size.width*1.300000,size.height*0.5130568),paint_3_fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
}
}