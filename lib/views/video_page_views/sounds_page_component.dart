import 'package:flutter/material.dart';


class SoundsPage extends StatefulWidget {
  const SoundsPage({Key? key}) : super(key: key);

  @override
  _SoundsPageState createState() => _SoundsPageState();
}

class _SoundsPageState extends State<SoundsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listen'),
      ),
    );
  }
}