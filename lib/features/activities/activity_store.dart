import 'activity.dart';

class ActivityStore {
  final List<Activity> _activities = [];

  List<Activity> get activities => List.unmodifiable(_activities);

  void addActivity(Activity activity) {
    _activities.add(activity);
  }

  void removeActivity(String id) {
    _activities.removeWhere((activity) => activity.id == id);
  }
}
