class Post {
  final String? id;
  final String? userId;
  final String? userName;
  final String? userTitle;
  final String? profileImageUrl;
  final String? postText;
  final List<String>? postImages;
  final String? postTime;
  final List<String>? skillsOffered;
  final List<String>? skillsSought;
  final int? likeCount;
  final int? commentCount;
  final bool? isLiked;
  final bool? isSaved;

  Post({
    this.id,
    this.userId,
    this.userName,
    this.userTitle,
    this.profileImageUrl,
    this.postText,
    this.postImages,
    this.postTime,
    this.skillsOffered,
    this.skillsSought,
    this.likeCount,
    this.commentCount,
    this.isLiked,
    this.isSaved,
  });

  // Factory method to create a Post from a Map (JSON)
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      userTitle: json['userTitle'],
      profileImageUrl: json['profileImageUrl'],
      postText: json['postText'],
      postImages:
          json['postImages'] != null
              ? List<String>.from(json['postImages'])
              : null,
      postTime: json['postTime'],
      skillsOffered:
          json['skillsOffered'] != null
              ? List<String>.from(json['skillsOffered'])
              : null,
      skillsSought:
          json['skillsSought'] != null
              ? List<String>.from(json['skillsSought'])
              : null,
      likeCount: json['likeCount'],
      commentCount: json['commentCount'],
      isLiked: json['isLiked'],
      isSaved: json['isSaved'],
    );
  }

  // Method to convert Post to a Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userTitle': userTitle,
      'profileImageUrl': profileImageUrl,
      'postText': postText,
      'postImages': postImages,
      'postTime': postTime,
      'skillsOffered': skillsOffered,
      'skillsSought': skillsSought,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'isLiked': isLiked,
      'isSaved': isSaved,
    };
  }
}
