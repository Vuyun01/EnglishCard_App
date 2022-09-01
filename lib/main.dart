import 'package:flutter/material.dart';
import 'package:lesson2/package/quotes/quote.dart';
import 'constant.dart';
import 'pages/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Quotes().getAll();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: AppColors.primaryColor,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text("Welcome to", style: AppStyle.h2,),
              )
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("English", style: AppStyle.h1.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.blackGrey
                  ),),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text("Quotes", style: AppStyle.h3.copyWith(height: 1),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              )
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 140),
                child: RawMaterialButton(
                  shape: CircleBorder(),
                  fillColor: AppColors.lighBlue,
                  onPressed: (){
                    Navigator.pushAndRemoveUntil(
                      context, 
                      MaterialPageRoute(builder: (_) => Home()), 
                      (route) => false
                    );
                  },
                  child: Image.asset(AppAssets.rightArrow),
                ),
              )
            )
          ],
        ),
      )
    );
  }
}

