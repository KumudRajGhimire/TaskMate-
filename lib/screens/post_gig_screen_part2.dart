// post_gig_screen_part2.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'gig_model.dart'; // Import the Gig model

class PostGigScreenPart2 extends StatefulWidget {
  final Map<String, String?> gigDataPart1;

  const PostGigScreenPart2({super.key, required this.gigDataPart1});

  @override
  State<PostGigScreenPart2> createState() => _PostGigScreenPart2State();
}

class _PostGigScreenPart2State extends State<PostGigScreenPart2> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usnController = TextEditingController();
  final _branchController = TextEditingController();
  final _semesterController = TextEditingController();
  final _locationController = TextEditingController();
  bool _termsAgreed = false;

  void _postGig() {
    if (_formKey.currentState!.validate() && _termsAgreed) {
      final category = widget.gigDataPart1['category']!; // Category is not nullable after Part 1 validation
      final deadline = widget.gigDataPart1['deadline'] != null
          ? DateTime.tryParse(widget.gigDataPart1['deadline']!)
          : null;

      final newGig = Gig(
        title: widget.gigDataPart1['title']!,
        description: widget.gigDataPart1['description']!,
        category: category,
        offeredSkill: widget.gigDataPart1['offeredSkill']!,
        deadline: deadline,
        timestamp: DateTime.now(),
        posterId: 'user_placeholder', // Replace with actual user ID later
        // You might want to handle personal info separately or include it in the Gig model
        // depending on your application's needs.
      );

      final posterInfo = {
        'name': _nameController.text.trim(),
        'usn': _usnController.text.trim(),
        'branch': _branchController.text.trim(),
        'semester': _semesterController.text.trim(),
        'location': _locationController.text.trim(),
      };

      print('Final Gig Data to Post: ${newGig.toMap()}');
      print('Poster Information: $posterInfo');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gig posted! (Data printed to console)')),
      );
      // In the next steps, we'll connect this to Firebase and likely handle
      // user information more securely.
    } else if (!_termsAgreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the terms and conditions')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post a Gig (2/2)', style: TextStyle(color: Colors.white)),
        backgroundColor: theme.isDarkMode
            ? theme.darkTheme.primaryColor
            : theme.lightTheme.primaryColor,
        elevation: 0,
      ),
      backgroundColor: theme.isDarkMode
          ? theme.darkTheme.scaffoldBackgroundColor
          : theme.lightTheme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Step Indicator
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Step 1', style: TextStyle(color: Colors.grey)),
                  Text('Step 2', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 20.0),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) => value == null || value.trim().isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 15.0),

              TextFormField(
                controller: _usnController,
                decoration: const InputDecoration(
                  labelText: 'University Serial Number (USN)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.school),
                ),
                validator: (value) => value == null || value.trim().isEmpty ? 'Please enter your USN' : null,
              ),
              const SizedBox(height: 15.0),

              TextFormField(
                controller: _branchController,
                decoration: const InputDecoration(
                  labelText: 'Branch',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.workspaces_outlined),
                ),
                validator: (value) => value == null || value.trim().isEmpty ? 'Please enter your branch' : null,
              ),
              const SizedBox(height: 15.0),

              TextFormField(
                controller: _semesterController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Semester',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_month),
                ),
                validator: (value) => value == null || value.trim().isEmpty ? 'Please enter your semester' : null,
              ),
              const SizedBox(height: 15.0),

              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: (value) => value == null || value.trim().isEmpty ? 'Please enter your location' : null,
              ),
              const SizedBox(height: 20.0),

              Row(
                children: [
                  Checkbox(
                    value: _termsAgreed,
                    onChanged: (value) => setState(() => _termsAgreed = value!),
                  ),
                  const Expanded(
                    child: Text(
                      'I agree to the terms and conditions.',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),

              ElevatedButton(
                onPressed: _postGig,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.isDarkMode
                      ? theme.darkTheme.primaryColor
                      : theme.lightTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
                child: const Text('Post Gig', style: TextStyle(fontSize: 18.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}