import 'package:flutter/material.dart';


class CompareCityPage extends StatefulWidget {
  const CompareCityPage({Key? key}) : super(key: key);

  @override
  _CompareCityPageState createState() => _CompareCityPageState();
}

class _CompareCityPageState extends State<CompareCityPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compare Cost of Living'),
      ),
    );
  }
}