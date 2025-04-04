import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_up/data/learning.dart';
import 'package:skill_up/model/learning.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LearningDetailsPage extends StatefulWidget {
  final String podcastId;

  const LearningDetailsPage({super.key, required this.podcastId});

  @override
  State<LearningDetailsPage> createState() => _LearningDetailsPageState();
}

class _LearningDetailsPageState extends State<LearningDetailsPage> {
  late YoutubePlayerController _controller;
  late PodcastModel podcast;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    podcast = PodcastData.getPodcastById(widget.podcastId);

    final videoId = YoutubePlayer.convertUrlToId(podcast.youtubeVideoUrl);

    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: false,
        loop: false,
        enableCaption: true,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    if (_isPlayerReady && mounted) {
      setState(() {});
    }
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
        title: Text(
          podcast.title,
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: const Color.fromARGB(
                  255,
                  170,
                  198,
                  238,
                ),
                progressColors: const ProgressBarColors(
                  playedColor: Color.fromARGB(255, 170, 198, 238),
                  handleColor: Color.fromARGB(255, 170, 198, 238),
                ),
                onReady: () {
                  setState(() {
                    _isPlayerReady = true;
                  });
                },
              ),
              builder: (context, player) {
                return Column(children: [player]);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    podcast.title,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Hosted by ${podcast.host}",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // Stats row
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 170, 198, 238),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        podcast.rating,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Icon(
                        Icons.headphones,
                        color: Color.fromARGB(255, 170, 198, 238),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        podcast.listenCount,
                        style: GoogleFonts.spaceGrotesk(fontSize: 16),
                      ),
                      const SizedBox(width: 20),
                      const Icon(
                        Icons.access_time,
                        color: Color.fromARGB(255, 170, 198, 238),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        podcast.duration,
                        style: GoogleFonts.spaceGrotesk(fontSize: 16),
                      ),
                    ],
                  ),

                  // Topics
                  const SizedBox(height: 16),
                  Text(
                    "Topics",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        podcast.topics.map((topic) {
                          return Chip(
                            label: Text(
                              topic,
                              style: GoogleFonts.spaceGrotesk(
                                color: Colors.black,
                              ),
                            ),
                            backgroundColor: const Color.fromARGB(
                              255,
                              170,
                              198,
                              238,
                            ),
                            padding: const EdgeInsets.all(0),
                          );
                        }).toList(),
                  ),

                  const SizedBox(height: 16),
                  Text(
                    "Description",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    podcast.description,
                    style: GoogleFonts.spaceGrotesk(fontSize: 16, height: 1.5),
                  ),

                  const SizedBox(height: 24),
                  Text(
                    "Episodes",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: podcast.episodes.length,
                    itemBuilder: (context, index) {
                      final episode = podcast.episodes[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: const Color.fromARGB(
                            255,
                            170,
                            198,
                            238,
                          ),
                          child: Text(
                            "${index + 1}",
                            style: GoogleFonts.spaceGrotesk(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          episode,
                          style: GoogleFonts.spaceGrotesk(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.play_circle_outline,
                          color: Color.fromARGB(255, 52, 76, 183),
                        ),
                        onTap: () {
                          if (_isPlayerReady) {
                            _controller.seekTo(Duration.zero);
                            _controller.play();
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
