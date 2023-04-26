import 'package:flutter/material.dart';

class CitySearchPage extends StatefulWidget {
  const CitySearchPage({Key? key}) : super(key: key);

  @override
  _CitySearchPageState createState() => _CitySearchPageState();
}

class _CitySearchPageState extends State<CitySearchPage> {


  String? dropdownValue;
  var CityPicked;
  List<String> Cities = <String>[
    'Akron, OK',
    'Albany, NY',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search for Jobs Based on City'),
        ),
        body: Center(
          child: DropdownButtonFormField<String>(
              hint: Text("Select A City"),
              value: CityPicked,
              items: Cities.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  CityPicked = value;
                });
              }),
        )
    );
  }

}


