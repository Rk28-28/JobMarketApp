import 'package:flutter/material.dart';
import 'package:groupb_final/views/video_page_views/sounds_page_component.dart';
import 'package:groupb_final/views/video_page_views/watch_video_component.dart';

import '../../custom_app_bar.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  int _selectedIndex = 0;

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
                Tab(icon: Icon(Icons.library_music)),
                Tab(icon: Icon(Icons.subscriptions)),
                ],
              ),
              title: const Text('Media'),
              centerTitle: true,
              ),
            bottomNavigationBar: CustomBottomAppBar(
            selectedIndex: _selectedIndex,
             ),
    body: TabBarView(
      children: [
        SoundsScreen(),
        WatchVideosScreen()
      ],
    ),

    ),
        ),
    );
  }
}


class WatchVideosScreen extends StatefulWidget {
  @override
  _WatchVideosScreen createState() => _WatchVideosScreen();
}
class _WatchVideosScreen extends State<WatchVideosScreen> {
  @override
  Widget build(BuildContext context) {
    return new WatchVideosPage();
  }
}

class SoundsScreen extends StatefulWidget {
  @override
  _SoundsScreen createState() => _SoundsScreen();
}
class _SoundsScreen extends State<SoundsScreen> {
  @override
  Widget build(BuildContext context) {
    return new SoundsPage();
  }
}

