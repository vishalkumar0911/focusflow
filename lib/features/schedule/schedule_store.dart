import 'package:flutter/foundation.dart';

import 'schedule.dart';

class ScheduleStore extends ChangeNotifier {
  final List<Schedule> _schedules = [];

  List<Schedule> get schedules => List.unmodifiable(_schedules);

  void addSchedule(Schedule schedule) {
    _schedules.add(schedule);
    notifyListeners();
  }

  void removeSchedule(String id) {
    _schedules.removeWhere((schedule) => schedule.id == id);
    notifyListeners();
  }

  void updateSchedule(Schedule updatedSchedule) {
    final index = _schedules.indexWhere(
      (schedule) => schedule.id == updatedSchedule.id,
    );

    if (index == -1) {
      return;
    }

    _schedules[index] = updatedSchedule;
    notifyListeners();
  }
}
