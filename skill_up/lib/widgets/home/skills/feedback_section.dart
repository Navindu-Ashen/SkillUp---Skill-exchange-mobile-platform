import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_up/model/skill.dart';

class FeedbackSection extends StatelessWidget {
  final List<SkillFeedback>? feedback;
  final double rating;
  final int reviewCount;

  const FeedbackSection({
    super.key,
    required this.feedback,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    if (feedback == null || feedback!.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "No feedback yet",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Feedback & Ratings',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Session Feedback ($reviewCount)",
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            // Feedback summary
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      rating.toStringAsFixed(1),
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating.floor()
                              ? Icons.star
                              : (index < rating
                                  ? Icons.star_half
                                  : Icons.star_border),
                          size: 16,
                          color: Colors.amber,
                        );
                      }),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Based on $reviewCount feedback",
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      _buildRatingBar(5, 0.7),
                      _buildRatingBar(4, 0.2),
                      _buildRatingBar(3, 0.05),
                      _buildRatingBar(2, 0.03),
                      _buildRatingBar(1, 0.02),
                    ],
                  ),
                ),
              ],
            ),

            const Divider(height: 24),

            // Individual feedback
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: min(3, feedback!.length), // Show max 3 feedback items
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final feedbackItem = feedback![index];
                return _buildFeedbackItem(context, feedbackItem);
              },
            ),

            if (feedback!.length > 3)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: OutlinedButton(
                    onPressed: () {
                      // Navigate to all feedback screen
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color.fromARGB(255, 52, 76, 183),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      "View All Feedback",
                      style: GoogleFonts.spaceGrotesk(
                        color: const Color.fromARGB(255, 52, 76, 183),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackItem(BuildContext context, SkillFeedback feedback) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage:
                    feedback.reviewerImage != null
                        ? AssetImage(feedback.reviewerImage!)
                        : null,
                child:
                    feedback.reviewerImage == null
                        ? Text(
                          feedback.reviewerName.substring(0, 1),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                        : null,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        feedback.reviewerName,
                        style: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: List.generate(5, (i) {
                  return Icon(
                    i < feedback.rating.floor()
                        ? Icons.star
                        : (i < feedback.rating
                            ? Icons.star_half
                            : Icons.star_border),
                    size: 16,
                    color: Colors.amber,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(feedback.comment, style: GoogleFonts.spaceGrotesk(fontSize: 14)),
          if (feedback.images != null && feedback.images!.isNotEmpty)
            Container(
              height: 80,
              margin: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: feedback.images!.length,
                itemBuilder: (context, i) {
                  return Container(
                    height: 80,
                    width: 80,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(feedback.images![i]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 10),
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  // Implement helpful counter
                },
                icon: const Icon(
                  Icons.thumb_up_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                label: Text(
                  "Helpful (${feedback.helpfulCount})",
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: const Size(0, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              const SizedBox(width: 10),
              TextButton.icon(
                onPressed: () {
                  // Implement report functionality
                },
                icon: const Icon(
                  Icons.flag_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                label: Text(
                  "Report",
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: const Size(0, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(int stars, double percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            "$stars",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.star, size: 12, color: Colors.amber),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 52, 76, 183),
                ),
                minHeight: 8,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "${(percentage * 100).toInt()}%",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
