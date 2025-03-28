// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skill_up/data/skill.dart';
import 'package:skill_up/model/skill.dart';
import 'package:skill_up/providers/user_provider.dart';
import 'package:skill_up/widgets/home/featured_skills.dart';
import 'package:skill_up/widgets/home/skills/skill_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = 'All';
  List<Skill> _displayedSkills = [];
  final TextEditingController _searchController = TextEditingController();
  String _sortOption = 'All';

  @override
  void initState() {
    super.initState();
    _displayedSkills = SkillData.getAllSkills();

    _searchController.addListener(() {
      _filterSkills();
    });
  }

  void _filterSkills() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty && _selectedCategory == 'All') {
        _displayedSkills = SkillData.getAllSkills();
      } else if (query.isEmpty) {
        _displayedSkills = SkillData.getSkillsByCategory(_selectedCategory);
      } else if (_selectedCategory == 'All') {
        _displayedSkills = SkillData.searchSkills(query);
      } else {
        _displayedSkills =
            SkillData.searchSkills(
              query,
            ).where((s) => s.category == _selectedCategory).toList();
      }
      _sortSkills();
    });
  }

  void _sortSkills() {
    switch (_sortOption) {
      case 'Level: Beginner':
        _displayedSkills.sort((a, b) => a.level.index.compareTo(b.level.index));
        break;
      case 'Level: Intermediate':
        _displayedSkills.sort((a, b) => a.level.index.compareTo(b.level.index));
        break;
      case 'Level: Advanced':
        _displayedSkills.sort((a, b) => b.level.index.compareTo(a.level.index));
        break;
      default:
        break;
    }
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _filterSkills();
    });
  }

  void _changeSort(String? value) {
    if (value != null) {
      setState(() {
        _sortOption = value;
        _sortSkills();
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                final user = userProvider.user;
                return ClipOval(
                  child: SizedBox(
                    height: 48,
                    width: 48,
                    child:
                        user != null
                            ? FadeInImage.assetNetwork(
                              placeholder: 'assets/Sample_User_Icon.png',
                              image: user.profilePictureURL,
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/Sample_User_Icon.png',
                                  fit: BoxFit.cover,
                                );
                              },
                              fadeInDuration: const Duration(milliseconds: 500),
                              fadeInCurve: Curves.easeIn,
                            )
                            : Image.asset(
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
      body: SingleChildScrollView(
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
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: SkillData.getCategories().length + 1,
                itemBuilder: (context, index) {
                  final category =
                      index == 0 ? 'All' : SkillData.getCategories()[index - 1];
                  final isSelected = category == _selectedCategory;
                  return GestureDetector(
                    onTap: () => _selectCategory(category),
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? const Color.fromARGB(255, 52, 76, 183)
                                : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        category,
                        style: GoogleFonts.spaceGrotesk(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedCategory == 'All'
                        ? 'All Skills'
                        : _selectedCategory,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    value: _sortOption,
                    icon: const Icon(Icons.sort),
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(value: 'All', child: Text('All')),
                      DropdownMenuItem(
                        value: 'Level: Beginner',
                        child: Text('Level: Beginner'),
                      ),
                      DropdownMenuItem(
                        value: 'Level: Intermediate',
                        child: Text('Level: Intermediate'),
                      ),
                      DropdownMenuItem(
                        value: 'Level: Advanced',
                        child: Text('Level: Advanced'),
                      ),
                    ],
                    onChanged: _changeSort,
                  ),
                ],
              ),
            ),
            _displayedSkills.isEmpty
                ? _buildNoSkillsFound()
                : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.4,
                  ),
                  itemCount: _displayedSkills.length,
                  itemBuilder: (context, index) {
                    return SkillCard(skill: _displayedSkills[index]);
                  },
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoSkillsFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No skills found',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try different keywords or categories',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
