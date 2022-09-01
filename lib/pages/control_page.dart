import 'package:flutter/material.dart';
import 'package:lesson2/share_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({ Key? key }) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  late SharedPreferences prefs;
  double slideValue = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDefaultValue();
  }
  void initDefaultValue() async {
    prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(ShareKeys.key) ?? 5;
    setState(() {
      slideValue = value.toDouble();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Your control", style: AppStyle.h2.copyWith(color: AppColors.blackGrey)),
        leading: IconButton(
          padding: EdgeInsets.only(left: 20),
          onPressed: () async{
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt(ShareKeys.key, slideValue.toInt());
            Navigator.of(context).pop();
          }, 
          icon: Image.asset(AppAssets.leftArrow)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Spacer(flex: 1,),
            Text("How much a number words at once?",
              style: AppStyle.h4.copyWith(color: AppColors.lightGrey, fontSize: 20)
            ),
            Spacer(flex: 2,),
            Text("${slideValue.toInt()}",
              style: AppStyle.h1.copyWith(
                color: AppColors.primaryColor, 
                fontWeight: FontWeight.bold,
                fontSize: 120
              )
            ),
            Spacer(flex: 2,),
            Slider(
              value: slideValue, 
              min: 5, max: 100,
              divisions: 100,
              activeColor: AppColors.primaryColor,
              inactiveColor: AppColors.primaryColor,
              onChanged: (value){
                setState(() {
                  slideValue = value;
                });
              }
            ),
            Text("Slide to set value",
              style: AppStyle.h3.copyWith(
                color: AppColors.blackGrey, 
                fontWeight: FontWeight.bold,
                
              )
            ),
            Spacer(flex: 8,)
          ],
        ),
      ),
    );
  }
}