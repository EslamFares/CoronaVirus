import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:coronavirus/pages/countryPage.dart';
class CountryWidePanel extends StatefulWidget {
  @override
  _CountryWidePanelState createState() => _CountryWidePanelState();
}

class _CountryWidePanelState extends State<CountryWidePanel> {
  List countryData;
  fetchCountryData() async {
    http.Response response =
    await http.get('https://corona.lmao.ninja/countries');
    setState(() {
      countryData = json.decode(response.body);
      print('test');
    });
  }
  @override
  void initState() {
    fetchCountryData();
    super.initState();
  }

  @override
  void dispose() {
    fetchCountryData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2),
        children: <Widget>[
          StatusPanel(
            title: 'New cases ',
            panelColor: Colors.amber[100],
            textColor: Colors.green,
            count: countryData[CountryPage.IndexChoose==null?59:CountryPage.IndexChoose]['todayCases'].toString(),
          ),

          StatusPanel(
            title: 'Today Deaths',
            panelColor: Colors.blue[100],
            textColor: Colors.blue,
            count: countryData[CountryPage.IndexChoose==null?59:CountryPage.IndexChoose]['todayDeaths'].toString(),
          ),
          StatusPanel(
            title: 'RECOVER',
            panelColor: Colors.green[100],
            textColor: Colors.green,
            count: countryData[CountryPage.IndexChoose==null?59:CountryPage.IndexChoose]['recovered'].toString(),
          ),
          StatusPanel(
            title: 'DEATHS',
            panelColor: Colors.grey[400],
            textColor: Colors.grey[800],
            count: countryData[CountryPage.IndexChoose==null?59:CountryPage.IndexChoose]['deaths'].toString(),
          ),

          StatusPanel(
            title: 'CONFIRMED',
            panelColor: Colors.red[100],
            textColor: Colors.red,
            count: countryData[CountryPage.IndexChoose==null?59:CountryPage.IndexChoose]['cases'].toString(),
          ),

          StatusPanel(
            title: 'active',
            panelColor: Colors.pink[100],
            textColor: Colors.green,
            count: countryData[CountryPage.IndexChoose==null?59:CountryPage.IndexChoose]['active'].toString(),
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
          color: panelColor,
          borderRadius: BorderRadius.all(Radius.circular(16))),
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
