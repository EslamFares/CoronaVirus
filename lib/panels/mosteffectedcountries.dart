import 'package:flutter/material.dart';

class MostAffectedCountriesPanel extends StatelessWidget {

  final List countryData;
  const MostAffectedCountriesPanel({Key key, this.countryData})
      : super(key: key);
  Widget build(BuildContext context) {
    return countryData == null ? Center(child: CircularProgressIndicator(),)
        : Container(
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
//                _most(context, indexnum.indexchose),
                _most(context, 201),
                _most(context, 99),
                _most(context, 42),
                _most(context, 181),
                _most(context, 94),
              ],
            ),
          );
  }

  Widget _most(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: <Widget>[
          Image.network(
            countryData[index]['countryInfo']['flag'], //countryData.length-11
            height: 25,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            countryData[index]['country'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Deaths: ' + countryData[index]['deaths'].toString(),
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
