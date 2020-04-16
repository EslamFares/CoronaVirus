import 'package:coronavirus/datasource.dart';
import 'package:coronavirus/firstpage.dart';
import 'package:coronavirus/homepage.dart';
import 'package:flutter/material.dart';

 void main () {runApp(MyApp());}
//=========== handel error ============= show this bdl red page===========
Widget buildError(BuildContext context, FlutterErrorDetails error) {
  return Scaffold(
    body: Stack(
    fit: StackFit.expand,
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
            color: Colors.amber
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 75.0,
                    child:Image.asset('img/wash.png',width: 150,height: 150,) ,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('BE ',style: TextStyle(color: Colors.red,fontSize: 40,fontWeight: FontWeight.bold),),
                      Text('SAVE',style: TextStyle(color: Colors.blue,fontSize: 40,fontWeight: FontWeight.bold),),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex:1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(padding: EdgeInsets.only(top: 20.0),),
                Text('STAY AT HOME',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
              ],
            ),
          )
        ],
      )
    ],
  ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return buildError(context, errorDetails);
        };
        return widget;
      },
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
