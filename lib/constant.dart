import 'package:flutter/material.dart';


class AppStyle{
  static TextStyle h1 = TextStyle(
    fontFamily: 'Sen', fontSize: 70, color: Colors.white,
  );
  static TextStyle h2 = TextStyle(
    fontFamily: 'Sen', fontSize: 40, color: Colors.white,
  );
  static TextStyle h3 = TextStyle(
    fontFamily: 'Sen', fontSize: 25, color: Colors.white,
  );
  static TextStyle h4 = TextStyle(
    fontFamily: 'Sen', fontSize: 18, color: Colors.white,
  );
  static TextStyle h5 = TextStyle(
    fontFamily: 'Sen', fontSize: 12, color: Colors.white,
  );
}

class AppColors {
  static const Color primaryColor = Color(0xffABC4FF);
  static const Color blackGrey = Color(0xff777777);
  static const Color secondColor = Color(0xffEDF2FB);
  static const Color textColor = Color(0xff211500);
  static const Color lighBlue = Color(0xffD7E3FC);
  static const Color greyText = Color(0xff898788);
  static const Color lightGrey = Color(0xffB2B6BD);
}

class AppAssets{
  static const String imagePath = "assets/images/";
  static const String rightArrow = imagePath + "right_arrow.png";
  static const String leftArrow = imagePath + "left_arrow.png";
  static const String heart = imagePath + "heart.png";
  static const String exchange = imagePath + "exchange.png";
  static const String menu = imagePath + "menu.png";


}