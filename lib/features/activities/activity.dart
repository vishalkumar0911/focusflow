class Activity {
  final String id;
  final String title;
  final String description;
  final String category;
  final int durationMinutes;
  final bool isActive;

  const Activity({
    required this.id,
    required this.title,
    this.description = '',
    this.category = 'General',
    required this.durationMinutes,
    this.isActive = true,
  });
}
