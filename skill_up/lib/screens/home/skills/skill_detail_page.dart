// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_up/data/skill.dart';
import 'package:skill_up/model/skill.dart';
import 'package:skill_up/widgets/home/skills/bottom_exchange_bar.dart';
import 'package:skill_up/widgets/home/skills/skill_info.dart';
import 'package:skill_up/widgets/home/skills/feedback_section.dart';

class SkillDetailPage extends StatefulWidget {
  final String skillId;
  final Skill? skill;

  const SkillDetailPage({super.key, this.skillId = '', this.skill});

  @override
  _SkillDetailPageState createState() => _SkillDetailPageState();
}

class _SkillDetailPageState extends State<SkillDetailPage>
    with SingleTickerProviderStateMixin {
  late Skill _skill;
  bool _isLoading = true;
  bool _isFavorite = false;
  int _sessionCount = 1;
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Reduced to 2 tabs
    _loadSkill();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadSkill() async {
    if (widget.skill != null) {
      setState(() {
        _skill = widget.skill!;
        _isFavorite = _skill.isFavorite;
        _isLoading = false;
      });
      return;
    }

    await Future.delayed(const Duration(milliseconds: 500));
    final skill = SkillData.getSkillById(widget.skillId);

    if (skill != null) {
      setState(() {
        _skill = skill;
        _isFavorite = skill.isFavorite;
        _isLoading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      _skill.isFavorite = _isFavorite;

      if (_isFavorite) {
        SkillData.addToFavorites(_skill);
        _showSnackBar(
          'Added to favorites',
          const Color.fromARGB(255, 52, 76, 183),
        );
      } else {
        SkillData.removeFromFavorites(_skill);
        _showSnackBar('Removed from favorites', Colors.redAccent);
      }
    });
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(10),
      ),
    );
  }

  void _requestExchange() {
    SkillData.addToExchange(_skill, _sessionCount);
    _showSnackBar(
      'Requested $_sessionCount session${_sessionCount > 1 ? 's' : ''} for ${_skill.title}',
      const Color.fromARGB(255, 52, 76, 183),
    );
  }

  void _contactNow() {
    _showSnackBar(
      'Opening chat with ${_skill.isOffered ? 'mentor' : 'learner'}...',
      const Color.fromARGB(255, 52, 76, 183),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingScreen();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [_buildSliverAppBar()];
        },
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SkillInfoSection(
                    skill: _skill,
                    sessionCount: _sessionCount,
                    onSessionCountChanged: (newCount) {
                      setState(() => _sessionCount = newCount);
                    },
                  ),
                  FeedbackSection(
                    feedback: _skill.feedback,
                    rating: _skill.rating,
                    reviewCount: _skill.reviewCount,
                    skillId: _skill.id,
                  ),
                ],
              ),
            ),
            BottomExchangeBar(
              isOffered: _skill.isOffered,
              onRequestExchange: _requestExchange,
              onContactNow: _contactNow,
              skill: _skill,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Skill Details',
          style: GoogleFonts.spaceGrotesk(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Color.fromARGB(255, 52, 76, 183),
            ),
            const SizedBox(height: 16),
            Text(
              "Loading skill details...",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 300.0,
      floating: false,
      pinned: true,
      backgroundColor: Colors.white,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.black,
            ),
            onPressed: _toggleFavorite,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {
              _showSnackBar('Sharing ${_skill.title}...', Colors.black54);
            },
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              _skill.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color.fromARGB(255, 240, 240, 240),
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey[400],
                    ),
                  ),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
            Positioned(
              bottom: 48,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _skill.title,
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '${_skill.rating.toStringAsFixed(1)} (${_skill.reviewCount})',
                        style: GoogleFonts.spaceGrotesk(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottom: TabBar(
        controller: _tabController,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        labelStyle: GoogleFonts.spaceGrotesk(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        unselectedLabelStyle: GoogleFonts.spaceGrotesk(
          fontWeight: FontWeight.normal,
        ),
        indicatorColor: Color.fromARGB(255, 52, 76, 183),
        indicatorWeight: 3,
        tabs: const [Tab(text: "Overview"), Tab(text: "Feedback")],
      ),
    );
  }
}

// Extension to capitalize enum values
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
