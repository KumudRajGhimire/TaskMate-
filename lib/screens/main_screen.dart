import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    SkillTradingScreen(),
    TutoringScreen(),
    ProjectMatchmakingScreen(),
    CommunityScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TaskMate', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Skills'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Tutoring'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Projects'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: 'Community'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class SkillTradingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Skill Trading', style: TextStyle(fontSize: 24)));
  }
}

class TutoringScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Tutoring', style: TextStyle(fontSize: 24)));
  }
}

class ProjectMatchmakingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Project Matchmaking', style: TextStyle(fontSize: 24)));
  }
}

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Community', style: TextStyle(fontSize: 24)));
  }
}