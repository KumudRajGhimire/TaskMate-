import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = 'Loading...';
  String _location = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userData.exists) {
          setState(() {
            _username = userData.data()?['username'] ?? 'Username not found';
            _location = userData.data()?['location'] ?? 'Location not found';
          });
        } else {
          setState(() {
            _username = 'User data not found';
            _location = 'User data not found';
          });
        }
      } catch (e) {
        print('Error fetching user data: $e');
        setState(() {
          _username = 'Error loading data';
          _location = 'Error loading data';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

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
                backgroundImage: user?.photoURL != null
                    ? NetworkImage(user!.photoURL!)
                    : null,
                child:
                user?.photoURL == null ? Icon(Icons.person, size: 50) : null,
              ),
            ),
            SizedBox(height: 16),
            Center(
                child: Text(_username,
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            SizedBox(height: 24),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(user?.email ?? 'user@example.com'),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Location: $_location'),
            ),
            ListTile(
              leading: Icon(Icons.stars),
              title: Text('Skills: Placeholder Skills'),
            ),
            SizedBox(height: 24),
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
                  icon: Icon(Provider.of<ThemeProvider>(context).themeMode ==
                      ThemeMode.light
                      ? Icons.light_mode
                      : Icons.dark_mode),
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
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