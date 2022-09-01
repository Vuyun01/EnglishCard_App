

import 'package:flutter/material.dart';
import 'package:lesson2/model/english_words.dart';

import '../constant.dart';

class AllWordsPage extends StatefulWidget {
  const AllWordsPage({
    Key? key,
    required this.words, 

  }) : super(key: key);

  final List<EnglishWords> words;

  @override
  State<AllWordsPage> createState() => _AllWordsPageState();
}

class _AllWordsPageState extends State<AllWordsPage> {
  @override
  Widget build(BuildContext context) {
    String quoteDefault = "Think of all the beauty still left around you and be happy.";
    return Scaffold(
      appBar: AppBar(
        title: Text("English Today", style: AppStyle.h2.copyWith(color: AppColors.blackGrey)),
        leading: IconButton(
          padding: EdgeInsets.only(left: 20),
          onPressed: (){
            Navigator.of(context).pop();
          }, 
          icon: Image.asset(AppAssets.leftArrow)),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: widget.words.length,
        itemBuilder: (context, index) => ListTile(
          
          contentPadding: EdgeInsets.all(10),
          tileColor: (index % 2 == 0) ?AppColors.primaryColor : AppColors.lighBlue,
          leading: IconButton(
            icon: Icon(
              Icons.favorite, 
              color: widget.words[index].isFavorited ? Colors.red : Colors.grey,
              size: 35,
            ),
            onPressed: () => setState(() {
              widget.words[index].isFavorited = !widget.words[index].isFavorited;
            })
          ),
          title: Text(widget.words[index].noun!, style: AppStyle.h3.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: (index % 2 == 0) ? Colors.white : Colors.black54
          ),),
          subtitle: Text(widget.words[index].quote ?? quoteDefault, style: AppStyle.h4.copyWith(
            color: Colors.black45
          ),),
      )
        
        
      )
    );
  }
}