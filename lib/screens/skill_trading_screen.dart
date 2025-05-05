import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class SkillTradingScreen extends StatelessWidget {
  const SkillTradingScreen({super.key});

  final List<SkillItem> _skillItems = const [
    SkillItem(
      title: "Flutter App Development",
      seller: "JohnDoe",
      priceRange: "₹ 500 - ₹ 5,000",
      description: "Expert in building cross-platform mobile applications using Flutter framework. Experienced with UI/UX design and backend integration.",
    ),
    SkillItem(
      title: "Website Design (UI/UX)",
      seller: "JaneSmith",
      priceRange: "₹ 1,000 - ₹ 10,000",
      description: "Creating modern and responsive website designs with a focus on user experience and visual appeal. Proficient in Figma and Adobe XD.",
    ),
    SkillItem(
      title: "Social Media Marketing",
      seller: "MarketGuru",
      priceRange: "₹ 800 - ₹ 8,000 / month",
      description: "Managing and growing your social media presence. Content creation, strategy development, and audience engagement.",
    ),
    SkillItem(
      title: "Graphic Design (Logos, Flyers)",
      seller: "ArtisticSoul",
      priceRange: "₹ 300 - ₹ 2,000",
      description: "Designing professional logos, flyers, banners, and other visual assets to elevate your brand.",
    ),
    // Add more skill items as needed
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skills', style: TextStyle(color: Colors.white)),
        backgroundColor: theme.isDarkMode
            ? theme.darkTheme.primaryColor
            : theme.lightTheme.primaryColor,
      ),
      backgroundColor: theme.isDarkMode
          ? theme.darkTheme.scaffoldBackgroundColor
          : theme.lightTheme.scaffoldBackgroundColor,
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _skillItems.length,
        itemBuilder: (context, index) {
          final skillItem = _skillItems[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            color: theme.isDarkMode ? Colors.grey[800] : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    skillItem.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(Icons.person_outline, size: 16.0, color: Colors.grey),
                      const SizedBox(width: 4.0),
                      Text(
                        skillItem.seller,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const Spacer(),
                      Text(
                        skillItem.priceRange,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: theme.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    skillItem.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: theme.isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          // Implement action to view details or hire
                          print("View details for ${skillItem.title}");
                        },
                        child: const Text('View Details'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SkillItem {
  final String title;
  final String seller;
  final String priceRange;
  final String description;

  const SkillItem({
    required this.title,
    required this.seller,
    required this.priceRange,
    required this.description,
  });
}