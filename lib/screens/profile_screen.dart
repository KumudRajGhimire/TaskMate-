// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
            ),
            SizedBox(height: 16),
            Center(child: Text('User Display Name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            SizedBox(height: 16),
            Row(
              children: <Widget>[
                Text('Status: '),
                Icon(Icons.circle, color: Colors.green, size: 16),
              ],
            ),
            SizedBox(height: 16),
            Text('Email: user@example.com'),
            SizedBox(height: 8),
            Text('Location: Placeholder Location'),
            SizedBox(height: 8),
            Text('Skills: Placeholder Skills'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Logout'),
            ),
            SizedBox(height: 16),
            Row(
              children: <Widget>[
                Text('Theme:'),
                IconButton(
                  icon: Icon(Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light ? Icons.light_mode : Icons.dark_mode),
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}