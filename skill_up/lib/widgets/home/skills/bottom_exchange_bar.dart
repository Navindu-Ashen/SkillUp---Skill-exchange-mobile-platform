// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_up/model/skill.dart';
import 'package:skill_up/screens/home/skills/message_page.dart';

class BottomExchangeBar extends StatelessWidget {
  final bool isOffered;
  final VoidCallback onRequestExchange;
  final VoidCallback onContactNow;
  final Skill skill;

  const BottomExchangeBar({
    super.key,
    required this.isOffered,
    required this.onRequestExchange,
    required this.onContactNow,
    required this.skill,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onRequestExchange,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color.fromARGB(255, 52, 76, 183)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                'Request Exchange',
                style: GoogleFonts.spaceGrotesk(
                  color: const Color.fromARGB(255, 52, 76, 183),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => MessagePage(
                          skill: skill,
                          recipientName: skill.userId,
                        ),
                  ),
                );
                onContactNow();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 52, 76, 183),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                'Message Now',
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
