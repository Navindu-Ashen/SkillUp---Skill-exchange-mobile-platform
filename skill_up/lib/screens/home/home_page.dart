import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skill_up/providers/user_provider.dart';
import 'package:skill_up/widgets/home/featured_skills.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    if (context.read<UserProvider>().user == null) {
      await context.read<UserProvider>().getUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    if (userProvider.user == null) {
      return _buildLoadingScreen();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                final user = userProvider.user;
                return user != null
                    ? ClipOval(
                      child: SizedBox(
                        height: 48,
                        width: 48,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/Sample_User_Icon.png',
                          image: user.profilePictureURL,
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/Sample_User_Icon.png',
                              fit: BoxFit.cover,
                            );
                          },
                          placeholderFit: BoxFit.cover,
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeInCurve: Curves.easeIn,
                        ),
                      ),
                    )
                    : ClipOval(
                      child: SizedBox(
                        height: 48,
                        width: 48,
                        child: Image.asset(
                          'assets/Sample_User_Icon.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
              },
            ),
            Text(
              'Skill Up',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 52, 76, 183),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.messenger_outline_rounded,
                size: 30,
                color: Colors.black,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 240, 240, 240),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  hintText: 'Search for skills...',
                  hintStyle: GoogleFonts.spaceGrotesk(color: Colors.grey[600]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                onSubmitted: (value) {
                  // Handle search
                  if (value.isNotEmpty) {
                    // Navigate to search page with query
                  }
                },
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'Featured Skills',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const FeaturedSkillsSection(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Skill Up",
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 35,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.keyboard_double_arrow_up_sharp,
                  color: const Color.fromARGB(255, 52, 76, 183),
                  size: 40,
                ),
              ],
            ),
            SizedBox(
              width: screenSize.width * 0.5,
              height: 4,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(100),
                color: const Color.fromARGB(255, 16, 79, 134),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
