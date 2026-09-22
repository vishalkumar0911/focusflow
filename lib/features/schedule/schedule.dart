enum ScheduleStatus { planned, inProgress, completed, skipped, missed }

class Schedule {
  final String id;
  final String activityId;
  final DateTime startTime;
  final int durationMinutes;
  final ScheduleStatus status;

  const Schedule({
    required this.id,
    required this.activityId,
    required this.startTime,
    required this.durationMinutes,
    this.status = ScheduleStatus.planned,
  });

  DateTime get endTime {
    return startTime.add(Duration(minutes: durationMinutes));
  }
}
