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
          'Learn Python from the ground up, starting with fundamental concepts such as syntax, variables, data types, and control flow. Progress through more advanced topics, including object-oriented programming (OOP), file handling, and exception handling. Dive deep into data structures such as lists, tuples, dictionaries, and sets, and explore algorithmic problem-solving techniques, including sorting, searching, recursion, and dynamic programming.',
      imageUrl: 'assets/python.jpg',
      rating: 4.8,
      reviewCount: 245,
      isOffered: true,
      userId: 'Kavya Perera',
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
          'I want to learn the fundamentals of Adobe Photoshop and Illustrator to enhance my skills in graphic design, image editing, and vector illustration. My goal is to understand essential tools, techniques, and workflows in both software programs. In Photoshop, I want to focus on photo manipulation, retouching, layer management, and creating digital compositions. In Illustrator, I aim to master vector graphics, logo design, typography, and scalable illustrations. I am interested in learning practical applications for UI/UX design, marketing materials, and creative projects that could complement my work in app and web development.',
      imageUrl: 'assets/graphic.jpg',
      rating: 0.0,
      reviewCount: 0,
      isOffered: false,
      userId: 'Kasun Fernando',
      level: SkillLevel.beginner,
      relatedSkills: ['skill_001', 'skill_003'],
    ),
    Skill(
      id: 'skill_003',
      title: 'Web Dev with React',
      category: 'Programming',
      description:
          'Offering expertise in building responsive and dynamic web applications using React, with a strong focus on performance optimization, intuitive user interfaces, and seamless user experiences. Skilled in leveraging modern front-end technologies such as React Hooks, Context API, Redux, and Tailwind CSS to create scalable and maintainable applications. Experienced in integrating RESTful APIs, Firebase, and third-party libraries to enhance functionality while ensuring cross-browser compatibility and mobile responsiveness.',
      imageUrl: 'assets/react-must-be-in-scope-when-using-jsx-scaled-1.jpg',
      rating: 4.9,
      reviewCount: 198,
      isOffered: true,
      userId: 'Ganguli Dissanayake',
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
          "Master professional photography techniques through hands-on practice with expert guidance. Explore essential skills such as composition, lighting, camera settings, and post-processing to elevate your photography to the next level. Whether you're a beginner or looking to refine your craft, our immersive approach ensures you gain real-world experience and confidence behind the lens.",
      imageUrl: 'assets/cam.jpg',
      rating: 4.6,
      reviewCount: 275,
      isOffered: true,
      userId: 'Kavithma Jayawardena',
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
