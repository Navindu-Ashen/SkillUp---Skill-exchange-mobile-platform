// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomExchangeBar extends StatelessWidget {
  final bool isOffered;
  final VoidCallback onRequestExchange;
  final VoidCallback onContactNow;

  const BottomExchangeBar({
    super.key,
    required this.isOffered,
    required this.onRequestExchange,
    required this.onContactNow,
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
          // Request Exchange button
          Expanded(
            child: OutlinedButton(
              onPressed:
                  onRequestExchange, // Always enabled for exchange request
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

          // Contact Now button
          Expanded(
            child: ElevatedButton(
              onPressed: onContactNow,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 52, 76, 183),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                'Contact Now',
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
