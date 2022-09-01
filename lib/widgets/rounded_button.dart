import 'package:flutter/material.dart';
import 'package:lesson2/constant.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({ 
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.paddingVt = 15,
    this.paddingHr = 60,
    this.textColor = Colors.black54


  }) : super(key: key);

  final String? text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double paddingVt;
  final double paddingHr;
  final Color textColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: TextButton(
        style: TextButton.styleFrom(
          shadowColor: Colors.black54,
          elevation: 10,
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(vertical: paddingVt, horizontal: paddingHr),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        onPressed: onPressed,
        child: Text(text!, style: AppStyle.h4.copyWith(
          color: textColor,
          fontSize: 22
        )),
      ),
    );
  }
}