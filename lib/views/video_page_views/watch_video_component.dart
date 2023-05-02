import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'video_list.dart';

//some code taken from https://pub.dev/packages/youtube_player_flutter

class VideoButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final String imageAsset;

  const VideoButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed as void Function()?,
      child: Container(
        height: 100,
        width: 170,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageAsset),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: Color.fromRGBO(35, 25, 55, 50),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class WatchVideosPage extends StatefulWidget {
  const WatchVideosPage({Key? key}) : super(key: key);

  @override
  _WatchVideosPageState createState() => _WatchVideosPageState();
}

class _WatchVideosPageState extends State<WatchVideosPage> {

  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;


  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  final List<String> _ids = [
    'qpkegRmPgis',
    '84Ja3XadHTk',
    'J30wmYgzVXM',
    'ppf9j8x0LA8'
  ];
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: _ids.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<YoutubePlayerController> _controllers = [
      'qpkegRmPgis',
      '84Ja3XadHTk',
      'J30wmYgzVXM',
      'ppf9j8x0LA8'
    ]
        .map<YoutubePlayerController>(
          (videoId) => YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
        ),
      ),
    )
        .toList();
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.green,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {
              log('Settings Tapped!');
            },
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          _controller
              .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
          _showSnackBar('Next Video Started!');
        },
      ),
      builder: (context, player) => Scaffold(
        body:
        SafeArea( child: ListView(
          children: [
            player,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _space,
                  Container(
                    alignment: Alignment.center,
                  child: Text(
                    _videoMetaData.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                  ),
                  ),
                  _space,

                  Row(
                    children: <Widget>[
                      const Text(
                        "Volume",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Slider(
                          inactiveColor: Colors.transparent,
                          value: _volume,
                          min: 0.0,
                          max: 100.0,
                          divisions: 10,
                          activeColor: Colors.green,
                          label: '${(_volume).round()}',
                          onChanged: _isPlayerReady
                              ? (value) {
                            setState(() {
                              _volume = value;
                            });
                            _controller.setVolume(_volume.round());
                          }
                              : null,
                        ),
                      ),
                    ],
                  ),
                  _space,
                  SizedBox(
                    height: 350.0,
                    width: 2.0,
                  child: GridView.count(
                    crossAxisCount: 1,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 2.0,
                      children: [
                          VideoButton(text: "",
                          onPressed: () {
                            _controller.load('ppf9j8x0LA8');
                          },
                          imageAsset: 'assets/tedVid.png'),
                        VideoButton(text: "",
                          onPressed: () {
                            _controller.load('J30wmYgzVXM');
                          },
                          imageAsset: 'assets/salaryVid.png'),
                        VideoButton(text: "",
                          onPressed: () {
                            _controller.load('84Ja3XadHTk');
                          },
                          imageAsset: 'assets/demandVid.png'),
                        VideoButton(text: "",
                          onPressed: () {
                            _controller.load('qpkegRmPgis');
                          },
                          imageAsset: 'assets/interviewTipsVid.png'),
                       ]
                  ),
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }

Widget get _space => const SizedBox(height: 10);

void _showSnackBar(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: Colors.blueAccent,
      behavior: SnackBarBehavior.floating,
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
    ),
  );
}
}