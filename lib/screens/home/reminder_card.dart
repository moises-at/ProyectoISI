import 'package:flutter/material.dart';

class ReminderCard extends StatelessWidget {
  final String medicamento;
  final String hora;
  final VoidCallback onCompleted; // Callback para manejar el check

  const ReminderCard({
    required this.medicamento,
    required this.hora,
    required this.onCompleted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medicamento,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Hora: $hora',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.check_circle, color: Colors.white),
              onPressed: onCompleted, // Llama al callback al pulsar el botón
            ),
          ],
        ),
      ),
    );
  }
}
