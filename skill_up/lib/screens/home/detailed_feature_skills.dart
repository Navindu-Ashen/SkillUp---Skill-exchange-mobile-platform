// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillDetailPage extends StatefulWidget {
  final String skillName;
  final String skillCategory;
  final String skillImage;
  final int learners;
  final Color cardColor;

  const SkillDetailPage({
    super.key,
    required this.skillName,
    required this.skillCategory,
    required this.skillImage,
    required this.learners,
    required this.cardColor,
  });

  @override
  State<SkillDetailPage> createState() => _SkillDetailPageState();
}

class _SkillDetailPageState extends State<SkillDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240.0,
            pinned: true,
            backgroundColor: widget.cardColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(decoration: BoxDecoration(color: widget.cardColor)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.skillCategory,
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.skillName,
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.people_outline,
                                    size: 18,
                                    color: Colors.black87,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${widget.learners} learners',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Icon(
                                    Icons.star,
                                    size: 18,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '4.8 (526)',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(8),
                          child: ClipOval(
                            child: Image.asset(
                              widget.skillImage,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  child: const Icon(
                                    Icons.school_outlined,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  _isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                  color: _isBookmarked ? Colors.amber : Colors.black87,
                ),
                onPressed: () {
                  setState(() {
                    _isBookmarked = !_isBookmarked;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        _isBookmarked
                            ? 'Added ${widget.skillName} to your bookmarks'
                            : 'Removed ${widget.skillName} from your bookmarks',
                        style: GoogleFonts.spaceGrotesk(),
                      ),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                  );
                },
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Starting ${widget.skillName} learning journey!',
                              style: GoogleFonts.spaceGrotesk(),
                            ),
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            width: MediaQuery.of(context).size.width * 0.9,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 52, 76, 183),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.play_circle_outline),
                      label: Text(
                        'Start Learning',
                        style: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [_buildOverviewTab()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'About this Skill',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Learn the fundamentals and advanced concepts of ${widget.skillName}. '
          'This skill covers everything from basics to professional-level techniques that are '
          'essential for modern applications and career growth.',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 15,
            color: Colors.black87,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'What you\'ll learn',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        _buildLearningPoint(
          'Understand core principles and concepts of ${widget.skillName}',
        ),
        _buildLearningPoint(
          'Build real-world projects from scratch with practical applications',
        ),
        _buildLearningPoint(
          'Master advanced techniques used by industry professionals',
        ),
        _buildLearningPoint('Learn best practices and optimization strategies'),
        _buildLearningPoint(
          'Prepare for technical interviews and skill assessments',
        ),
        const SizedBox(height: 24),
        Text(
          'Skill Level',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildSkillLevelCard(
                title: 'Beginner',
                description: 'No experience needed',
                isActive: false,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildSkillLevelCard(
                title: 'Intermediate',
                description: 'Some basics required',
                isActive: true,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildSkillLevelCard(
                title: 'Advanced',
                description: 'Expert knowledge',
                isActive: false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Prerequisites',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recommended skills to know before starting:',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              _buildPrerequisite('Basic programming knowledge', true),
              _buildPrerequisite(
                'Understanding of UI/UX principles',
                widget.skillName.contains('Design'),
              ),
              _buildPrerequisite('HTML, CSS and JavaScript fundamentals', true),
              _buildPrerequisite('Git version control', false),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildLearningPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, size: 20, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillLevelCard({
    required String title,
    required String description,
    required bool isActive,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:
            isActive
                ? const Color.fromARGB(255, 52, 76, 183).withOpacity(0.1)
                : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color:
              isActive
                  ? const Color.fromARGB(255, 52, 76, 183)
                  : Colors.grey.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              fontWeight: FontWeight.bold,
              color:
                  isActive
                      ? const Color.fromARGB(255, 52, 76, 183)
                      : Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrerequisite(String text, bool required) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(
            required ? Icons.lock : Icons.lock_open,
            size: 20,
            color: required ? Colors.red : Colors.green,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
