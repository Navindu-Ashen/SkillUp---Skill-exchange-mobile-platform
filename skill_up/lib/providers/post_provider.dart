import 'package:flutter/material.dart';
import 'package:skill_up/model/post.dart';

class PostProvider extends ChangeNotifier {
  List<Post> posts = [
    Post(
      profileImageUrl:
          "assets/WhatsApp Image 2024-07-12 at 12.43.14_eab6b053.jpg",
      userName: "Kasun Karunanayake",
      userTitle: "Intern Software Engineer at ION Groups",
      postTime: "2h ago",
      postText:
          "Hi everyone! I'm looking to expand my technical skills while sharing my knowledge in mobile development. Let's connect if you're interested in skill exchange!",
      likeCount: 48,
      commentCount: 21,
      skillsOffered: [
        "Flutter Development",
        "Mobile UI Design",
        "Firebase Integration",
      ],
      skillsSought: [
        "Machine Learning",
        "Backend Development",
        "Cloud Architecture",
      ],
      isLiked: false,
      isSaved: true,
    ),
    Post(
      profileImageUrl: "assets/profile.jpg",
      userName: "Kavya Samaraweera",
      userTitle: "Senior Security Engineer at Tech Co.",
      postTime: "3h ago",
      postText:
          "Security Engineers design, implement, and maintain cybersecurity solutions to protect an organization's data and systems from unauthorized access, cyberattacks, and other threats. I'm offering mentorship in cybersecurity fundamentals and seeking to learn more about AI integration!",
      likeCount: 42,
      commentCount: 8,
      skillsOffered: [
        "Cybersecurity",
        "Network Security",
        "Ethical Hacking",
        "Security Analysis",
      ],
      skillsSought: ["AI for Security", "Machine Learning", "Data Science"],
      isLiked: true,
      isSaved: false,
    ),
    Post(
      profileImageUrl: "assets/a3ca5640f72c2391c84658bf236708e3.jpg",
      userName: "Chamodi Wickramasinghe",
      userTitle: "Photographer & Content Creator",
      postTime: "Yesterday",
      postText:
          "Just wrapped up an amazing photoshoot for a local brand! I'm offering photography and video editing skills, and seeking to improve my website building capabilities.",
      likeCount: 89,
      commentCount: 23,
      postImages: [
        "assets/973e3adc3f76ec46ce57e522855860a3.jpg",
        "assets/9435a19d256b4bf9f0e4abc3646cef00.jpg",
      ],
      skillsOffered: [
        "Photography",
        "Video Editing",
        "Adobe Lightroom",
        "Adobe Premiere",
      ],
      skillsSought: ["Web Development", "WordPress", "E-commerce Setup"],
      isLiked: false,
      isSaved: true,
    ),
    Post(
      profileImageUrl: "assets/doc9.jpg",
      userName: "Frank Fernando",
      userTitle: "Senior Software Engineer WorkSync (pvt) ltd",
      postTime: "3h ago",
      postText:
          "We are hiring Graphic Designers, Content Managers, and Copywriters. I'm also personally interested in exchanging skills with creative professionals - I can offer coding knowledge in exchange!",
      likeCount: 42,
      commentCount: 8,
      postImages: ["assets/job3.2.jpg"],
      skillsOffered: [
        "Full-stack Development",
        "React",
        "UI/UX Design",
        "Project Management",
      ],
      skillsSought: [
        "Digital Marketing",
        "Content Writing",
        "Photography",
        "Graphic Design",
      ],
      isLiked: false,
      isSaved: false,
    ),
    Post(
      profileImageUrl: "assets/brazo-latest-short-off-white-wom.jpg",
      userName: "Amali Fernando",
      userTitle: "Freelance UX Designer",
      postTime: "5h ago",
      postText:
          "Just finished a workshop on advanced UI/UX techniques! Looking to exchange my design skills for help with learning programming fundamentals. Anyone interested in a skill swap?",
      likeCount: 36,
      commentCount: 14,
      skillsOffered: [
        "UI/UX Design",
        "Wireframing",
        "User Research",
        "Figma Prototyping",
      ],
      skillsSought: ["JavaScript", "Flutter Development", "Basic Programming"],
      isLiked: true,
      isSaved: true,
    ),
    Post(
      profileImageUrl: "assets/profile3.jpg",
      userName: "Sachith Jayasinghe",
      userTitle: "Data Analyst at DataTech Solutions",
      postTime: "8h ago",
      postText:
          "Working on a fascinating data visualization project using Python and Tableau. I'm looking to exchange my data analysis knowledge for some creative design skills. Anyone interested?",
      likeCount: 27,
      commentCount: 9,
      postImages: [
        "assets/Data-Science-for-Beginners-Python-for-Data-Analysis_Watermarked.db873f10250a.jpg",
      ],
      skillsOffered: [
        "Data Analysis",
        "Python",
        "Tableau",
        "SQL",
        "Statistical Analysis",
      ],
      skillsSought: [
        "Graphic Design",
        "Data Visualization Design",
        "UI/UX Design",
      ],
      isLiked: false,
      isSaved: true,
    ),
  ];

