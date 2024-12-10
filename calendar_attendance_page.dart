// calendar_attendance_page.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarAttendancePage extends StatefulWidget {
  @override
  _CalendarAttendancePageState createState() => _CalendarAttendancePageState();
}

class _CalendarAttendancePageState extends State<CalendarAttendancePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Mock data
  final Map<DateTime, Map<String, String>> _attendanceData = {
    DateTime(2024, 12, 20): {"checkIn": "9:30", "checkOut": "18:00"},
    DateTime(2024, 12, 19): {"checkIn": "10:00", "checkOut": "17:30"},
  };

  @override
  Widget build(BuildContext context) {
    final selectedAttendance = _attendanceData[_selectedDay ?? _focusedDay];

    return Scaffold(
      appBar: AppBar(title: const Text("Attendance")),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 1, 1),
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
          ),
          const SizedBox(height: 16),
          if (selectedAttendance != null)
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('dd/MM/yyyy').format(_selectedDay ?? _focusedDay),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Check In:", style: const TextStyle(fontSize: 16)),
                        Text(selectedAttendance["checkIn"] ?? "-", style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Check Out:", style: const TextStyle(fontSize: 16)),
                        Text(selectedAttendance["checkOut"] ?? "-", style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          if (selectedAttendance == null)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("No attendance record for this day."),
            ),
        ],
      ),
    );
  }
}
