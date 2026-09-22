import 'package:flutter/material.dart';

import '../activities/activity_store.dart';
import 'schedule_store.dart';

class ScheduleList extends StatelessWidget {
  final ScheduleStore scheduleStore;
  final ActivityStore activityStore;

  const ScheduleList({
    super.key,
    required this.scheduleStore,
    required this.activityStore,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: scheduleStore,
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
                trailing: Text(
                  schedule.status.name,
                  style: TextStyle(
                    color: _statusColor(schedule.status.name),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute;

    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour % 12 == 0 ? 12 : hour % 12;
    final displayMinute = minute.toString().padLeft(2, '0');

    return '$displayHour:$displayMinute $period';
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'skipped':
        return Colors.orange;
      case 'missed':
        return Colors.red;
      case 'inProgress':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
