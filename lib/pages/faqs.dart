import 'package:coronavirus/datasource.dart';
import 'package:flutter/material.dart';
class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information'),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xff202c3b),
        child: ListView.builder(
          itemCount:DataSource.questionAnswers.length ,
          itemBuilder:(context,index){
            return ExpansionTile(
              backgroundColor: Color(0xff202c3b),
              title: Text(DataSource.questionAnswers[index]['question'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white54),),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,bottom: 20),
                  child: Container(alignment:Alignment.center,child: Text(DataSource.questionAnswers[index]['answer'],style: TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey
                  ),)),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
