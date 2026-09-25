import 'package:flutter_test/flutter_test.dart';

import 'package:focusflow/features/activities/activity.dart';
import 'package:focusflow/features/activities/activity_store.dart';
import 'package:focusflow/features/schedule/schedule.dart';
import 'package:focusflow/features/schedule/schedule_store.dart';
import 'package:focusflow/features/sessions/session_controller.dart';
import 'package:focusflow/features/sessions/session_store.dart';
import 'package:focusflow/features/sessions/study_session.dart';

void main() {
  late ActivityStore activityStore;
  late ScheduleStore scheduleStore;
  late SessionStore sessionStore;
  late SessionController controller;

  late Schedule schedule;

  setUp(() {
    activityStore = ActivityStore();
    scheduleStore = ScheduleStore();
    sessionStore = SessionStore();

    controller = SessionController(
      sessionStore: sessionStore,
      scheduleStore: scheduleStore,
    );

    final activity = Activity(
      id: 'activity-1',
      title: 'Learn Python',
      durationMinutes: 30,
    );

    activityStore.addActivity(activity);

    schedule = Schedule(
      id: 'schedule-1',
      activityId: activity.id,
      startTime: DateTime(2026, 9, 24, 22, 0),
      durationMinutes: 30,
    );

    scheduleStore.addSchedule(schedule);
  });

  test('starting a session updates both session and schedule', () {
    controller.startSession(schedule.id);

    expect(sessionStore.sessions, hasLength(1));
    expect(sessionStore.sessions.first.status, SessionStatus.inProgress);

    expect(scheduleStore.schedules.first.status, ScheduleStatus.inProgress);
  });

  test('completing a session updates both session and schedule', () {
    controller.startSession(schedule.id);

    controller.completeSession(schedule.id);

    expect(sessionStore.sessions.first.status, SessionStatus.completed);

    expect(scheduleStore.schedules.first.status, ScheduleStatus.completed);
  });

  test('skipping a session updates both session and schedule', () {
    controller.skipSession(schedule.id);

    expect(sessionStore.sessions.first.status, SessionStatus.skipped);

    expect(scheduleStore.schedules.first.status, ScheduleStatus.skipped);
  });

  test(
    'starting the same schedule twice does not create duplicate sessions',
    () {
      controller.startSession(schedule.id);
      controller.startSession(schedule.id);

      expect(sessionStore.sessions, hasLength(1));
    },
  );
}
