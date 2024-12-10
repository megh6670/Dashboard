// backend_service.dart
import 'dart:async';

class AttendanceRecord {
  final DateTime time;
  final String type; // "check-in" or "check-out"

  AttendanceRecord(this.time, this.type);
}

class MockBackendService {
  // This simulates the backend storage
  List<AttendanceRecord> _records = [];

  // Simulate a network delay
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  // Check in
  Future<void> checkIn() async {
    await _simulateDelay();
    _records.add(AttendanceRecord(DateTime.now(), "check-in"));
  }

  // Check out
  Future<void> checkOut() async {
    await _simulateDelay();
    _records.add(AttendanceRecord(DateTime.now(), "check-out"));
  }

  // Get all attendance records
  Future<List<AttendanceRecord>> getMonthlyRecords(DateTime month) async {
    await _simulateDelay();
    // Filter records for the given month
    return _records.where((r) => r.time.month == month.month && r.time.year == month.year).toList();
  }

  // Check if user is currently checked in (simple logic: if last action is check-in)
  Future<bool> isCheckedIn() async {
    await _simulateDelay();
    if (_records.isEmpty) return false;
    return _records.last.type == "check-in";
  }
}
