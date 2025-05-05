// main_screen.dart
import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'post_gig_screen_part1.dart'; // Import the first part of the post gig screen
import 'community_screen.dart';
import 'skill_trading_screen.dart'; // Import the SkillTradingScreen

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    SkillTradingScreen(), // This makes the Skills button load this screen
    SizedBox(), // Placeholder, the FAB will handle navigation
    CommunityScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    final primaryColor = theme.isDarkMode ? theme.darkTheme.primaryColor : theme.lightTheme.primaryColor;
    final textColor = theme.isDarkMode ? Colors.white70 : Colors.grey[600];

    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskMate', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: theme.isDarkMode ? theme.darkTheme.bottomNavigationBarTheme.backgroundColor : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: InkWell(
                onTap: () => _onItemTapped(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.storefront,
                        color: _selectedIndex == 0 ? primaryColor : textColor),
                    Text('Skills',
                        style: TextStyle(
                            color: _selectedIndex == 0 ? primaryColor : textColor,
                            fontSize: 12)),
                  ],
                ),
              ),
            ),
            const Spacer(), // To push the third item to the right
            Expanded(
              child: InkWell(
                onTap: () => _onItemTapped(2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.groups,
                        color: _selectedIndex == 2 ? primaryColor : textColor),
                    Text('Community',
                        style: TextStyle(
                            color: _selectedIndex == 2 ? primaryColor : textColor,
                            fontSize: 12)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PostGigScreenPart1()), // Navigate to the first part
            );
          },
          backgroundColor: primaryColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35)),
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
      backgroundColor: theme.isDarkMode
          ? theme.darkTheme.scaffoldBackgroundColor
          : theme.lightTheme.scaffoldBackgroundColor,
    );
  }
}