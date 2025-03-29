class ChatMessage {
  final String text;
  final bool isFromMe;
  final DateTime timestamp;
  final String? imageUrl;

  ChatMessage({
    required this.text,
    required this.isFromMe,
    required this.timestamp,
    this.imageUrl,
  });
}
