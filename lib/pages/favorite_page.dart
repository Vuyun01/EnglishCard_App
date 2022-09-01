import 'package:flutter/material.dart';
import 'package:lesson2/model/english_words.dart';

import '../constant.dart';

class FavoriteWordsPage extends StatelessWidget {
  const FavoriteWordsPage({
    Key? key,
    required this.words, 
  }) : super(key: key);

  final List<EnglishWords> words;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Words", style: AppStyle.h2.copyWith(color: AppColors.blackGrey)),
        leading: IconButton(
          padding: EdgeInsets.only(left: 20),
          onPressed: (){
            Navigator.of(context).pop();
          }, 
          icon: Image.asset(AppAssets.leftArrow)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: words.map((e) {
            String firstLetter = e.noun != null 
                                  ? e.noun!.substring(0,1) : "";

            String restLetters = e.noun != null 
                                  ? e.noun!.substring(1) : "";
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.only(top: 10, right: 10),
                    child: Icon(
                      Icons.favorite, 
                      color: e.isFavorited ? Colors.red : Colors.black38,
                      size: 35,
                    )
                  ),
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: firstLetter,
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Sen",
                        shadows: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(3,8),
                            blurRadius: 10
                          )
                        ]
                      ),
                      children: [
                        TextSpan(
                          text: restLetters,
                          style: TextStyle(
                            letterSpacing: 2,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Sen",
                            shadows: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(3,8),
                                blurRadius: 10
                              )
                            ]
                          ),
                        )
                      ]
                    )
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}