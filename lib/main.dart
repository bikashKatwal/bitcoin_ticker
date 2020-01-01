import 'package:bitcoin_ticket/HomePage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
