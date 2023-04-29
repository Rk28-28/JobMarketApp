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
    return MaterialApp(
        home: DefaultTabController(
          length: 2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.orange[200],
              bottom: const TabBar(
                indicatorColor: Colors.green,
                tabs: [
                Tab(icon: Icon(Icons.location_city)),
                Tab(icon: Icon(Icons.monetization_on)),
                ],
               ),
                title: Text('Search Jobs Based On'),
                centerTitle: true,
              ),
              bottomNavigationBar: CustomBottomAppBar(
              selectedIndex: _selectedIndex,
            ),
            body: TabBarView(
                children: [
                  CitySearchScreen(),
                  SalarySearchScreen()
                  ],

            )
    )
        )
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
