import 'package:flutter/material.dart';

import '../../custom_app_bar.dart';
import 'compare_cities_component.dart';
import 'compare_jobs_component.dart';

class MoneyPage extends StatefulWidget {
  const MoneyPage({Key? key}) : super(key: key);

  @override
  _MoneyPageState createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  int _selectedIndex = 1;

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
                      Tab(icon: Icon(Icons.work)),
                    ],
                  ),
                  title: Text('Compare'),
                  centerTitle: true,
                ),
                bottomNavigationBar: CustomBottomAppBar(
                  selectedIndex: _selectedIndex,
                ),
                body: TabBarView(
                  children: [
                    CompareCityScreen(),
                    CompareSalaryScreen()
                  ],

                )
            )
        )
    );
  }
}

class CompareCityScreen extends StatefulWidget {
  @override
  _CompareCityScreen createState() => _CompareCityScreen();
}

class _CompareCityScreen extends State<CompareCityScreen> {
  @override
  Widget build(BuildContext context) {
    return new CompareCityPage();
  }
}

class CompareSalaryScreen extends StatefulWidget {
  @override
  _CompareSalaryScreen createState() => _CompareSalaryScreen();
}

class _CompareSalaryScreen extends State<CompareSalaryScreen> {
  @override
  Widget build(BuildContext context) {
    return new CompareJobPage();
  }
}

