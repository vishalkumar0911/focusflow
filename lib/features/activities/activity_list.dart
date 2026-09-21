import 'package:flutter/material.dart';

import 'activity_store.dart';

class ActivityList extends StatelessWidget {
  final ActivityStore activityStore;

  const ActivityList({super.key, required this.activityStore});

  @override
  Widget build(BuildContext context) {
    final activities = activityStore.activities;

    if (activities.isEmpty) {
      return const Center(
        child: Text(
          'No activities created yet.',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: activities.length,
      separatorBuilder: (_, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final activity = activities[index];

        return Card(
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.task_alt)),
            title: Text(activity.title),
            subtitle: Text(
              '${activity.category} • ${activity.durationMinutes} min',
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        );
      },
    );
  }
}
