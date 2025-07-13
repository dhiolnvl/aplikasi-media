import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  int currentIndex = 0;

  final List<String> playlist = [
    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
  ];

  Future<void> playCurrent() async {
    await audioPlayer.stop();
    await audioPlayer.play(UrlSource(playlist[currentIndex]));
    setState(() => isPlaying = true);
  }

  Future<void> toggleAudio() async {
    if (isPlaying) {
      await audioPlayer.pause();
      setState(() => isPlaying = false);
    } else {
      await audioPlayer.resume();
      setState(() => isPlaying = true);
    }
  }

  Future<void> playNext() async {
    setState(() {
      currentIndex = (currentIndex + 1) % playlist.length;
    });
    await playCurrent();
  }

  Future<void> playPrevious() async {
    setState(() {
      currentIndex = (currentIndex - 1 + playlist.length) % playlist.length;
    });
    await playCurrent();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String fileName = playlist[currentIndex].split('/').last;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pemutar Audio"),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.album,
              size: 100,
              color: Colors.blueGrey,
            ),
            const SizedBox(height: 20),
            Text(
              fileName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              isPlaying ? "Sedang Diputar..." : "Dijeda",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: playPrevious,
                  icon: const Icon(Icons.skip_previous),
                  iconSize: 40,
                  color: Colors.blueGrey,
                ),
                IconButton(
                  onPressed: toggleAudio,
                  icon: Icon(
                    isPlaying ? Icons.pause_circle : Icons.play_circle,
                  ),
                  iconSize: 60,
                  color: Colors.blueGrey,
                ),
                IconButton(
                  onPressed: playNext,
                  icon: const Icon(Icons.skip_next),
                  iconSize: 40,
                  color: Colors.blueGrey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
