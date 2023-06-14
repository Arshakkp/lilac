import 'dart:async';

import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class LilacVideoPlayer extends StatefulWidget {
  const LilacVideoPlayer(
      {super.key,
      required this.videoLink,
      this.onFullScreen,
      this.isFullscreen,
      this.onBack});
  final String videoLink;
  final VoidCallback? onFullScreen;
  final bool? isFullscreen;
  final VoidCallback? onBack;

  @override
  State<LilacVideoPlayer> createState() => _LilacVideoPlayerState();
}

class _LilacVideoPlayerState extends State<LilacVideoPlayer> {
  late VideoPlayerController _controller;
  bool isView = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
      widget.videoLink,
    )..initialize().then((_) {
        setViewFalseAfterTrue();
        setState(() {});
      });
  }

  setViewFalseAfterTrue() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    setState(() {
      isView = true;
    });
    _timer = Timer(const Duration(seconds: 3), () {
      setState(() {
        isView = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuerySize = MediaQuery.of(context).size;
    var height = mediaQuerySize.height;
    var width = mediaQuerySize.width;
    List<Widget> videoButtons() {
      return [
        if (widget.isFullscreen != null && widget.isFullscreen!)
          Positioned(
              child: IconButton(
            onPressed: widget.onBack,
            icon: videoIcon(icon: Icons.arrow_back),
          )),
        Positioned(
          bottom: 0,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: (() {
                    setViewFalseAfterTrue();
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      if (_controller.value.duration.inMilliseconds -
                              _controller.value.position.inMilliseconds ==
                          0) {
                        _controller.seekTo(Duration(seconds: 0));
                      }
                      _controller.play();
                    }
                    setState(() {});
                  }),
                  icon: _controller.value.isPlaying
                      ? videoIcon(icon: Icons.pause)
                      : videoIcon(icon: Icons.play_arrow)),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: width * 0.75,
                      child: ProgressBar(
                        progress: Duration(
                            milliseconds:
                                _controller.value.position.inMilliseconds),
                        total: _controller.value.duration,
                        onSeek: ((value) {
                          setViewFalseAfterTrue();

                          _controller.seekTo(value);
                          setState(() {});
                        }),
                      )),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: (() {
                          setViewFalseAfterTrue();

                          var rewindSec = 10000;
                          if (_controller.value.position.inSeconds == 0) {
                            return;
                          }
                          if (_controller.value.position.inMilliseconds <
                              rewindSec) {
                            rewindSec =
                                _controller.value.position.inMilliseconds;
                          }
                          setState(() {
                            var value = Duration(
                                milliseconds:
                                    _controller.value.position.inMilliseconds -
                                        rewindSec);
                            _controller.seekTo(value);
                          });
                        }),
                        icon: videoIcon(icon: Icons.fast_rewind),
                      ),
                      IconButton(
                        onPressed: (() {
                          setViewFalseAfterTrue();

                          var rewindSec = 10000;

                          if (_controller.value.duration.inMilliseconds -
                                  _controller.value.position.inMilliseconds <
                              rewindSec) {
                            rewindSec =
                                _controller.value.position.inMilliseconds;
                          }
                          setState(() {
                            var value = Duration(
                                milliseconds:
                                    _controller.value.position.inMilliseconds +
                                        rewindSec);
                            _controller.seekTo(value);
                          });
                        }),
                        icon: videoIcon(icon: Icons.fast_forward),
                      ),
                    ],
                  )
                ],
              ),
              if (widget.onFullScreen != null)
                IconButton(
                    onPressed: widget.onFullScreen,
                    icon: videoIcon(icon: Icons.fullscreen))
            ],
          ),
        )
      ];
    }

    return Container(
      width: double.infinity,
      height: (widget.isFullscreen != null && widget.isFullscreen!)
          ? height*0.94
          : height / 3,
      color: Colors.black,
      child: _controller.value.isInitialized
          ? InkWell(
              onTap: (() {
                setViewFalseAfterTrue();
              }),
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  children: [
                    VideoPlayer(_controller),
                    if (isView) ...videoButtons()
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
    );
  }

  Icon videoIcon({required IconData icon}) {
    return Icon(
      icon,
      size: 40,
      color: Colors.white,
    );
  }
}
