// Enum to define skill levels
enum SkillLevel { beginner, intermediate, advanced }

class Skill {
  final String id;
  final String title;
  final String category;
  final String description;
  final String imageUrl;
  final List<String>? additionalImages;
  final double rating;
  final int reviewCount;
  final bool isOffered;
  bool isFavorite;
  final String userId;
  final List<String>? relatedSkills;
  final List<SkillFeedback>? feedback;
  final SkillLevel level;

  Skill({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.imageUrl,
    this.additionalImages,
    required this.rating,
    required this.reviewCount,
    required this.isOffered,
    this.isFavorite = false,
    required this.userId,
    this.relatedSkills,
    this.feedback,
    required this.level,
  });
}

class SkillFeedback {
  final String id;
  final String reviewerName;
  final String? reviewerImage;
  final double rating;
  final String comment;
  final DateTime date;
  final List<String>? images;
  final int helpfulCount;

  SkillFeedback({
    required this.id,
    required this.reviewerName,
    this.reviewerImage,
    required this.rating,
    required this.comment,
    required this.date,
    this.images,
    this.helpfulCount = 0,
  });
}
