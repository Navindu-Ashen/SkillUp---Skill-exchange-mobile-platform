import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:skill_up/model/post.dart';
import 'package:uuid/uuid.dart';

class PostProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Post> posts = [
    // Your existing posts...
  ];

  // Improved addPost method
  Future<void> addPost(Post post) async {
    try {
      // Set loading state
      _isLoading = true;
      notifyListeners();

      // Generate a unique ID for the post
      final String postId = const Uuid().v4();

      // Upload images and get URLs
      List<String> imageUrls = [];
      for (String imagePath in post.postImages ?? []) {
        final imageUrl = await _uploadImage(File(imagePath), postId);
        imageUrls.add(imageUrl);
      }

      // Create a new Post object with the generated ID and image URLs
      final newPost = Post(
        id: postId,
        profileImageUrl: post.profileImageUrl,
        userName: post.userName,
        userTitle: post.userTitle,
        postTime: 'Just now', // Or format current time
        postText: post.postText,
        likeCount: 0,
        commentCount: 0,
        postImages: imageUrls,
        skillTitle: post.skillTitle,
        skillCategory: post.skillCategory,
        isOffering: post.isOffering,
        // Keep these for compatibility with existing code
        skillsOffered: [],
        skillsSought: [],
        isLiked: false,
        isSaved: false,
      );

      // Convert to map for Firestore
      final postData = {
        'id': postId,
        'profileImageUrl': newPost.profileImageUrl,
        'userName': newPost.userName,
        'userTitle': newPost.userTitle,
        'postTime': newPost.postTime,
        'postText': newPost.postText,
        'likeCount': newPost.likeCount,
        'commentCount': newPost.commentCount,
        'postImages': imageUrls,
        'skillTitle': newPost.skillTitle,
        'skillCategory': newPost.skillCategory,
        'isOffering': newPost.isOffering,
        'timestamp': DateTime.now().toIso8601String(),
        'skillsOffered': newPost.skillsOffered ?? [],
        'skillsSought': newPost.skillsSought ?? [],
        'isLiked': false,
        'isSaved': false,
      };

      // Save to Firebase
      await _firestore.collection('posts').doc(postId).set(postData);

      // Add to local list
      posts.insert(0, newPost); // Add to beginning of the list

      notifyListeners();
    } catch (e) {
      print("Error adding post: $e");
      throw e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Image upload helper method
  Future<String> _uploadImage(File imageFile, String postId) async {
    try {
      // Create a unique filename
      final String fileName =
          '${postId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final Reference storageRef = _storage.ref().child(
        'post_images/$fileName',
      );

      // Upload the file
      final UploadTask uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot taskSnapshot = await uploadTask;

      // Get the download URL
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      throw e;
    }
  }

  // Fetch posts from Firestore
  Future<void> fetchPosts() async {
    try {
      _isLoading = true;
      notifyListeners();

      final QuerySnapshot snapshot =
          await _firestore
              .collection('posts')
              .orderBy('timestamp', descending: true)
              .get();

      final List<Post> fetchedPosts =
          snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Post(
              id: doc.id,
              profileImageUrl: data['profileImageUrl'] ?? '',
              userName: data['userName'] ?? '',
              userTitle: data['userTitle'] ?? '',
              postTime: data['postTime'] ?? '',
              postText: data['postText'] ?? '',
              likeCount: data['likeCount'] ?? 0,
              commentCount: data['commentCount'] ?? 0,
              postImages: List<String>.from(data['postImages'] ?? []),
              skillTitle: data['skillTitle'],
              skillCategory: data['skillCategory'],
              isOffering: data['isOffering'] ?? true,
              skillsOffered: List<String>.from(data['skillsOffered'] ?? []),
              skillsSought: List<String>.from(data['skillsSought'] ?? []),
              isLiked: data['isLiked'] ?? false,
              isSaved: data['isSaved'] ?? false,
            );
          }).toList();

      // Add fetched posts to existing hardcoded posts
      // If you want to show only fetched posts, use: posts = fetchedPosts;
      posts = [...fetchedPosts, ...posts];
      //posts = fetchedPosts;

      notifyListeners();
    } catch (e) {
      print("Error fetching posts: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Your existing toggle methods
  void toggleLike(String postId) {
    // Existing code
  }

  void toggleSave(String postId) {
    // Existing code
  }

  // List<Post> searchPosts(String query) {
  //   // Existing code
  // }
}
