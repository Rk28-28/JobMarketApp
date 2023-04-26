import 'package:flutter/material.dart';


class CareerGoalPage extends StatefulWidget {
  const CareerGoalPage({Key? key}) : super(key: key);

  @override
  _CareerGoalPageState createState() => _CareerGoalPageState();
}

class _CareerGoalPageState extends State<CareerGoalPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Career Goals'),
        ),
    );
  }
}