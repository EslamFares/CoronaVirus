import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryPage extends StatefulWidget {

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/countries');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchCountryData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Country State'),
      ),
      body: countryData == null ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: countryData == null ? 0 : countryData.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 130,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[100],
                          blurRadius: 10,
                          offset: Offset(0, 10))
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                      child: Text(
                                    countryData[index]['country'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                ],
                              ),
                              width: 150,
                              height: 60,
                              alignment: Alignment.center,
                            ),
                            Image.network(
                              countryData[index]['countryInfo']['flag'],
                              height: 60,
                              width: 60,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'CONFIRMED:' +
                                    countryData[index]['cases'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              Text(
                                'ACTIVE :' +
                                    countryData[index]['active'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              Text(
                                'RECOVERED:' +
                                    countryData[index]['recovered'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              Text(
                                'DEATHS:' +
                                    countryData[index]['deaths'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.check_circle,color:index==indexnum.indexchose? Colors.blue:Colors.grey,),
                          onPressed: (){
                            Navigator.pop(context);
                           setState(() {
                             indexnum.indexchose=index;
                           });

                          },
                        ),
                      )
                    ],
                  ),
                );
              }),
    );
  }
}

class indexnum{
  static var indexchose= 59;

}