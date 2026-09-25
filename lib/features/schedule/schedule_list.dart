import 'package:flutter/material.dart';

import '../activities/activity_store.dart';
import '../sessions/session_controller.dart';
import '../sessions/session_store.dart';
import '../sessions/study_session.dart';
import 'schedule_store.dart';

class ScheduleList extends StatelessWidget {
  final ScheduleStore scheduleStore;
  final ActivityStore activityStore;
  final SessionStore sessionStore;
  final SessionController sessionController;

  const ScheduleList({
    super.key,
    required this.scheduleStore,
    required this.activityStore,
    required this.sessionStore,
    required this.sessionController,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([scheduleStore, sessionStore]),
      builder: (context, child) {
        final schedules = scheduleStore.schedules;

        if (schedules.isEmpty) {
          return const Center(
            child: Text(
              'No schedules created yet.',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: schedules.length,
          separatorBuilder: (_, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final schedule = schedules[index];

            final activity = activityStore.activities
                .where((activity) => activity.id == schedule.activityId)
                .firstOrNull;

            final activityTitle = activity?.title ?? 'Unknown Activity';

            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                    '${schedule.durationMinutes}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                title: Text(activityTitle),
                subtitle: Text(
                  '${_formatTime(schedule.startTime)} • '
                  '${schedule.durationMinutes} min',
                ),
                trailing: _buildSessionActions(context, schedule.id),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSessionActions(BuildContext context, String scheduleId) {
    final session = sessionStore.sessions
        .where((session) => session.scheduleId == scheduleId)
        .firstOrNull;

    if (session == null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              sessionController.startSession(scheduleId);
            },
            child: const Text('Start'),
          ),
          TextButton(
            onPressed: () {
              sessionController.skipSession(scheduleId);
            },
            child: const Text('Skip'),
          ),
        ],
      );
    }

    switch (session.status) {
      case SessionStatus.inProgress:
        return TextButton(
          onPressed: () {
            sessionController.completeSession(scheduleId);
          },
          child: const Text('Complete'),
        );

      case SessionStatus.completed:
        return const Text('Completed');

      case SessionStatus.skipped:
        return const Text('Skipped');

      case SessionStatus.missed:
        return const Text('Missed');
    }
  }

  String _formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute;

    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour % 12 == 0 ? 12 : hour % 12;
    final displayMinute = minute.toString().padLeft(2, '0');

    return '$displayHour:$displayMinute $period';
  }
}
