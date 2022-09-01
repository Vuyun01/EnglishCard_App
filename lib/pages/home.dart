import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lesson2/constant.dart';
import 'package:lesson2/model/english_words.dart';
import 'package:lesson2/package/quotes/quote.dart';
import 'package:lesson2/package/quotes/quote_model.dart';
import 'package:lesson2/pages/favorite_page.dart';
import 'package:lesson2/pages/show_more.dart';
import 'package:lesson2/share_key.dart';
import 'package:lesson2/widgets/english_card.dart';
import 'package:english_words/english_words.dart';
import 'package:lesson2/widgets/rounded_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'control_page.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController? _pageController;  //alow user control page
  int _currentIndex = 0;
  List<EnglishWords> words = [];
  String quote = Quotes().getRandom().content!;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(); // create a key


  List<int> buildListRandom({int len = 1, int max = 150, int min = 1}){
    if(len > max || len < min){
      return [];
    }
    List<int> newList = [];

    Random random = Random();
    int count = 1;
    while(count <= len){
      int value = random.nextInt(max);
      if(newList.contains(value)){
        break;
      }else{
        newList.add(value);
        count++;
      }
    }
    return newList;
    
  } 
  
  Future<void> getEnglishWords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int len = prefs.getInt(ShareKeys.key) ?? 5;
    List<String> newListWords = [];
    List<int> rands = buildListRandom(len: len, max: nouns.length);
    rands.forEach((index) {
      newListWords.add(nouns[index]);
    });
    setState(() {
      words = newListWords.map((e) => getQuotes(e)).toList();   
    });
  }
  EnglishWords getQuotes(String noun){
    Quote? quotes;
    quotes = Quotes().getByWord(noun);
    return EnglishWords(
      noun: noun,
      quote: quotes?.content,
      id: quotes?.id,
    );
  }
  
  
  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(viewportFraction: 0.9);
    super.initState();
    getEnglishWords();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("English Today", style: AppStyle.h2.copyWith(color: AppColors.blackGrey)),
        leading: IconButton(
          padding: EdgeInsets.only(left: 20),
          onPressed: (){
            scaffoldKey.currentState!.openDrawer();
          }, 
          icon: Image.asset(AppAssets.menu)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      drawer: Drawer(
        backgroundColor: AppColors.lighBlue,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Text("Your mind", style: AppStyle.h2.copyWith(
                  fontSize: 45,
                  fontWeight: FontWeight.bold
                ),),
              ),
              RoundedButton(
                text: "Favorites", 
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => FavoriteWordsPage(words: words,)));
                }
              ),
              RoundedButton(
                text: "Your control", 
                onPressed: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (_) => ControlPage()));
                }
              )

            ],
          ),
        )
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: size.width * 0.3,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              // color: Colors.green,
              child: Text('"$quote"',
                style: AppStyle.h4.copyWith(color: AppColors.greyText),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: size.height * 0.6,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value){
                  setState(() {
                    _currentIndex = value;
                  });
                },
                itemCount: words.length > 5 ? 6 : words.length,
                itemBuilder: (_, index){
                  return EnglishCard(
                    listWords: words,
                    word: words[index],
                    isMoreCards: (index >= 5),
                  );
                }
              ),
            ),
            SizedBox(
              height: size.width * 0.15,
              // margin: EdgeInsets.only(left: 30, right: 30),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    words.length > 5 ? 6 : words.length, 
                    (index) => buildIndicator(index, size)),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            getEnglishWords();
          });
        },
        backgroundColor: AppColors.primaryColor,
        child: Image.asset(AppAssets.exchange),
      ),
    );
  }

  AnimatedContainer buildIndicator(int index, Size size){
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 15,
      width: index == _currentIndex ? 60 : 30,
      margin: EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: index == _currentIndex ? AppColors.lighBlue : AppColors.lightGrey,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(2, 4),
            blurRadius: 3
          )
        ]
      ),
    );
  } 
}
