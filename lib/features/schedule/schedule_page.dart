import 'package:flutter/material.dart';

import '../activities/activity_store.dart';
import 'schedule.dart';
import 'schedule_store.dart';

class SchedulePage extends StatefulWidget {
  final ScheduleStore scheduleStore;
  final ActivityStore activityStore;

  const SchedulePage({
    super.key,
    required this.scheduleStore,
    required this.activityStore,
  });

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String? _selectedActivityId;
  DateTime _selectedDateTime = DateTime.now();
  double _durationMinutes = 30;

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date == null || !mounted) {
      return;
    }

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
    );

    if (time == null) {
      return;
    }

    setState(() {
      _selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _createSchedule() {
    if (_selectedActivityId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an activity.')),
      );
      return;
    }

    final schedule = Schedule(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      activityId: _selectedActivityId!,
      startTime: _selectedDateTime,
      durationMinutes: _durationMinutes.round(),
    );

    widget.scheduleStore.addSchedule(schedule);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Schedule created successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activities = widget.activityStore.activities;

    if (activities.isEmpty) {
      return const Center(
        child: Text(
          'Create an activity before creating a schedule.',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Schedule',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),

          DropdownButtonFormField<String>(
            value: _selectedActivityId,
            decoration: const InputDecoration(
              labelText: 'Activity',
              border: OutlineInputBorder(),
            ),
            items: activities.map((activity) {
              return DropdownMenuItem<String>(
                value: activity.id,
                child: Text(activity.title),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedActivityId = value;
              });
            },
          ),

          const SizedBox(height: 24),

          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Date & Time'),
            subtitle: Text(
              '${_formatDate(_selectedDateTime)} • '
              '${_formatTime(_selectedDateTime)}',
            ),
            trailing: const Icon(Icons.calendar_month),
            onTap: _selectDateTime,
          ),

          const SizedBox(height: 16),

          Text(
            'Duration: ${_durationMinutes.round()} minutes',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          Slider(
            min: 15,
            max: 180,
            divisions: 11,
            value: _durationMinutes,
            label: '${_durationMinutes.round()} min',
            onChanged: (value) {
              setState(() {
                _durationMinutes = value;
              });
            },
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _createSchedule,
              icon: const Icon(Icons.add),
              label: const Text('Create Schedule'),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute;

    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour % 12 == 0 ? 12 : hour % 12;
    final displayMinute = minute.toString().padLeft(2, '0');

    return '$displayHour:$displayMinute $period';
  }
}
