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
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Page'),
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
                    return WatchVideosScreen();
                  }));
                },
                child: Text('Watch Videos'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () { // Navigator to Extra Info screen
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                    return SoundsScreen();
                  }));
                },
                child: Text('Music & More'),
              ),

              // TODO: Add logout button here?

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

