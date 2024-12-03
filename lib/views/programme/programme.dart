import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Programme extends StatefulWidget {
  const Programme({super.key});

  @override
  State<Programme> createState() => _ProgrammeState();
}

class _ProgrammeState extends State<Programme> {
  DateTime _focusedDate = DateTime.now();
  DateTime? _selectedDate;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  late ScrollController _scrollController;

  // Sample events (replace with Firebase in future)
  final Map<DateTime, List<Widget>> _events = {
    DateTime(2024, 11, 25): [
      _buildEventCard(
        icon: Icons.event,
        color: Colors.blue,
        title: 'Flutter Workshop',
        time: '08:00 AM - 10:00 AM',
      ),
      _buildEventCard(
        icon: Icons.group,
        color: Colors.green,
        title: 'Team Meeting',
        time: '10:30 AM - 12:00 PM',
      ),
    ],
    DateTime(2024, 11, 27): [
      _buildEventCard(
        icon: Icons.event,
        color: Colors.blue,
        title: 'Flutter Workshop',
        time: '08:00 AM - 10:00 AM',
      ),
      _buildEventCard(
        icon: Icons.group,
        color: Colors.green,
        title: 'Team Meeting',
        time: '10:30 AM - 12:00 PM',
      ),
    ],
    DateTime(2024, 12, 01): [
      _buildEventCard(
        icon: Icons.event,
        color: Colors.blue,
        title: 'Flutter Workshop',
        time: '08:00 AM - 10:00 AM',
      ),
      _buildEventCard(
        icon: Icons.group,
        color: Colors.green,
        title: 'Team Meeting',
        time: '10:30 AM - 12:00 PM',
      ),
    ],
  };

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _selectedDate = _focusedDate;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Helper to build event cards
  static Widget _buildEventCard({
    required IconData icon,
    required Color color,
    required String title,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Get events for a specific date
  List<Widget> _getEventsForDate(DateTime date) {
    return _events[date] ?? [];
  }

  // Scroll to specific event date
  void _scrollToEvent(DateTime date) {
    final eventIndex =
        _events.keys.toList().indexWhere((d) => isSameDay(d, date));
    if (eventIndex != -1) {
      _scrollController.animateTo(
        eventIndex * 120.0, // Approximate height of each event card
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Programme')),
      body: Column(
        children: [
          // Calendar Header
          TableCalendar(
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: _focusedDate,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
                _focusedDate = focusedDay;
              });
              _scrollToEvent(selectedDay);
            },
            eventLoader: _getEventsForDate,
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Event List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _events.keys.length,
              itemBuilder: (context, index) {
                final eventDate = _events.keys.elementAt(index);
                final events = _events[eventDate]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date Header
                    Container(
                      color: isSameDay(eventDate, _selectedDate)
                          ? Colors.purple.shade50
                          : null,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Text(
                        '${eventDate.day}/${eventDate.month}/${eventDate.year}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSameDay(eventDate, _selectedDate)
                              ? Colors.purple
                              : Colors.black,
                        ),
                      ),
                    ),

                    // Events for this date
                    ...events,
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
