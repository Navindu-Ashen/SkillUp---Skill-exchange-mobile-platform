import 'package:skill_up/model/skill.dart';

class SkillExchangeItem {
  final Skill skill;
  int sessionCount; // Number of exchange sessions requested

  SkillExchangeItem({required this.skill, required this.sessionCount});
}

class SkillData {
  static final List<Skill> _skills = [
    Skill(
      id: 'skill_001',
      title: 'Python Programming',
      category: 'Programming',
      description:
          'Learn Python from basics to advanced concepts including data structures and algorithms.',
      imageUrl: 'assets/python.jpg',
      rating: 4.8,
      reviewCount: 245,
      isOffered: true,
      userId: 'user_001',
      level: SkillLevel.intermediate,
      relatedSkills: ['skill_002', 'skill_003'],
      feedback: [
        SkillFeedback(
          id: 'fb_001',
          reviewerName: 'Samantha Baddage',
          rating: 5.0,
          comment: 'Amazing teacher! Learned so much about Python.',
          date: DateTime(2024, 12, 23),
        ),
        SkillFeedback(
          id: 'fb_002',
          reviewerName: 'Upali Fernando',
          rating: 4.0,
          comment: 'Great session, very patient instructor.',
          date: DateTime(2025, 02, 28),
          helpfulCount: 12,
        ),
      ],
    ),
    Skill(
      id: 'skill_002',
      title: 'Graphic Design Basics',
      category: 'Design',
      description:
          'Seeking to learn Adobe Photoshop and Illustrator fundamentals.',
      imageUrl: 'assets/graphic.jpg',
      rating: 0.0,
      reviewCount: 0,
      isOffered: false,
      userId: 'user_002',
      level: SkillLevel.beginner,
      relatedSkills: ['skill_001', 'skill_003'],
    ),
    Skill(
      id: 'skill_003',
      title: 'Web Dev with React',
      category: 'Programming',
      description:
          'Offering expertise in building responsive web apps with React.',
      imageUrl: 'assets/react-must-be-in-scope-when-using-jsx-scaled-1.jpg',
      rating: 4.9,
      reviewCount: 198,
      isOffered: true,
      userId: 'user_003',
      level: SkillLevel.advanced,
      relatedSkills: ['skill_001', 'skill_002'],
      feedback: [
        SkillFeedback(
          id: 'fb_003',
          reviewerName: 'Nimesha Perera',
          rating: 4.5,
          comment: 'Really helpful session, great examples!',
          date: DateTime(2025, 03, 10),
        ),
      ],
    ),
    Skill(
      id: 'skill_004',
      title: 'Digital Photography',
      category: 'Photography',
      description:
          'Learn professional photography techniques with hands-on practice.',
      imageUrl: 'assets/cam.jpg',
      rating: 4.6,
      reviewCount: 275,
      isOffered: true,
      userId: 'user_004',
      level: SkillLevel.intermediate,
      relatedSkills: ['skill_002'],
      feedback: [
        SkillFeedback(
          id: 'fb_004',
          reviewerName: 'Chamathka Silva',
          rating: 5.0,
          comment: 'Fantastic learning experience!',
          date: DateTime(2024, 11, 05),
        ),
      ],
    ),
  ];

  static List<Skill> getAllSkills() {
    return _skills;
  }

  static List<Skill> getSkillsByCategory(String category) {
    return _skills.where((skill) => skill.category == category).toList();
  }

  static Skill? getSkillById(String id) {
    try {
      return _skills.firstWhere((skill) => skill.id == id);
    } catch (e) {
      return null; // Skill not found
    }
  }

  static List<Skill> searchSkills(String query) {
    if (query.isEmpty) {
      return _skills;
    }
    final lowerQuery = query.toLowerCase();
    return _skills.where((skill) {
      return skill.title.toLowerCase().contains(lowerQuery) ||
          skill.description.toLowerCase().contains(lowerQuery) ||
          skill.category.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  static List<Skill> getFeaturedSkills() {
    return _skills
        .where((skill) => skill.rating > 4.7 && skill.isOffered)
        .toList();
  }

  static List<String> getCategories() {
    return _skills.map((skill) => skill.category).toSet().toList();
  }

  static final List<Skill> _favorites = [];

  static List<Skill> get favorites => List.unmodifiable(_favorites);

  static void addToFavorites(Skill skill) {
    if (!_favorites.contains(skill)) {
      skill.isFavorite = true;
      _favorites.add(skill);
    }
  }

  static void removeFromFavorites(Skill skill) {
    skill.isFavorite = false;
    _favorites.remove(skill);
  }

  static bool isFavorite(String skillId) {
    return _favorites.any((skill) => skill.id == skillId);
  }

  static SkillExchangeItem createExchangeItem({
    required Skill skill,
    required int sessionCount,
  }) {
    return SkillExchangeItem(skill: skill, sessionCount: sessionCount);
  }

  static final List<SkillExchangeItem> _exchangeItems = [];

  static List<SkillExchangeItem> get exchangeItems =>
      List.unmodifiable(_exchangeItems);

  static int get exchangeItemCount {
    return _exchangeItems.fold(0, (sum, item) => sum + item.sessionCount);
  }

  static void addToExchange(Skill skill, int sessionCount) {
    final existingItemIndex = _exchangeItems.indexWhere(
      (item) => item.skill.id == skill.id,
    );

    if (existingItemIndex != -1) {
      _exchangeItems[existingItemIndex].sessionCount += sessionCount;
    } else {
      _exchangeItems.add(
        SkillExchangeItem(skill: skill, sessionCount: sessionCount),
      );
    }
  }

  static void updateExchangeItemCount(String skillId, int newCount) {
    final index = _exchangeItems.indexWhere((item) => item.skill.id == skillId);
    if (index != -1) {
      if (newCount <= 0) {
        _exchangeItems.removeAt(index);
      } else {
        _exchangeItems[index].sessionCount = newCount;
      }
    }
  }

  static void removeFromExchange(String skillId) {
    _exchangeItems.removeWhere((item) => item.skill.id == skillId);
  }

  static void clearExchange() {
    _exchangeItems.clear();
  }
}