  void addPost(Post newPost) {
    posts.add(newPost);
    notifyListeners();
  }

  // New method to toggle like on a post
  void toggleLike(String postId) {
    final postIndex = posts.indexWhere((post) => post.id == postId);
    if (postIndex != -1) {
      final post = posts[postIndex];
      final updatedPost = Post(
        id: post.id,
        userId: post.userId,
        userName: post.userName,
        userTitle: post.userTitle,
        profileImageUrl: post.profileImageUrl,
        postText: post.postText,
        postImages: post.postImages,
        postTime: post.postTime,
        skillsOffered: post.skillsOffered,
        skillsSought: post.skillsSought,
        likeCount:
            (post.isLiked ?? false) ? post.likeCount! - 1 : post.likeCount! + 1,
        commentCount: post.commentCount,
        isLiked: !(post.isLiked ?? false),
        isSaved: post.isSaved,
      );
      posts[postIndex] = updatedPost;
      notifyListeners();
    }
  }

  // New method to toggle save on a post
  void toggleSave(String postId) {
    final postIndex = posts.indexWhere((post) => post.id == postId);
    if (postIndex != -1) {
      final post = posts[postIndex];
      final updatedPost = Post(
        id: post.id,
        userId: post.userId,
        userName: post.userName,
        userTitle: post.userTitle,
        profileImageUrl: post.profileImageUrl,
        postText: post.postText,
        postImages: post.postImages,
        postTime: post.postTime,
        skillsOffered: post.skillsOffered,
        skillsSought: post.skillsSought,
        likeCount: post.likeCount,
        commentCount: post.commentCount,
        isLiked: post.isLiked,
        isSaved: !(post.isSaved ?? false),
      );
      posts[postIndex] = updatedPost;
      notifyListeners();
    }
  }

  // Search posts based on skills
  List<Post> searchPosts(String query) {
    if (query.isEmpty) {
      return posts;
    }

    query = query.toLowerCase();

    return posts.where((post) {
      // Search in skills offered
      final skillsOffered =
          post.skillsOffered?.map((s) => s.toLowerCase()).toList() ?? [];
      // Search in skills sought
      final skillsSought =
          post.skillsSought?.map((s) => s.toLowerCase()).toList() ?? [];
      // Search in post text
      final postText = (post.postText ?? '').toLowerCase();
      // Search in username
      final userName = (post.userName ?? '').toLowerCase();

      return skillsOffered.any((skill) => skill.contains(query)) ||
          skillsSought.any((skill) => skill.contains(query)) ||
          postText.contains(query) ||
          userName.contains(query);
    }).toList();
  }
}
