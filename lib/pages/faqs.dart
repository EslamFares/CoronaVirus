import 'package:coronavirus/datasource.dart';
import 'package:flutter/material.dart';
class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQS'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount:DataSource.questionAnswers.length ,
        itemBuilder:(context,index){
          return ExpansionTile(
            title: Text(DataSource.questionAnswers[index]['question']),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                child: Container(alignment:Alignment.center,child: Text(DataSource.questionAnswers[index]['answer'],style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 15
                ),)),
              )
            ],
          );
        },
      ),
    );
  }
}
