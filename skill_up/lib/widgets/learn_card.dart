import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_up/model/podcast.dart';
import 'package:skill_up/screens/learning/learning_detailed_page.dart';

class LearnCard extends StatelessWidget {
  final PodcastModel podcast;

  const LearnCard({super.key, required this.podcast});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LearningDetailsPage(podcastId: podcast.id),
          ),
        );
      },
      child: Card(
        color: const Color.fromARGB(255, 170, 198, 238),
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                podcast.imagePath,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 160,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.video_library, size: 50),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    podcast.title,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Hosted by ${podcast.host}",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.black, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        podcast.rating,
                        style: GoogleFonts.spaceGrotesk(color: Colors.black),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.headphones,
                        color: Colors.black,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        podcast.listenCount,
                        style: GoogleFonts.spaceGrotesk(color: Colors.black),
                      ),
                      const Spacer(),
                      Text(
                        podcast.duration,
                        style: GoogleFonts.spaceGrotesk(color: Colors.black),
                      ),
                    ],
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
