// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skill_up/providers/user_provider.dart';
import 'package:skill_up/screens/add_post/add_post_page.dart';
import 'package:skill_up/widgets/edit_profile_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Map<String, List<Map<String, dynamic>>> skillsMap = {
    'Development': [
      {
        'name': 'Flutter',
        'level': 'Advanced',
        'color': const Color(0xFF2196F3),
      },
      {'name': 'Dart', 'level': 'Advanced', 'color': const Color(0xFF2196F3)},
      {
        'name': 'Python',
        'level': 'Intermediate',
        'color': const Color(0xFF2196F3),
      },
      {
        'name': 'Java',
        'level': 'Intermediate',
        'color': const Color(0xFF2196F3),
      },
      {'name': 'C++', 'level': 'Beginner', 'color': const Color(0xFF2196F3)},
    ],
    'Web': [
      {'name': 'HTML', 'level': 'Advanced', 'color': const Color(0xFF2196F3)},
      {'name': 'CSS', 'level': 'Advanced', 'color': const Color(0xFF2196F3)},
      {
        'name': 'JavaScript',
        'level': 'Intermediate',
        'color': const Color(0xFF2196F3),
      },
    ],
    'Design': [
      {
        'name': 'UI/UX',
        'level': 'Intermediate',
        'color': const Color(0xFF2196F3),
      },
      {'name': 'Figma', 'level': 'Beginner', 'color': const Color(0xFF2196F3)},
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void showEditProfileDialog() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Check if user is null before showing dialog
    if (userProvider.user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User profile not loaded'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final aboutText = "Lorem ipsum dolor sit amet...";
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return EditProfileDialog(
          user:
              userProvider.user!, // Safe to use ! here because we checked above
          aboutText: aboutText,
          onUpdate: (username, email, phone, about) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated successfully'),
                backgroundColor: Color.fromARGB(255, 245, 146, 69),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    var screenSize = MediaQuery.of(context).size;

    // Show loading indicator if user is null
    if (userProvider.user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      "assets/coverphoto.jpg",
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 80,
                      left: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                        child: ClipOval(
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/icon_bg_F.jpg',
                              image: userProvider.user!.profilePictureURL,
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error);
                              },
                              placeholderFit: BoxFit.cover,
                              fadeInDuration: const Duration(milliseconds: 500),
                              fadeInCurve: Curves.easeIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 160,
                      right: 10,
                      child: IconButton(
                        onPressed: showEditProfileDialog,
                        icon: const Icon(Icons.edit_outlined),
                        iconSize: 30,
                        color: const Color.fromARGB(255, 7, 59, 58),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userProvider.user!.username,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width / 1.35,
                      child: Text(
                        userProvider.user!.email,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: screenSize.width / 1.35,
                      child: Text(
                        "bio here bio here bio here bio here bio here bio here bio here",
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "About",
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width,
                      child: Text(
                        "I am a passionate Software Engineer specializing in AI-driven tech solutions, mobile and web development, and cloud computing. I am also a tech enthusiast and a lifelong learner.",
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddPostPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            52,
                            76,
                            183,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        child: Text(
                          'Create a Post',
                          style: GoogleFonts.spaceGrotesk(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Skills",
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: const Color.fromARGB(255, 52, 76, 183),
                      unselectedLabelColor: Colors.grey,
                      labelStyle: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      unselectedLabelStyle: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                      indicatorColor: const Color.fromARGB(255, 52, 76, 183),
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: const [
                        Tab(text: "Development"),
                        Tab(text: "Web"),
                        Tab(text: "Design"),
                      ],
                    ),

                    // Tab content for skills
                    SizedBox(
                      height: 250,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildSkillsGrid('Development'),
                          _buildSkillsGrid('Web'),
                          _buildSkillsGrid('Design'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 42),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<UserProvider>().logout();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                            color: Colors.redAccent,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        child: Text(
                          'Logout',
                          style: GoogleFonts.spaceGrotesk(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 45),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillsGrid(String category) {
    List<Map<String, dynamic>> skills = skillsMap[category] ?? [];

    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.5,
      ),
      itemCount: skills.length,
      itemBuilder: (context, index) {
        final skill = skills[index];
        return _buildSkillCard(
          name: skill['name'],
          level: skill['level'],
          color: skill['color'],
        );
      },
    );
  }

  Widget _buildSkillCard({
    required String name,
    required String level,
    required Color color,
  }) {
    Color bgColor = color.withOpacity(0.1);
    Color iconColor =
        level == 'Advanced'
            ? Colors.amber
            : level == 'Intermediate'
            ? Colors.blue
            : Colors.green;

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.star, size: 14, color: iconColor),
                const SizedBox(width: 4),
                Text(
                  level,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
