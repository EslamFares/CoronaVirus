import 'dart:async';
import 'dart:convert';
import 'package:coronavirus/pages/countryPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<CaseNum> fetchAlbum() async {
  var XCOUNTRY = CountryPage.IndexChoose;
  final response = await http.get('https://corona.lmao.ninja/v2/countries');
  if (response.statusCode == 200) {
    return CaseNum.fromJson(json.decode(response.body)[XCOUNTRY]);
  } else {
    throw Exception('Failed to load ');
  }
}


class CaseNum {
  final String todayCases;
  final String todayDeaths;
  final String recovered;
  final String deaths;
  final String cases;
  final String active;
  final String country;
  final String flag;

  CaseNum(
      {this.country,
      this.todayCases,
      this.flag,
      this.todayDeaths,
      this.recovered,
      this.deaths,
      this.cases,
      this.active});

  factory CaseNum.fromJson(Map<String, dynamic> json) {
    return CaseNum(
      todayCases: json['todayCases'].toString(),
      todayDeaths: json['todayDeaths'].toString(),
      recovered: json['recovered'].toString(),
      deaths: json['deaths'].toString(),
      cases: json['cases'].toString(),
      active: json['active'].toString(),
      country: json['country'].toString(),
      flag: json['countryInfo']['flag'].toString(),
    );
  }
}

class CountryWidePanel2 extends StatefulWidget {
  @override
  _CountryWidePanel2State createState() => _CountryWidePanel2State();
}

class _CountryWidePanel2State extends State<CountryWidePanel2> {
  Future<CaseNum> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<CaseNum>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Column(
                  children: <Widget>[

                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            snapshot.data.country.toString(),
                            style:
                            TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CountryPage()));
                            },
                            child: Container(
                                alignment: Alignment.center,
                                width: 160,
                                height: 100,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                    color:  Color(0xff202c3b)),
                                child: Column(
                                  children: <Widget>[
                                    Image.network(
                                      snapshot.data.flag.toString(),
                                      height: 50,
                                      width: 50,
                                    ),
                                    Text(
                                      'Choose Country',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),

                    GridView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 2),
                      children: <Widget>[
                        StatusPanel(
                          title: 'New cases ',
                          panelColor: Colors.amber,
                          textColor: Colors.black,
                          count: snapshot.data.todayCases,
                        ),
                        StatusPanel(
                          title: 'Today Deaths',
                          panelColor: Colors.blue,
                          textColor: Colors.blue,
                          count: snapshot.data.todayDeaths,
                        ),
                        StatusPanel(
                          title: 'RECOVER',
                          panelColor: Colors.green,
                          textColor: Colors.green,
                          count: snapshot.data.recovered,
                        ),
                        StatusPanel(
                          title: 'DEATHS',
                          panelColor: Colors.grey,
                          textColor: Colors.grey[800],
                          count: snapshot.data.deaths,
                        ),
                        StatusPanel(
                          title: 'CONFIRMED',
                          panelColor: Colors.teal,
                          textColor: Colors.red,
                          count: snapshot.data.cases,
                        ),
                        StatusPanel(
                          title: 'active',
                          panelColor: Colors.pink,
                          textColor: Colors.pink,
                          count: snapshot.data.active,
                        ),
                      ],
                    ),
                  ],
                ),
              );

//          Text(snapshot.data.active);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Container(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            ));
          }),
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
          top: BorderSide(width: 3.0, color: panelColor),
          left: BorderSide(width: 3.0, color: panelColor),
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
