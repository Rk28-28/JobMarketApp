import 'package:flutter/material.dart';


class WatchVideosPage extends StatefulWidget {
  const WatchVideosPage({Key? key}) : super(key: key);

  @override
  _WatchVideosPageState createState() => _WatchVideosPageState();
}

class _WatchVideosPageState extends State<WatchVideosPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watch'),
      ),
    );
  }
}