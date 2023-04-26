import 'package:flutter/material.dart';
import 'package:groupb_final/views/search_page_views/salary_search_component.dart';

import '../../custom_app_bar.dart';
import 'city_search_component.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
      ),
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: _selectedIndex,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () { // Navigator to Extra Info screen
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                    return CitySearchScreen();
                  }));
                },
                child: Text('Search Jobs Based on City'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () { // Navigator to Extra Info screen
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                    return SalarySearchScreen();
                  }));
                },
                child: Text('Search Jobs Based on Salary'),
              ),

              // TODO: Add logout button here?

            ],
          ),
        ),
      ),
    );
  }
}

class CitySearchScreen extends StatefulWidget {
  @override
  _CitySearchScreen createState() => _CitySearchScreen();
}

class _CitySearchScreen extends State<CitySearchScreen> {
  @override
  Widget build(BuildContext context) {
    return new CitySearchPage();
  }
}

class SalarySearchScreen extends StatefulWidget {
  @override
  _SalarySearchScreen createState() => _SalarySearchScreen();
}

class _SalarySearchScreen extends State<SalarySearchScreen> {
  @override
  Widget build(BuildContext context) {
    return new SalarySearchPage();
  }
}
