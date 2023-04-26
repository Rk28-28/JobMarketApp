import 'package:flutter/material.dart';


class CompareJobPage extends StatefulWidget {
  const CompareJobPage({Key? key}) : super(key: key);

  @override
  _CompareJobPageState createState() => _CompareJobPageState();
}

class _CompareJobPageState extends State<CompareJobPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compare Jobs Based on Salary'),
      ),
    );
  }
}