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
    return Scaffold(
      appBar: AppBar(
        title: Text('Money Page'),
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
                  return CompareCityScreen();
                }));
              },
              child: Text('Compare Cities Based on Cost'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () { // Navigator to Extra Info screen
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  return CompareSalaryScreen();
                }));
              },
              child: Text('Compare Jobs Based on Salary'),
            ),
          ],
        ),
      ),
      ),
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

