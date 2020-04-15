import 'package:coronavirus/datasource.dart';
import 'package:coronavirus/homepage.dart';
import 'package:flutter/material.dart';

 void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CoronaVirus',
      theme: ThemeData(
        primaryColor: primaryBlack,
        fontFamily: 'Circular'
      ),
      home:HomePage() ,
    );
  }
}
