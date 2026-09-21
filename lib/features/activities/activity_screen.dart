import 'package:flutter/material.dart';

import 'activity_list.dart';
import 'activity_page.dart';
import 'activity_store.dart';

class ActivityScreen extends StatelessWidget {
  final ActivityStore activityStore;

  const ActivityScreen({super.key, required this.activityStore});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Add Activity',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        Expanded(flex: 3, child: ActivityPage(activityStore: activityStore)),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'My Activities',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        Expanded(flex: 2, child: ActivityList(activityStore: activityStore)),
      ],
    );
  }
}
