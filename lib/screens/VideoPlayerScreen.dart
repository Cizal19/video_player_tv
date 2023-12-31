import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen(
      {Key? key,
      required this.videoUrl,
      required this.title,
      required this.subtitle,
      required this.description})
      : super(key: key);

  final String videoUrl;
  final String title;
  final String subtitle;
  final String description;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  child: VideoPlayer(_controller),
                  height: 400,
                  width: double.infinity,
                ),
                _ControlsOverlay(
                  controller: _controller,
                  isFullScreen: false,
                ),
                VideoProgressIndicator(_controller, allowScrubbing: false),
              ],
            ),
            Card(
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            widget.subtitle,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ControlsOverlay extends StatefulWidget {
  const _ControlsOverlay(
      {Key? key, required this.controller, required this.isFullScreen})
      : super(key: key);

  static const _examplePlaybackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;
  final bool isFullScreen;

  @override
  State<_ControlsOverlay> createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<_ControlsOverlay> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          color: Colors.black26,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FocusTraversalGroup(
              child: Row(
                children: [
                  Focus(
                    onKey: (node, event) {
                      if (event is RawKeyDownEvent) {
                        if (event.logicalKey == LogicalKeyboardKey.select) {
                          seekLeft();
                          return KeyEventResult.handled;
                        }
                      }
                      return KeyEventResult.ignored;
                    },
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {},
                      focusColor: Colors.blue,
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Focus(
                    onKey: (node, event) {
                      if (event is RawKeyDownEvent) {
                        if (event.logicalKey == LogicalKeyboardKey.select) {
                          setState(() {
                            widget.controller.value.isPlaying
                                ? widget.controller.pause()
                                : widget.controller.play();
                          });
                          return KeyEventResult.handled;
                        }
                      }
                      return KeyEventResult.ignored;
                    },
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {},
                      focusColor: Colors.blue,
                      child: Icon(
                        widget.controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Focus(
                    onKey: (node, event) {
                      if (event is RawKeyDownEvent) {
                        if (event.logicalKey == LogicalKeyboardKey.select) {
                          seekRight();
                          return KeyEventResult.handled;
                        }
                      }
                      return KeyEventResult.ignored;
                    },
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {},
                      focusColor: Colors.blue,
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Focus(
                    onKey: (node, event) {
                      if (event is RawKeyDownEvent) {
                        if (event.logicalKey == LogicalKeyboardKey.select) {
                          widget.isFullScreen
                              ? Navigator.pop(context)
                              : pushFullScreenVideo();
                          return KeyEventResult.handled;
                        }
                      }
                      return KeyEventResult.ignored;
                    },
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {},
                      focusColor: Colors.blue,
                      child: const Icon(
                        Icons.fullscreen,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Focus(
                    onKey: (node, event) {
                      if (event is RawKeyDownEvent) {
                        if (event.logicalKey == LogicalKeyboardKey.select) {
                          return KeyEventResult.handled;
                        }
                      }
                      return KeyEventResult.ignored;
                    },
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {},
                      focusColor: Colors.blue,
                      child: PopupMenuButton<double>(
                        initialValue: widget.controller.value.playbackSpeed,
                        tooltip: 'Playback speed',
                        color: Colors.white,
                        onSelected: (speed) {
                          widget.controller.setPlaybackSpeed(speed);
                        },
                        itemBuilder: (context) {
                          return [
                            for (final speed
                                in _ControlsOverlay._examplePlaybackRates)
                              PopupMenuItem(
                                value: speed,
                                child: Text(
                                  '${speed}x',
                                ),
                              )
                          ];
                        },
                        child: Text(
                          '${widget.controller.value.playbackSpeed}x',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void seekLeft() async {
    var position = await widget.controller.position;
    widget.controller.seekTo(Duration(seconds: position!.inSeconds - 5));
  }

  void seekRight() async {
    var position = await widget.controller.position;
    widget.controller.seekTo(Duration(seconds: position!.inSeconds + 5));
  }

  void pushFullScreenVideo() {
//This will help to hide the status bar and bottom bar of Mobile
//also helps you to set preferred device orientations like landscape

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    );

//This will help you to push fullscreen view of video player on top of current page

    Navigator.of(context)
        .push(
      PageRouteBuilder(
        opaque: false,
        settings: RouteSettings(),
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: Dismissible(
                  key: const Key('key'),
                  direction: DismissDirection.vertical,
                  onDismissed: (_) => Navigator.of(context).pop(),
                  child: OrientationBuilder(
                    builder: (context, orientation) {
                      // var isPortrait = orientation == Orientation.portrait;
                      return Container(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            AspectRatio(
                              aspectRatio: widget.controller.value.aspectRatio,
                              child: VideoPlayer(widget.controller),
                            ),
                            Positioned(
                                bottom: 0,
                                left: 220,
                                child: _ControlsOverlay(
                                  controller: widget.controller,
                                  isFullScreen: true,
                                )),
                          ],
                        ),
                      );
                    },
                  )));
        },
      ),
    )
        .then(
      (value) {
//This will help you to set previous Device orientations of screen so App will continue for portrait mode

        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
        SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
        );
      },
    );
  }
}
