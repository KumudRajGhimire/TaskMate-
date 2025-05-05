// post_gig_screen_part1.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'post_gig_screen_part2.dart'; // Import the second part screen

class PostGigScreenPart1 extends StatefulWidget {
  const PostGigScreenPart1({super.key});

  @override
  State<PostGigScreenPart1> createState() => _PostGigScreenPart1State();
}

class _PostGigScreenPart1State extends State<PostGigScreenPart1> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedCategory;
  final _otherCategoryController = TextEditingController();
  final _offeredSkillController = TextEditingController();
  DateTime? _deadline;

  final List<String> _categories = ['Web Development', 'Graphic Design', 'Tutoring', 'Writing', 'Other'];

  Future<void> _selectDeadline(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _deadline) {
      setState(() {
        _deadline = picked;
      });
    }
  }

  void _navigateToPart2() {
    if (_formKey.currentState!.validate()) {
      final gigDataPart1 = {
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'category': _selectedCategory == 'Other' && _otherCategoryController.text.isNotEmpty
            ? _otherCategoryController.text.trim()
            : _selectedCategory!,
        'offeredSkill': _offeredSkillController.text.trim(),
        'deadline': _deadline?.toIso8601String(),
      };

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PostGigScreenPart2(gigDataPart1: gigDataPart1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post a Gig (1/2)', style: TextStyle(color: Colors.white)),
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
              // Step Indicator (Basic Text for now)
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Step 1', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Step 2', style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 20.0),

              // Gig Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Gig Title',
                  hintText: 'Enter a brief and descriptive title',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) => value == null || value.trim().isEmpty ? 'Please enter the gig title' : null,
              ),
              const SizedBox(height: 15.0),

              // Description
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Provide a detailed description of the gig',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                validator: (value) => value == null || value.trim().isEmpty ? 'Please enter the gig description' : null,
              ),
              const SizedBox(height: 15.0),

              // Category
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Category',
                  hintText: 'Select the category that best fits your gig',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                value: _selectedCategory,
                items: _categories.map((category) => DropdownMenuItem(value: category, child: Text(category))).toList(),
                onChanged: (value) => setState(() => _selectedCategory = value),
                validator: (value) => value == null ? 'Please select a category' : null,
              ),
              if (_selectedCategory == 'Other')
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: TextFormField(
                    controller: _otherCategoryController,
                    decoration: const InputDecoration(
                      labelText: 'Specify Other Category',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.more_horiz),
                    ),
                  ),
                ),
              const SizedBox(height: 15.0),

              // Skill You Can Offer
              TextFormField(
                controller: _offeredSkillController,
                decoration: const InputDecoration(
                  labelText: 'Skill You Can Offer in Return',
                  hintText: 'What skill can you offer in exchange?',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.handshake),
                ),
              ),
              const SizedBox(height: 15.0),

              // Deadline
              InkWell(
                onTap: () => _selectDeadline(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Deadline',
                    hintText: 'Select the deadline for the gig',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_deadline == null ? 'Select Deadline' : "${_deadline!.day}-${_deadline!.month}-${_deadline!.year}"),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30.0),

              // Next Button
              ElevatedButton(
                onPressed: _navigateToPart2,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.isDarkMode
                      ? theme.darkTheme.primaryColor
                      : theme.lightTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
                child: const Text('Next', style: TextStyle(fontSize: 18.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}