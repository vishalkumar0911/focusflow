import 'package:flutter/material.dart';

import '../activities/activity_store.dart';
import '../sessions/session_controller.dart';
import '../sessions/session_store.dart';
import 'schedule_list.dart';
import 'schedule_page.dart';
import 'schedule_store.dart';

class ScheduleScreen extends StatelessWidget {
  final ScheduleStore scheduleStore;
  final ActivityStore activityStore;
  final SessionStore sessionStore;
  final SessionController sessionController;

  const ScheduleScreen({
    super.key,
    required this.scheduleStore,
    required this.activityStore,
    required this.sessionStore,
    required this.sessionController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: SchedulePage(
            scheduleStore: scheduleStore,
            activityStore: activityStore,
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'My Schedule',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ScheduleList(
            scheduleStore: scheduleStore,
            activityStore: activityStore,
            sessionStore: sessionStore,
            sessionController: sessionController,
          ),
        ),
      ],
    );
  }
}
