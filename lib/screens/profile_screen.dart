import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = 'Loading...';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _email = FirebaseAuth.instance.currentUser?.email ?? '';
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
          });
        } else {
          setState(() {
            _username = 'User data not found';
          });
        }
      } catch (e) {
        print('Error fetching user data: $e');
        setState(() {
          _username = 'Error loading data';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            IconButton(
              icon: Icon(Provider.of<ThemeProvider>(context).themeMode ==
                  ThemeMode.light
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined),
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
              },
            ),
          ],
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: user?.photoURL != null
                    ? NetworkImage(user!.photoURL!)
                    : null,
                child:
                user?.photoURL == null ? Icon(Icons.person, size: 70) : null,
              ),
            ),
            SizedBox(height: 12),
            Center(
              child: Text(
                _username,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            if (_email.isNotEmpty)
              Center(
                child: Text(
                  _email,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                  ),
                ),
              ),
            SizedBox(height: 24),
            _buildProfileMenuItem(
              icon: Icons.shield_outlined,
              text: 'Privacy Policy',
              onTap: () {
                print('Privacy Policy pressed');
                // Implement navigation or action
              },
            ),
            SizedBox(height: 12),
            _buildProfileMenuItem(
              icon: Icons.notifications_outlined,
              text: 'Notification',
              onTap: () {
                print('Notification pressed');
                // Implement navigation or action
              },
            ),
            SizedBox(height: 12),
            _buildProfileMenuItem(
              icon: Icons.person_add_outlined,
              text: 'Invite a Friend',
              onTap: () {
                print('Invite a Friend pressed');
                // Implement navigation or action
              },
            ),
            SizedBox(height: 12),
            _buildProfileMenuItem(
              icon: Icons.settings_outlined,
              text: 'Settings',
              onTap: () {
                print('Settings pressed');
                // Implement navigation or action
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: <Widget>[
            Icon(icon, color: theme.iconTheme.color),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Icon(Icons.arrow_forward_ios_outlined, color: theme.iconTheme.color, size: 18),
          ],
        ),
      ),
    );
  }
}