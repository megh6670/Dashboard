// monthly_stats_page.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MonthlyStatsPage extends StatelessWidget {
  // Mock data
  final double totalHours = 42.5;
  final double dailyAverage = 8.5;
  final double overtime = 4.0;

  final List<double> weeklyHours = [8.0, 6.5, 9.0, 8.5, 7.0, 5.0, 0.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Monthly Stats")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "My Working Hours",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryCard("My Total Hours", totalHours.toStringAsFixed(1)),
                _buildSummaryCard("My Daily Average", dailyAverage.toStringAsFixed(1)),
                _buildSummaryCard("My Overtime", overtime.toStringAsFixed(1)),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              "This Month",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(showTitles: true),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (value) {
                        const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
                        return days[value.toInt()];
                      },
                    ),
                  ),
                  barGroups: weeklyHours.asMap().entries.map((entry) {
                    final index = entry.key;
                    final hours = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [BarChartRodData(y: hours, width: 16)],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
