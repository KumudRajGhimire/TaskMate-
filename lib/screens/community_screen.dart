import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final TextEditingController _postController = TextEditingController();
  final List<CommunityPost> _posts = [
    CommunityPost(
      userId: 'user1',
      username: 'ansh1',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      content: 'Helo i recently purchased fs - ct6b transmitter...',
      upvotes: 15,
      downvotes: 2,
      commentCount: 1,
    ),
    CommunityPost(
      userId: 'user2',
      username: 'Coolbubble16',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      content: 'Using that tx is a mistake',
      upvotes: 5,
      downvotes: 10,
      commentCount: 3,
    ),
    // Add more dummy posts
  ];

  void _submitPost() {
    if (_postController.text.trim().isNotEmpty) {
      setState(() {
        _posts.insert(
          0,
          CommunityPost(
            userId: 'you',
            username: 'You', // Or get the actual username
            timestamp: DateTime.now(),
            content: _postController.text.trim(),
            upvotes: 0,
            downvotes: 0,
            commentCount: 0,
          ),
        );
        _postController.clear();
      });
      // In a real app, send the post to your backend
    }
  }

  void _upvote(int index) {
    setState(() {
      _posts[index].upvotes++;
      // In a real app, update the backend
    });
  }

  void _downvote(int index) {
    setState(() {
      _posts[index].downvotes++;
      // In a real app, update the backend
    });
  }

  void _viewComments(int index) {
    // Navigate to a comments screen for _posts[index]
    print('View comments for post at index $index');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community', style: TextStyle(color: Colors.white)),
        backgroundColor: theme.isDarkMode
            ? theme.darkTheme.primaryColor
            : theme.lightTheme.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Implement search
            },
          ),
        ],
      ),
      backgroundColor: theme.isDarkMode
          ? theme.darkTheme.scaffoldBackgroundColor
          : theme.lightTheme.scaffoldBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _postController,
                    decoration: const InputDecoration(
                      hintText: 'Ask Question / Share Update',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: null, // Allows multiline input
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _submitPost,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.isDarkMode
                        ? theme.darkTheme.primaryColor
                        : theme.lightTheme.primaryColor,
                  ),
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  color: theme.isDarkMode ? Colors.grey[800] : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Optional: User Avatar
                            Text(
                              post.username,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              _formatTimestamp(post.timestamp),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(post.content),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildInteractionButton(
                              icon: Icons.arrow_upward,
                              count: post.upvotes,
                              onTap: () => _upvote(index),
                            ),
                            _buildInteractionButton(
                              icon: Icons.arrow_downward,
                              count: post.downvotes,
                              onTap: () => _downvote(index),
                            ),
                            _buildInteractionButton(
                              icon: Icons.comment,
                              count: post.commentCount,
                              label: '1 comment', // Hardcoded for the example
                              onTap: () => _viewComments(index),
                            ),
                            const Icon(Icons.bookmark_border), // Example: Bookmark
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionButton({
    required IconData icon,
    int? count,
    String? label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 4.0),
          if (count != null) Text('$count'),
          if (label != null) Text(' $label'),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }
}

class CommunityPost {
  final String userId;
  final String username;
  final DateTime timestamp;
  final String content;
  int upvotes;
  int downvotes;
  int commentCount;

  CommunityPost({
    required this.userId,
    required this.username,
    required this.timestamp,
    required this.content,
    this.upvotes = 0,
    this.downvotes = 0,
    this.commentCount = 0,
  });
}