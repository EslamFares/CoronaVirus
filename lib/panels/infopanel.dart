import 'package:coronavirus/datasource.dart';
import 'package:coronavirus/pages/faqs.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQPage()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              color: primaryBlack,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                Text('About Virus',style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
                ),
                Icon(Icons.arrow_forward,color: Colors.white,)
              ],),
            ),
          ),
          GestureDetector(
            onTap:(){
               launch('https://www.care.gov.eg/EgyptCare/Index.aspx');
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              color: primaryBlack,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                Text('Egypt ',style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
                ),
                Icon(Icons.arrow_forward,color: Colors.white,)
              ],),
            ),
          ),

        ],
      ) ,
    );
  }
}
