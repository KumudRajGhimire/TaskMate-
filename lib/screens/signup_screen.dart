import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main_screen.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _locationController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text == _confirmPasswordController.text) {
        try {
          final userCredential = await _auth.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
          await _firestore.collection('users').doc(userCredential.user!.uid).set({
            'username': _usernameController.text.trim(),
            'location': _locationController.text.trim(),
            'email': _emailController.text.trim(),
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Signup failed: ${e.message}')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An unexpected error occurred.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: theme.isDarkMode ? theme.darkTheme.scaffoldBackgroundColor : theme.lightTheme.scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Image.asset(
                    'skilltrade.png', // Replace with your actual path
                    height: 80,
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: theme.isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    labelStyle: TextStyle(color: theme.isDarkMode ? Colors.white70 : Colors.grey),
                    filled: true,
                    fillColor: theme.isDarkMode ? Colors.black87 : Colors.grey[200],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: theme.isDarkMode ? theme.darkTheme.primaryColor : theme.lightTheme.primaryColor)),
                  ),
                  validator: (value) => value == null || value.trim().isEmpty ? 'Please enter your email' : (value.contains('@') ? null : 'Please enter a valid email'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _usernameController,
                  style: TextStyle(color: theme.isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: theme.isDarkMode ? Colors.white70 : Colors.grey),
                    filled: true,
                    fillColor: theme.isDarkMode ? Colors.black87 : Colors.grey[200],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: theme.isDarkMode ? theme.darkTheme.primaryColor : theme.lightTheme.primaryColor)),
                  ),
                  validator: (value) => value == null || value.trim().isEmpty ? 'Enter username' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _locationController,
                  style: TextStyle(color: theme.isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Location',
                    labelStyle: TextStyle(color: theme.isDarkMode ? Colors.white70 : Colors.grey),
                    filled: true,
                    fillColor: theme.isDarkMode ? Colors.black87 : Colors.grey[200],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: theme.isDarkMode ? theme.darkTheme.primaryColor : theme.lightTheme.primaryColor)),
                  ),
                  validator: (value) => value == null || value.trim().isEmpty ? 'Enter location' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: TextStyle(color: theme.isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: theme.isDarkMode ? Colors.white70 : Colors.grey),
                    filled: true,
                    fillColor: theme.isDarkMode ? Colors.black87 : Colors.grey[200],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: theme.isDarkMode ? theme.darkTheme.primaryColor : theme.lightTheme.primaryColor)),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Enter password' : (value.length < 6 ? 'Password must be at least 6 characters' : null),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  style: TextStyle(color: theme.isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: theme.isDarkMode ? Colors.white70 : Colors.grey),
                    filled: true,
                    fillColor: theme.isDarkMode ? Colors.black87 : Colors.grey[200],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: theme.isDarkMode ? theme.darkTheme.primaryColor : theme.lightTheme.primaryColor)),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Confirm password' : (value != _passwordController.text ? 'Passwords do not match' : null),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _signup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.isDarkMode ? theme.darkTheme.primaryColor : theme.lightTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                  child: const Text('Sign Up', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account? ", style: TextStyle(color: theme.isDarkMode ? Colors.white70 : Colors.grey)),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(foregroundColor: theme.isDarkMode ? theme.darkTheme.primaryColor : theme.lightTheme.primaryColor),
                      child: const Text('Sign In', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}