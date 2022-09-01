

import 'package:flutter/material.dart';
import 'package:lesson2/model/english_words.dart';
import 'package:lesson2/widgets/rounded_button.dart';
import 'package:like_button/like_button.dart';
import '../constant.dart';
import '../package/quotes/quote.dart';
import '../pages/show_more.dart';


class EnglishCard extends StatefulWidget {
  const EnglishCard({ 
    Key? key, 
    required this.word,
    required this.listWords,
    this.isMoreCards = false,
  }) : super(key: key);

  final EnglishWords word;
  final bool isMoreCards;
  final List<EnglishWords> listWords;

  @override
  State<EnglishCard> createState() => _EnglishCardState();
}

class _EnglishCardState extends State<EnglishCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String firstLetter = widget.word.noun != null 
                      ? widget.word.noun!.substring(0,1) : "";

    String restLetters = widget.word.noun != null 
        ? widget.word.noun!.substring(1) : "";

    String quoteDefault = "Think of all the beauty still left around you and be happy.";
    String new_quote = widget.word.quote != null ? widget.word.quote! : quoteDefault;
    return Container(
      height: size.height * 0.52,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackGrey.withOpacity(0.4),
            offset: Offset(3, 6),
            blurRadius: 6
          )
        ]
      ),
      child: widget.isMoreCards 
      ? Center(
        child: RoundedButton(
          onPressed: (){
            Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AllWordsPage(words: widget.listWords)));
          }, 
          text: "Show more",
          paddingHr: 40,
        ),
      )
      : Column(
        children: [
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(top: 20),
            child: 
            LikeButton(
              onTap: (bool isLiked) async {
                setState(() {
                  widget.word.isFavorited = !widget.word.isFavorited;
                });
                return widget.word.isFavorited;
              },
              isLiked: widget.word.isFavorited,
              mainAxisAlignment: MainAxisAlignment.end,
              size: 50,
              circleColor:
                  CircleColor(start: Color.fromARGB(255, 230, 236, 58), end: Color.fromARGB(255, 226, 212, 23)),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Color.fromARGB(255, 231, 67, 97),
                dotSecondaryColor: Color.fromARGB(255, 190, 243, 29),
              ),
              likeBuilder: (bool isLiked) {
                return Image.asset(
                  AppAssets.heart,
                  color: isLiked ? Colors.red : Colors.grey.shade300,
                );
              },
            )
            // GestureDetector(
            //   onTap: onTap,
            //   child: Image.asset(AppAssets.heart, color: word.isFavorited ? Colors.red : null,)
            // ),
          ),
          RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: firstLetter,
              style: TextStyle(
                fontSize: 90,
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
                    fontSize: 50,
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
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              new_quote,
              style: AppStyle.h3.copyWith(
                letterSpacing: 1,
                fontSize: 23
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}