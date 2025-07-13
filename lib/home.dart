import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:image_picker/image_picker.dart';
import 'video.dart';
import 'youtube.dart';
import 'audio.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final picker = ImagePicker();
  File? _imageFile;
  File? _videoFile;

  Future<void> pickImage(ImageSource source) async {
    final file = await picker.pickImage(source: source);
    if (file != null) setState(() => _imageFile = File(file.path));
  }

  Future<void> pickVideo(ImageSource source) async {
    final file = await picker.pickVideo(source: source);
    if (file != null) setState(() => _videoFile = File(file.path));
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Widget mediaButton(String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 40, color: Colors.blueGrey),
                const SizedBox(height: 8),
                Text(title, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aplikasi Media"),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Kontrol Media",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                mediaButton("Putar Audio", Icons.music_note, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AudioPage()),
                  );
                }),
                mediaButton("Tonton YouTube", Icons.ondemand_video, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => YoutubeVideo(),
                    ),
                  );
                }),
                mediaButton("Gambar Kamera", Icons.camera_alt,
                    () => pickImage(ImageSource.camera)),
                mediaButton("Gambar Galeri", Icons.photo_library,
                    () => pickImage(ImageSource.gallery)),
                mediaButton("Video Kamera", Icons.videocam,
                    () => pickVideo(ImageSource.camera)),
                mediaButton("Video Galeri", Icons.video_library,
                    () => pickVideo(ImageSource.gallery)),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            if (_imageFile != null) ...[
              const Text("Gambar Terpilih",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Card(
                elevation: 2,
                child: Image.file(_imageFile!, height: 200),
              ),
            ],
            const SizedBox(height: 20),
            if (_videoFile != null) ...[
              const Text("Video dari Kamera/Galeri",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: VideoPlayerWidget(file: _videoFile!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
