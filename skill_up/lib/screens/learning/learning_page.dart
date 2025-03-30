import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skill_up/data/learning.dart';
import 'package:skill_up/main.dart';
import 'package:skill_up/providers/user_provider.dart';
import 'package:skill_up/widgets/learn_card.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({super.key});

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  @override
  Widget build(BuildContext context) {
    final podcasts = PodcastData.getPodcasts();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Lerning Sessions",
            style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Featured Sessions",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: () {
              //     context.read<UserProvider>().logout();
              //     Navigator.of(context).pushAndRemoveUntil(
              //       MaterialPageRoute(builder: (context) => const MyApp()),
              //       (route) => false,
              //     );
              //   },
              //   child: const Text("logout"),
              // ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: podcasts.length,
                  itemBuilder: (context, index) {
                    final podcast = podcasts[index];
                    return LearnCard(podcast: podcast);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
