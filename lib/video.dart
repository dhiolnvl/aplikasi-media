import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final File file;
  const VideoPlayerWidget({super.key, required this.file});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _initializeVideo(widget.file);
  }

  @override
  void didUpdateWidget(VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.file.path != widget.file.path) {
      _initializeVideo(widget.file);
    }
  }

  Future<void> _initializeVideo(File file) async {
    if (_controller != null) {
      await _controller!.pause();
      await _controller!.dispose();
    }
    _controller = VideoPlayerController.file(file);
    await _controller!.initialize();
    await _controller!.play();
    setState(() {}); // refresh UI
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return AspectRatio(
      aspectRatio: _controller!.value.aspectRatio,
      child: VideoPlayer(_controller!),
    );
  }
}
