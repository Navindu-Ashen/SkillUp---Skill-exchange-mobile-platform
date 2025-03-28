import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skill_up/providers/user_provider.dart';
import 'package:skill_up/screens/add_post/add_post_page.dart';
import 'package:skill_up/screens/podcasts/podcast_page.dart';
import 'package:skill_up/screens/profile/profile_page.dart';
import 'package:skill_up/screens/job_search/job_search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  final List<IconData> iconList = [
    Icons.home,
    Icons.search,
    Icons.podcasts,
    Icons.person,
  ];

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildHomeContent(),
      const SearchPage(),
      const PodcastPage(),
      const ProfilePage(),
    ];
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

  Widget _buildHomeContent() {
    return Scaffold(
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
      ),
      body: Column(),
    );
  }

  void _handleNavigation(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final screenSize = MediaQuery.of(context).size;
    return userProvider.user == null
        ? Scaffold(
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
        )
        : Scaffold(
          body: _pages[_bottomNavIndex],
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black54,
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (ctx) => const AddPostPage()));
            },
            elevation: 0,
            child: const Icon(Icons.add, color: Colors.white, size: 30),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: iconList,
            activeIndex: _bottomNavIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            onTap: _handleNavigation,
            activeColor: Colors.white,
            inactiveColor: Colors.grey[400],
            backgroundColor: const Color.fromARGB(255, 52, 76, 183),
            iconSize: 30,
            splashRadius: 0,
            splashColor: Colors.transparent,
          ),
        );
  }
}
