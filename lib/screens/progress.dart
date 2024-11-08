import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample saved data (Replace this with your saved data list)
    final savedProgress = [
      {
        'type': 'BMI',
        'value': '24.22',
        'category': 'Normal weight',
        'dateTime': DateTime(2024, 11, 1, 10, 30),
      },
      {
        'type': 'BMI',
        'value': '28.5',
        'category': 'Overweight',
        'dateTime': DateTime(2024, 11, 5, 11, 0),
      },
      {
        'type': 'Calories',
        'protein': '20',
        'carbs': '50',
        'fats': '30',
        'totalCalories': '500',
        'dateTime': DateTime(2024, 11, 7, 14, 20),
      },
      {
        'type': 'Calories',
        'protein': '25',
        'carbs': '60',
        'fats': '35',
        'totalCalories': '600',
        'dateTime': DateTime(2024, 11, 10, 9, 45),
      },
    ];

    // Group data by week
    Map<int, List<Map<String, dynamic>>> groupedByWeek = {};

    for (var entry in savedProgress) {
      final dateTime = entry['dateTime'] as DateTime;
      final weekOfYear = _getWeekOfYear(dateTime);

      if (!groupedByWeek.containsKey(weekOfYear)) {
        groupedByWeek[weekOfYear] = [];
      }
      groupedByWeek[weekOfYear]!.add(entry);
    }

    // Build UI for each week
    return Scaffold(
      appBar: AppBar(title: const Text("Progress")),
      body: ListView.builder(
        itemCount: groupedByWeek.length,
        itemBuilder: (context, index) {
          final week = groupedByWeek.keys.elementAt(index);
          final weekData = groupedByWeek[week];

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Week $week',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...weekData!.map((entry) {
                    final dateTime = entry['dateTime'] as DateTime;
                    String displayText = '';
                    if (entry['type'] == 'BMI') {
                      displayText = 'BMI: ${entry['value']} (${entry['category']})';
                    } else if (entry['type'] == 'Calories') {
                      displayText = 'Calories: ${entry['totalCalories']} kcal (Protein: ${entry['protein']}g, Carbs: ${entry['carbs']}g, Fats: ${entry['fats']}g)';
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        '$displayText - ${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Function to get the week number for a given DateTime
  int _getWeekOfYear(DateTime date) {
    // This function calculates the week number of the year using the given date
    final startOfYear = DateTime(date.year, 1, 1);
    final daysDifference = date.difference(startOfYear).inDays;
    final weekNumber = ((daysDifference / 7).floor()) + 1;
    return weekNumber;
  }
}
