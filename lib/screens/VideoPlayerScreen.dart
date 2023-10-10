import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

  final String videoUrl;

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
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              child: VideoPlayer(_controller),
              height: 400,
              width: double.infinity,
            ),
            _ControlsOverlay(controller: _controller),
            VideoProgressIndicator(_controller, allowScrubbing: true),
          ],
        ),
      ),
    );
  }
}

class _ControlsOverlay extends StatefulWidget {
  const _ControlsOverlay({Key? key, required this.controller})
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
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 50),
              reverseDuration: Duration(milliseconds: 200),
              child: Row(
                children: [
                  MaterialButton(
                    onPressed: () async {
                      var position = await widget.controller.position;

                      widget.controller
                          .seekTo(Duration(seconds: position!.inSeconds - 5));
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  // controller.value.isPlaying
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        widget.controller.value.isPlaying
                            ? widget.controller.pause()
                            : widget.controller.play();
                      });
                    },
                    child: Icon(
                      widget.controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      var position = await widget.controller.position;

                      widget.controller
                          .seekTo(Duration(seconds: position!.inSeconds + 5));
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  PopupMenuButton<double>(
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
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
