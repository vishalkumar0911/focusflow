enum SessionStatus { inProgress, completed, skipped, missed }

class StudySession {
  final String id;
  final String scheduleId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final SessionStatus status;

  const StudySession({
    required this.id,
    required this.scheduleId,
    required this.startedAt,
    this.endedAt,
    this.status = SessionStatus.inProgress,
  });

  Duration get actualDuration {
    if (endedAt == null) {
      return Duration.zero;
    }

    return endedAt!.difference(startedAt);
  }
}
