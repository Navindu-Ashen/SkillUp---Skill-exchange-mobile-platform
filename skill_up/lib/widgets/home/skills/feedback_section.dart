// ignore_for_file: deprecated_member_use
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skill_up/model/skill.dart';
import 'package:skill_up/providers/user_provider.dart';

class FeedbackSection extends StatefulWidget {
  final List<SkillFeedback>? feedback;
  final double rating;
  final int reviewCount;
  final String skillId;

  const FeedbackSection({
    super.key,
    required this.feedback,
    required this.rating,
    required this.reviewCount,
    required this.skillId,
  });

  @override
  State<FeedbackSection> createState() => _FeedbackSectionState();
}

class _FeedbackSectionState extends State<FeedbackSection> {
  late final UserProvider userProvider;
  List<SkillFeedback>? _feedback;
  double _rating = 0;
  int _reviewCount = 0;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    _feedback = widget.feedback != null ? List.from(widget.feedback!) : [];
    _rating = widget.rating;
    _reviewCount = widget.reviewCount;
  }

  void _addReview(SkillFeedback feedback) {
    setState(() {
      _feedback ??= [];
      _feedback!.insert(0, feedback); // Add new review at the top
      _reviewCount++;

      // Recalculate average rating
      double totalRating = 0;
      for (var review in _feedback!) {
        totalRating += review.rating;
      }
      _rating = totalRating / _feedback!.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_feedback == null || _feedback!.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const Text("No reviews yet"),
              const SizedBox(height: 16),
              _buildWriteReviewButton(context),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Feedbacks & Ratings',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Customer Feedbacks ($_reviewCount)",
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            // Reviews summary
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      _rating.toStringAsFixed(1),
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < _rating.floor()
                              ? Icons.star
                              : (index < _rating
                                  ? Icons.star_half
                                  : Icons.star_border),
                          size: 16,
                          color: Colors.amber,
                        );
                      }),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Based on $_reviewCount feedbacks",
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      _buildRatingBar(5, _calculatePercentage(5)),
                      _buildRatingBar(4, _calculatePercentage(4)),
                      _buildRatingBar(3, _calculatePercentage(3)),
                      _buildRatingBar(2, _calculatePercentage(2)),
                      _buildRatingBar(1, _calculatePercentage(1)),
                    ],
                  ),
                ),
              ],
            ),

            const Divider(height: 24),

            // Write Review Button
            _buildWriteReviewButton(context),

            const Divider(height: 24),

            // Individual reviews
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: min(3, _feedback!.length), // Show max 3 reviews
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final review = _feedback![index];
                return _buildReviewItem(context, review);
              },
            ),

            if (_feedback!.length > 3)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: OutlinedButton(
                    onPressed: () {
                      // Navigate to all reviews screen
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color.fromARGB(255, 52, 76, 183),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      "View All Reviews",
                      style: GoogleFonts.spaceGrotesk(
                        color: const Color.fromARGB(255, 52, 76, 183),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  double _calculatePercentage(int stars) {
    if (_feedback == null || _feedback!.isEmpty) return 0;

    int count = 0;
    for (var review in _feedback!) {
      if (review.rating.round() == stars) {
        count++;
      }
    }

    return count / _feedback!.length;
  }

  // Write Review button
  Widget _buildWriteReviewButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _showWriteReviewSheet(context),
        icon: const Icon(
          Icons.rate_review,
          color: Color.fromARGB(255, 52, 76, 183),
          size: 20,
        ),
        label: Text(
          "Write a Feedback",
          style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          side: const BorderSide(color: Color.fromARGB(255, 52, 76, 183)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          foregroundColor: const Color.fromARGB(255, 52, 76, 183),
        ),
      ),
    );
  }

  // Show write review bottom sheet
  void _showWriteReviewSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => WriteReviewSheet(
            productId: widget.skillId,
            onReviewSubmitted: _addReview,
          ),
    );
  }

  Widget _buildReviewItem(BuildContext context, SkillFeedback feedback) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage:
                    feedback.reviewerImage != null
                        ? AssetImage(feedback.reviewerImage!)
                        : null,
                child:
                    feedback.reviewerImage == null
                        ? Text(
                          feedback.reviewerName.substring(0, 1),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                        : null,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        feedback.reviewerName,
                        style: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    DateFormat('MMM dd, yyyy').format(feedback.date),
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: List.generate(5, (i) {
                  return Icon(
                    i < feedback.rating.floor()
                        ? Icons.star
                        : (i < feedback.rating
                            ? Icons.star_half
                            : Icons.star_border),
                    size: 16,
                    color: Colors.amber,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(feedback.comment, style: GoogleFonts.spaceGrotesk(fontSize: 14)),
          if (feedback.images != null && feedback.images!.isNotEmpty)
            Container(
              height: 80,
              margin: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: feedback.images!.length,
                itemBuilder: (context, i) {
                  return Container(
                    height: 80,
                    width: 80,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(feedback.images![i]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 10),
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  // Implement helpful counter
                },
                icon: const Icon(
                  Icons.thumb_up_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                label: Text(
                  "Helpful (${feedback.helpfulCount})",
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: const Size(0, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              const SizedBox(width: 10),
              TextButton.icon(
                onPressed: () {
                  // Implement report functionality
                },
                icon: const Icon(
                  Icons.flag_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                label: Text(
                  "Report",
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: const Size(0, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(int stars, double percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            "$stars",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.star, size: 12, color: Colors.amber),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 52, 76, 183),
                ),
                minHeight: 8,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "${(percentage * 100).toInt()}%",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class WriteReviewSheet extends StatefulWidget {
  final String productId;
  final Function(SkillFeedback feedback) onReviewSubmitted;

  const WriteReviewSheet({
    super.key,
    required this.productId,
    required this.onReviewSubmitted,
  });

  @override
  State<WriteReviewSheet> createState() => _WriteReviewSheetState();
}

class _WriteReviewSheetState extends State<WriteReviewSheet> {
  double _rating = 5.0;
  final TextEditingController _reviewController = TextEditingController();
  final List<String> _selectedImages = [];
  bool _isSubmitting = false;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _submitReview() {
    if (_reviewController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please write your feedback before submitting."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      // Here you would normally submit the review to your backend
      // Create a new Review object
      final newReview = SkillFeedback(
        id: "r${DateTime.now().millisecondsSinceEpoch}",
        reviewerName: context.read<UserProvider>().user!.username,
        reviewerImage: context.read<UserProvider>().user!.profilePictureURL,
        rating: _rating,
        comment: _reviewController.text,
        date: DateTime.now(),
        images: _selectedImages.isNotEmpty ? List.from(_selectedImages) : null,
        helpfulCount: 0,
      );

      // Add review to product via callback
      widget.onReviewSubmitted(newReview);

      setState(() {
        _isSubmitting = false;
      });

      Navigator.pop(context);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Thank you for your feedback!"),
          backgroundColor: Color.fromARGB(255, 52, 76, 183),
        ),
      );
    });
  }

  void _selectImages() async {
    // In a real app, you would use image_picker to select images
    // Since we can't implement that here, we'll just add placeholder images
    setState(() {
      _selectedImages.add("assets/images/placeholder.jpg");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 16,
        left: 16,
        right: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Write a Feedback",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Rating selector
            Text(
              "Rating",
              style: GoogleFonts.spaceGrotesk(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 32,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 16),

            // Review text
            Text(
              "Your Review",
              style: GoogleFonts.spaceGrotesk(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _reviewController,
              decoration: InputDecoration(
                hintText: "Share your experience with this product...",
                hintStyle: GoogleFonts.spaceGrotesk(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 52, 76, 183),
                    width: 2,
                  ),
                ),
              ),
              maxLines: 5,
              maxLength: 500,
            ),
            const SizedBox(height: 16),

            // Add photos
            Text(
              "Add Photos (Optional)",
              style: GoogleFonts.spaceGrotesk(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                // Photo selection button
                InkWell(
                  onTap: _selectImages,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 32,
                      color: Color.fromARGB(255, 52, 76, 183),
                    ),
                  ),
                ),

                // Selected images
                if (_selectedImages.isNotEmpty)
                  Expanded(
                    child: Container(
                      height: 80,
                      margin: const EdgeInsets.only(left: 8),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _selectedImages.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 80,
                            height: 80,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: Image.asset(
                                    _selectedImages[index],
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 80,
                                        height: 80,
                                        color: Colors.grey[200],
                                        child: const Icon(Icons.image),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  top: -8,
                                  right: -8,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedImages.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.grey[300]!,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        size: 14,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 24),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 52, 76, 183),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  disabledBackgroundColor: const Color.fromARGB(
                    255,
                    52,
                    76,
                    183,
                  ).withOpacity(0.5),
                ),
                child:
                    _isSubmitting
                        ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                        : Text(
                          "Submit Review",
                          style: GoogleFonts.spaceGrotesk(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
