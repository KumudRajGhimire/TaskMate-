// gig_model.dart
class Gig {
  final String title;
  final String description;
  final String category;
  final String offeredSkill;
  final DateTime? deadline;
  final DateTime timestamp;
  final String posterId;

  Gig({
    required this.title,
    required this.description,
    required this.category,
    required this.offeredSkill,
    this.deadline,
    required this.timestamp,
    required this.posterId,
  });

  // Optional: Add a factory method to create a Gig from a map (for Firebase)
  factory Gig.fromMap(Map<String, dynamic> data) {
    return Gig(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      offeredSkill: data['offeredSkill'] ?? '',
      deadline: data['deadline'] != null ? DateTime.tryParse(data['deadline']) : null,
      timestamp: DateTime.tryParse(data['timestamp']) ?? DateTime.now(),
      posterId: data['posterId'] ?? '',
    );
  }

  // Optional: Add a method to convert a Gig to a map (for Firebase)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'offeredSkill': offeredSkill,
      'deadline': deadline?.toIso8601String(),
      'timestamp': timestamp.toIso8601String(),
      'posterId': posterId,
    };
  }
}