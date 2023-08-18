import 'package:connect_stem/models/news_data.dart';
import 'package:connect_stem/pages/stories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Roboto"),
      home: ChangeNotifierProvider(
        create: (context)=> NewsData(),
        child: StoriesPage()
      ),
    );
  }
}

//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=2b7039517b7b49f5bcda89677b7565b0

