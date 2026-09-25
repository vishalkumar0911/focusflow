import 'session_store.dart';
import 'study_session.dart';
import '../schedule/schedule.dart';
import '../schedule/schedule_store.dart';

class SessionController {
  final SessionStore sessionStore;
  final ScheduleStore scheduleStore;

  const SessionController({
    required this.sessionStore,
    required this.scheduleStore,
  });

  void startSession(String scheduleId) {
    final schedule = _findSchedule(scheduleId);

    if (schedule == null) {
      return;
    }

    final existingSession = _findSession(scheduleId);

    if (existingSession != null) {
      return;
    }

    sessionStore.startSession(scheduleId: scheduleId);

    scheduleStore.updateSchedule(
      Schedule(
        id: schedule.id,
        activityId: schedule.activityId,
        startTime: schedule.startTime,
        durationMinutes: schedule.durationMinutes,
        status: ScheduleStatus.inProgress,
      ),
    );
  }

  void completeSession(String scheduleId) {
    final schedule = _findSchedule(scheduleId);
    final session = _findSession(scheduleId);

    if (schedule == null || session == null) {
      return;
    }

    if (session.status != SessionStatus.inProgress) {
      return;
    }

    sessionStore.completeSession(session.id);

    scheduleStore.updateSchedule(
      Schedule(
        id: schedule.id,
        activityId: schedule.activityId,
        startTime: schedule.startTime,
        durationMinutes: schedule.durationMinutes,
        status: ScheduleStatus.completed,
      ),
    );
  }

  void skipSession(String scheduleId) {
    final schedule = _findSchedule(scheduleId);

    if (schedule == null) {
      return;
    }

    final existingSession = _findSession(scheduleId);

    if (existingSession != null) {
      return;
    }

    sessionStore.skipSession(scheduleId);

    scheduleStore.updateSchedule(
      Schedule(
        id: schedule.id,
        activityId: schedule.activityId,
        startTime: schedule.startTime,
        durationMinutes: schedule.durationMinutes,
        status: ScheduleStatus.skipped,
      ),
    );
  }

  Schedule? _findSchedule(String scheduleId) {
    return scheduleStore.schedules
        .where((schedule) => schedule.id == scheduleId)
        .firstOrNull;
  }

  StudySession? _findSession(String scheduleId) {
    return sessionStore.sessions
        .where((session) => session.scheduleId == scheduleId)
        .firstOrNull;
  }
}
