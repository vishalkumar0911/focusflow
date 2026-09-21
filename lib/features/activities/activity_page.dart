import 'package:flutter/material.dart';

import 'activity.dart';
import 'activity_store.dart';

class ActivityPage extends StatefulWidget {
  final ActivityStore activityStore;

  const ActivityPage({super.key, required this.activityStore});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();

  int _durationMinutes = 30;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _saveActivity() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final activity = Activity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _categoryController.text.trim().isEmpty
          ? 'General'
          : _categoryController.text.trim(),
      durationMinutes: _durationMinutes,
    );

    widget.activityStore.addActivity(activity);

    _titleController.clear();
    _descriptionController.clear();
    _categoryController.clear();

    setState(() {
      _durationMinutes = 30;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Activity created successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create a new activity',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Add something you want to study, practice, or complete.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Activity title',
                    hintText: 'e.g. Learn Python',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.task_alt),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter an activity title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'What do you want to accomplish?',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description_outlined),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _categoryController,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    hintText: 'e.g. Programming',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Duration',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: _durationMinutes.toDouble(),
                        min: 15,
                        max: 180,
                        divisions: 11,
                        label: '$_durationMinutes min',
                        onChanged: (value) {
                          setState(() {
                            _durationMinutes = value.round();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: Text(
                        '$_durationMinutes min',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: _saveActivity,
                  icon: const Icon(Icons.save),
                  label: const Text('Save Activity'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
