import 'package:flutter/foundation.dart';

import 'activity.dart';

class ActivityStore extends ChangeNotifier {
  final List<Activity> _activities = [];

  List<Activity> get activities => List.unmodifiable(_activities);

  void addActivity(Activity activity) {
    _activities.add(activity);
    notifyListeners();
  }

  void removeActivity(String id) {
    _activities.removeWhere((activity) => activity.id == id);
    notifyListeners();
  }

  void updateActivity(Activity updatedActivity) {
    final index = _activities.indexWhere(
      (activity) => activity.id == updatedActivity.id,
    );

    if (index == -1) {
      return;
    }

    _activities[index] = updatedActivity;
    notifyListeners();
  }
}
