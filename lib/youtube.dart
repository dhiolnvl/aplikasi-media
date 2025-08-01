import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideo extends StatelessWidget {
  static String videoID = 'b-WdRqzSJ9w';

  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: videoID,
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Youtube"),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text("Play Video from Youtube"),
            SizedBox(
              height: 30,
            ),
            YoutubePlayer(
              controller: _controller,
              liveUIColor: Colors.amber,
              showVideoProgressIndicator: true,
            ),
          ],
        ),
      ),
    );
  }
}
