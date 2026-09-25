import 'package:flutter/foundation.dart';

import 'study_session.dart';

class SessionStore extends ChangeNotifier {
  final List<StudySession> _sessions = [];

  List<StudySession> get sessions => List.unmodifiable(_sessions);

  void startSession({required String scheduleId}) {
    final existingSession = _sessions
        .where((session) => session.scheduleId == scheduleId)
        .firstOrNull;

    if (existingSession != null) {
      return;
    }

    final session = StudySession(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      scheduleId: scheduleId,
      startedAt: DateTime.now(),
    );

    _sessions.add(session);
    notifyListeners();
  }

  void completeSession(String sessionId) {
    final index = _sessions.indexWhere((session) => session.id == sessionId);

    if (index == -1) {
      return;
    }

    final session = _sessions[index];

    _sessions[index] = StudySession(
      id: session.id,
      scheduleId: session.scheduleId,
      startedAt: session.startedAt,
      endedAt: DateTime.now(),
      status: SessionStatus.completed,
    );

    notifyListeners();
  }

  void skipSession(String scheduleId) {
    final existingSession = _sessions
        .where((session) => session.scheduleId == scheduleId)
        .firstOrNull;

    if (existingSession != null) {
      return;
    }

    final session = StudySession(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      scheduleId: scheduleId,
      startedAt: DateTime.now(),
      endedAt: DateTime.now(),
      status: SessionStatus.skipped,
    );

    _sessions.add(session);
    notifyListeners();
  }
}
