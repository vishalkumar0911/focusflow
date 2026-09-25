import 'features/activities/activity_screen.dart';
import 'features/activities/activity_store.dart';
import 'features/schedule/schedule_screen.dart';
import 'features/schedule/schedule_store.dart';
import 'features/sessions/session_controller.dart';
import 'features/sessions/session_store.dart';
import 'features/schedule/schedule.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FocusFlowApp());
}

class FocusFlowApp extends StatelessWidget {
  const FocusFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FocusFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const FocusFlowHome(),
    );
  }
}

class FocusFlowHome extends StatefulWidget {
  const FocusFlowHome({super.key});

  @override
  State<FocusFlowHome> createState() => _FocusFlowHomeState();
}

class _FocusFlowHomeState extends State<FocusFlowHome> {
  int _selectedIndex = 0;

  final ActivityStore _activityStore = ActivityStore();
  final ScheduleStore _scheduleStore = ScheduleStore();
  final SessionStore _sessionStore = SessionStore();
  late final SessionController _sessionController;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _sessionController = SessionController(
      sessionStore: _sessionStore,
      scheduleStore: _scheduleStore,
    );

    _pages = [
      HomePage(
        activityStore: _activityStore,
        scheduleStore: _scheduleStore,
        sessionStore: _sessionStore,
      ),
      ScheduleScreen(
        scheduleStore: _scheduleStore,
        activityStore: _activityStore,
        sessionStore: _sessionStore,
        sessionController: _sessionController,
      ),
      ActivityScreen(activityStore: _activityStore),
      const ProgressPage(),
      const SettingsPage(),
    ];
  }

  void _onNavigationItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onNavigationItemSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Schedule',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: 'Activity',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final ActivityStore activityStore;
  final ScheduleStore scheduleStore;
  final SessionStore sessionStore;

  const HomePage({
    super.key,
    required this.activityStore,
    required this.scheduleStore,
    required this.sessionStore,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([activityStore, scheduleStore, sessionStore]),
      builder: (context, child) {
        final totalSessions = scheduleStore.schedules.length;

        final completedSessions = scheduleStore.schedules.where((schedule) {
          return schedule.status == ScheduleStatus.completed;
        }).length;

        final progress = totalSessions == 0
            ? 0.0
            : completedSessions / totalSessions;

        return Scaffold(
          appBar: AppBar(
            title: const Text('FocusFlow'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined),
                tooltip: 'Notifications',
              ),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getGreeting(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Here's your plan for today.",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 32),

                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Today's Progress",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '$completedSessions / $totalSessions sessions completed',
                            ),
                            const SizedBox(height: 12),
                            LinearProgressIndicator(value: progress),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      "Today's Schedule",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),

                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: scheduleStore.schedules.isEmpty
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.event_note_outlined,
                                        size: 48,
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        'No activities scheduled yet.',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'Add your first activity to start building your routine.',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Column(
                                children: scheduleStore.schedules.map((
                                  schedule,
                                ) {
                                  final activity = activityStore.activities
                                      .firstWhere(
                                        (activity) =>
                                            activity.id == schedule.activityId,
                                      );

                                  final time = TimeOfDay.fromDateTime(
                                    schedule.startTime,
                                  );

                                  return ListTile(
                                    leading: CircleAvatar(
                                      child: Text(
                                        '${schedule.durationMinutes}',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    title: Text(activity.title),
                                    subtitle: Text(
                                      '${time.format(context)} • '
                                      '${schedule.durationMinutes} min',
                                    ),
                                    trailing: Text(
                                      schedule.status.name,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                  );
                                }).toList(),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Good morning!';
    }

    if (hour >= 12 && hour < 17) {
      return 'Good afternoon!';
    }

    if (hour >= 17 && hour < 21) {
      return 'Good evening!';
    }

    return 'Good night!';
  }
}

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderPage(
      title: 'Schedule',
      icon: Icons.calendar_month_outlined,
      message: 'Your daily and weekly schedule will appear here.',
    );
  }
}

class AddActivityPage extends StatelessWidget {
  const AddActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderPage(
      title: 'Add Activity',
      icon: Icons.add_task,
      message: 'You will be able to create and manage activities here.',
    );
  }
}

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderPage(
      title: 'Progress',
      icon: Icons.bar_chart_outlined,
      message: 'Your study progress and analytics will appear here.',
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderPage(
      title: 'Settings',
      icon: Icons.settings_outlined,
      message: 'FocusFlow settings will appear here.',
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({
    super.key,
    required this.title,
    required this.icon,
    required this.message,
  });

  final String title;
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 64),
              const SizedBox(height: 20),
              Text(title, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 12),
              Text(message, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
