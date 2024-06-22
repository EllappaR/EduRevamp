import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Videos(),
    );
  }
}

class Videos extends StatelessWidget {
  const Videos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Videos"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/landing.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            VideoCard(
              cardColor: Colors.pink[100]!,
              subject: 'English',
              videos: [
                'videos/english1.mp4',
                'videos/English2.mp4',
                'videos/english3.mp4',
              ],
            ),
            const SizedBox(height: 15),
            VideoCard(
              cardColor: Colors.blue[100]!,
              subject: 'EVS',
              videos: [
                'videos/evs1.mp4',
                'videos/evs2.mp4',
                'videos/evs3.mp4',
              ],
            ),
            const SizedBox(height: 15),
            VideoCard(
              cardColor: Colors.green[100]!,
              subject: 'Maths',
              videos: [
                'videos/maths1.mp4',
                'videos/maths2.mp4',
                'videos/maths3.mp4',
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final Color cardColor;
  final String subject;
  final List<String> videos;

  const VideoCard({
    Key? key,
    required this.cardColor,
    required this.subject,
    required this.videos,
  }) : super(key: key);

  void navigateToVideoPage(BuildContext context, List<String> videoURLs) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VideoPage(videoURLs: videoURLs)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Video URLs: $videos"); // Print video URLs for debugging
        navigateToVideoPage(context, videos);
      },
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: cardColor,
          child: Center(
            child: Text(
              subject,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VideoPage extends StatefulWidget {
  final List<String> videoURLs;

  const VideoPage({Key? key, required this.videoURLs}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  int _currentIndex = 0;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoURLs[_currentIndex]);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {});
    });
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        _nextVideo();
      }
    });
    _controller.setLooping(false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextVideo() {
    setState(() {
      if (_currentIndex < widget.videoURLs.length - 1) {
        _currentIndex++;
        _controller = VideoPlayerController.asset(widget.videoURLs[_currentIndex]);
        _initializeVideoPlayerFuture = _controller.initialize().then((_) {
          setState(() {});
        });
        _controller.addListener(() {
          if (_controller.value.position == _controller.value.duration) {
            _nextVideo();
          }
        });
        _controller.setLooping(false);
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  void _playPauseVideo() {
    setState(() {
      if (_isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Videos"),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  const SizedBox(height: 20),
                  VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    padding: const EdgeInsets.all(8.0),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _playPauseVideo,
                        icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                      ),
                      ElevatedButton(
                        onPressed: _nextVideo,
                        child: const Text('Next Video'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
