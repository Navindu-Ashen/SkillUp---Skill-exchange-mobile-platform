import 'package:skill_up/model/learning.dart';

class PodcastData {
  static List<PodcastModel> getPodcasts() {
    return [
      PodcastModel(
        id: "1",
        title: "Flutter Course for Beginners",
        host: "freeCodeCamp.org",
        description:
            "In this course, you will learn how to build iOS and Android apps with Google's Flutter and Dart. The course is designed for beginners and covers everything you need to know to build apps with Flutter.",
        youtubeVideoUrl: "https://youtu.be/VPvVD8t02U8?si=rnCK9Fu17XUfPYFt",
        imagePath: "assets/0408-FlutterMessangerDemo-Luke_Social.png",
        topics: ["Flutter", "Dart", "Mobile Development"],
        episodes: [
          "Introduction to Flutter",
          "Building your first Flutter app",
          "Working with widgets in Flutter",
          "Building a weather app with Flutter",
          "Building a chat app with Flutter",
        ],
        duration: "37 hr 30 min",
        rating: "4.9",
        listenCount: "3.2M",
      ),
      PodcastModel(
        id: "2",
        title: "React Tutorial for Beginners",
        host: "Programming with Mosh",
        description:
            "In this tutorial, you will learn React from scratch. You will learn everything from setting up your development environment to deploying your app to the cloud.",
        youtubeVideoUrl: "https://youtu.be/SqcY0GlETPk?si=dYd5ibiRu4Q4t3pm",
        imagePath: "assets/react-must-be-in-scope-when-using-jsx-scaled-1.jpg",
        topics: ["React", "JavaScript", "Frontend Development"],
        episodes: [
          "Introduction to React",
          "Setting up your development environment",
          "Components in React",
          "Props and state in React",
          "Building a counter app with React",
        ],
        duration: "85 min",
        rating: "4.9",
        listenCount: "4.2M",
      ),
      PodcastModel(
        id: "3",
        title: "Falling in Love with Web Development",
        host: "Kyle Cook",
        description:
            "If you've gone on YouTube and searched how to get stuff done in web development, chances are you’ve come across Kyle Cook from web dev simplified. He's put up an incredible catalog of videos to simplify web development, for free. ",
        youtubeVideoUrl: "https://youtu.be/F7XGddoTxrA?si=0Cc8oWPhl9Sj29Ez",
        imagePath: "assets/kyle.jpg",
        topics: ["Web Development", "Career Growth", "Best Practices"],
        episodes: [
          "Kyle's journey to web dev",
          "Starting from scratch as developer",
          "How Kyle's YouTube channel came to be",
          "Kyle's favorite web dev tools",
        ],
        duration: "52 min",
        rating: "4.8",
        listenCount: "136.8K",
      ),
    ];
  }

  static PodcastModel getPodcastById(String id) {
    return getPodcasts().firstWhere(
      (podcast) => podcast.id == id,
      orElse: () => throw Exception("Podcast not found"),
    );
  }
}
