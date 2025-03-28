// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_up/screens/home/detailed_feature_skills.dart';

class FeaturedSkillsSection extends StatelessWidget {
  const FeaturedSkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final featuredSkills = [
      {
        'title': 'Flutter Development',
        'image': 'assets/flutter.png',
        'category': 'Mobile Development',
        'learners': 5842,
        'color': const Color.fromARGB(255, 231, 241, 255),
      },
      {
        'title': 'UI/UX Design',
        'image': 'assets/UI-UX.png',
        'category': 'Design',
        'learners': 4257,
        'color': const Color.fromARGB(255, 231, 241, 255),
      },
      {
        'title': 'Machine Learning',
        'image': 'assets/ml.png',
        'category': 'Data Science',
        'learners': 3126,
        'color': const Color.fromARGB(255, 231, 241, 255),
      },
      {
        'title': 'Digital Marketing',
        'image': 'assets/digital-marketing.png',
        'category': 'Marketing',
        'learners': 6754,
        'color': const Color.fromARGB(255, 231, 241, 255),
      },
    ];

    return SizedBox(
      height: 230,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: featuredSkills.length,
        itemBuilder: (context, index) {
          final skill = featuredSkills[index];
          return _buildFeaturedSkillCard(
            context: context,
            title: skill['title'] as String,
            image: skill['image'] as String,
            category: skill['category'] as String,
            learners: skill['learners'] as int,
            color: skill['color'] as Color,
          );
        },
      ),
    );
  }

  Widget _buildFeaturedSkillCard({
    required BuildContext context,
    required String title,
    required String image,
    required String category,
    required int learners,
    required Color color,
  }) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 110,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        category,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.people_outline,
                      size: 16,
                      color: Colors.black87,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$learners learners',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        color: Colors.grey[900],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => DetailedFeatureSkills(
                                skillName: title,
                                skillCategory: category,
                                skillImage: image,
                                learners: learners,
                                cardColor: color,
                              ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 52, 76, 183),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Explore Skill',
                      style: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
