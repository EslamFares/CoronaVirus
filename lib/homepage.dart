import 'dart:async';
import 'dart:convert';
import 'package:coronavirus/datasource.dart';
import 'package:coronavirus/pages/countryPage.dart';
import 'package:coronavirus/panels/countrywidepanel.dart';
import 'package:coronavirus/panels/infopanel.dart';
import 'package:coronavirus/panels/mosteffectedcountries.dart';
import 'package:coronavirus/panels/wordwidepanel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }
  List countryData;
  fetchCountryData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/countries');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchWorldWideData();
    fetchCountryData();
    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Corona Virus (COVID-19)'),
      ),
      body: RefreshIndicator(
        onRefresh:_onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text( countryData[indexnum.indexchose]['country'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                    GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context)=>CountryPage()));
                      } ,
                      child: Container(
                          alignment: Alignment.center,
                          width: 160,
                          height: 100,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(25)),

                              color: primaryBlack
                          ),
                          child: Column(
                            children: <Widget>[
                              Image.network(
                                countryData[indexnum.indexchose]['countryInfo']['flag'],
                                height: 50,
                                width: 50,
                              ),
                              Text('Choose Country',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                            ],
                          )
                    ),
                    ),
                  ],
                ),
              ),
              countryData==null?Center(child: CircularProgressIndicator()): CountryWidePanel(),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(top: 24,left: 16,),
                child: Text('Most affected Countries', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 10,),
              countryData==null?Container(): MostAffectedCountriesPanel(countryData:countryData ,),

              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('WorldWide', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                    GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder:
                        (context)=>CountryPage()));
                      } ,
                      child: Container(
                        alignment: Alignment.center,
                        width: 130,
                        padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),

                            color: primaryBlack
                          ),
                          child: Text('Regional', style: TextStyle(
                          fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),)),
                    ),


                  ],
                ),
              ),
              worldData==null?CircularProgressIndicator(): WorldWidePanel(worldData: worldData,),
              SizedBox(height: 30,),
              InfoPanel(),
              SizedBox(height: 20,),
              Center(
                child: Text('All thanks and appreciation to the White Army',style: TextStyle(
                  fontSize: 16,fontWeight: FontWeight.bold,color: Colors.pinkAccent
                ),),
              ),
              SizedBox(height: 60,)
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _onRefresh() {
    Completer<Null> completer = new Completer<Null>();

    new Timer(new Duration(seconds: 3), () {
      print("timer complete");
      completer.complete();
    });

    return completer.future;
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return new ListTile(title: Text("Todo $index"));
  }

}
