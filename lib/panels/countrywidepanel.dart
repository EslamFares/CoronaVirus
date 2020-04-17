
//============= have error =================== cant solve it
//=========== create sec page replace it  it was easy to me than solve error=========



import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:coronavirus/pages/countryPage.dart';
import 'dart:async';
class CountryWidePanel extends StatefulWidget {
  @override
  _CountryWidePanelState createState() => _CountryWidePanelState();
}

class _CountryWidePanelState extends State<CountryWidePanel> {
  List countryData;
  Future<http.Response> fetchCountryData() async {
    http.Response response =
    //========== new api======
    await http.get('https://corona.lmao.ninja/v2/countries');
//    await http.get('https://corona.lmao.ninja/countries');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchCountryData();
    countryData = new List();
    super.initState();
  }

  @override
  void dispose() {
    fetchCountryData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var indexx = CountryPage.IndexChoose;
    return Container(
        child: GridView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2),
                  children: <Widget>[
                    StatusPanel(
                      title: 'New cases ',
                      panelColor: Colors.amber,
                      textColor: Colors.black,
                      count: countryData[indexx]['todayCases'].toString(),
                    ),
                    StatusPanel(
                      title: 'Today Deaths',
                      panelColor: Colors.blue,
                      textColor: Colors.blue,
                      count: countryData[indexx]['todayDeaths'].toString(),
                    ),
                    StatusPanel(
                      title: 'RECOVER',
                      panelColor: Colors.green,
                      textColor: Colors.green,
                      count: countryData[indexx]['recovered'].toString(),
                    ),
                    StatusPanel(
                      title: 'DEATHS',
                      panelColor: Colors.grey,
                      textColor: Colors.grey[800],
                      count: countryData[indexx]['deaths'].toString(),
                    ),
                    StatusPanel(
                      title: 'CONFIRMED',
                      panelColor: Colors.teal,
                      textColor: Colors.red,
                      count: countryData[indexx]['cases'].toString(),
                    ),
                    StatusPanel(
                      title: 'active',
                      panelColor: Colors.pink,
                      textColor: Colors.pink,
                      count: countryData[indexx]['active'].toString(),
                    ),
                  ],
                ),


    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel(
      {Key key, this.panelColor, this.textColor, this.title, this.count})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: panelColor.withOpacity(.2),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        border: Border(
          top: BorderSide(width: 3.0, color:panelColor),
          left: BorderSide(width: 3.0, color:panelColor),
          right: BorderSide(width: 3.0, color: panelColor),
          bottom: BorderSide(width: 3.0, color: panelColor),
        ),
      ),
      margin: EdgeInsets.all(10),
      height: 60,
      width: width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
          ),
          Text(
            count,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 16,
                color: textColor),
          ),
        ],
      ),
    );
  }
}
