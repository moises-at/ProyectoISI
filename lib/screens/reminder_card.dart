import 'package:flutter/material.dart';

class ReminderCard extends StatelessWidget {
  final String medicamento;
  final String hora;

  const ReminderCard({required this.medicamento, required this.hora, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              medicamento,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Hora: $hora',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
