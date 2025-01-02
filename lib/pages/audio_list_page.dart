import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFilesScreen extends StatefulWidget {
  @override
  _AudioFilesScreenState createState() => _AudioFilesScreenState();
}

class _AudioFilesScreenState extends State<AudioFilesScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  String _currentAudio = '';

  List<Map<String, String>> audioFiles = [
    {
      "title": "Relaxing Sounds",
      "file": "audio1.mp3",
      "description": "Soothing music to help you relax and focus.",
    },
    {
      "title": "Motivational Speech",
      "file": "audio2.mp3",
      "description": "Inspiring words to help you stay motivated.",
    },
    {
      "title": "Nature Ambience",
      "file": "audio3.mp3",
      "description": "A calming mix of nature sounds for meditation.",
    },
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setReleaseMode(ReleaseMode.stop);

    // Optionally, play a default file when the app starts
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _audioPlayer.setSource(AssetSource('assets/audio1.mp3'));
      await _audioPlayer.resume();
      setState(() {
        _isPlaying = true;
        _currentAudio = 'audio1.mp3';
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Play/Pause toggle functionality
  void _togglePlayPause(String filePath) async {
    if (_isPlaying && _currentAudio == filePath) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      await _audioPlayer.setSource(AssetSource(filePath));
      await _audioPlayer.resume();
      setState(() {
        _isPlaying = true;
        _currentAudio = filePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text("Audiobooks & Audio Files",),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: audioFiles.length,
          itemBuilder: (context, index) {
            var audio = audioFiles[index];
            print(audio);
            // Use null-aware operators to avoid null exceptions
            String title = audio['title'] ?? "Unknown Title";
            String description = audio['description'] ?? "No description available";
            String file = audio['file'] ?? "";

            bool isCurrentAudio = _currentAudio == file;
            return Card(
              margin: EdgeInsets.symmetric(vertical: 12),
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    isCurrentAudio && _isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.blueAccent,
                    size: 28,
                  ),
                  onPressed: () {
                    _togglePlayPause(file);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
