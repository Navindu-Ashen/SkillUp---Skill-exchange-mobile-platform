// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_up/model/skill.dart';

class SkillInfoSection extends StatefulWidget {
  final Skill skill;
  final int sessionCount;
  final Function(int) onSessionCountChanged;

  const SkillInfoSection({
    super.key,
    required this.skill,
    required this.sessionCount,
    required this.onSessionCountChanged,
  });

  @override
  State<SkillInfoSection> createState() => _SkillInfoSectionState();
}

class _SkillInfoSectionState extends State<SkillInfoSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 52, 76, 183),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.skill.category,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Skill title
          Text(
            widget.skill.title,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 8),

          // Rating and Level
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  for (int i = 0; i < 5; i++)
                    Icon(
                      i < widget.skill.rating.floor()
                          ? Icons.star
                          : i < widget.skill.rating
                          ? Icons.star_half
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 20,
                    ),
                  const SizedBox(width: 8),
                  Text(
                    '${widget.skill.rating.toStringAsFixed(1)} (${widget.skill.reviewCount} reviews)',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getLevelColor(widget.skill.level),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.skill.level.toString().split('.').last.capitalize(),
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Status
          Row(
            children: [
              Icon(
                widget.skill.isOffered ? Icons.school : Icons.search,
                color:
                    widget.skill.isOffered
                        ? const Color.fromARGB(255, 52, 76, 183)
                        : Colors.black,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                widget.skill.isOffered ? 'Offered' : 'Seeking',
                style: GoogleFonts.spaceGrotesk(
                  color:
                      widget.skill.isOffered
                          ? const Color.fromARGB(255, 52, 76, 183)
                          : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'by User ${widget.skill.userId}',
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),

          const Divider(height: 32),

          // Description header
          Text(
            'Description',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 8),

          // Description
          Text(
            widget.skill.description,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14,
              color: Colors.grey[800],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Color _getLevelColor(SkillLevel level) {
    switch (level) {
      case SkillLevel.beginner:
        return Colors.green;
      case SkillLevel.intermediate:
        return Colors.orange;
      case SkillLevel.advanced:
        return Colors.red;
    }
  }
}

// Extension to capitalize enum values
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
