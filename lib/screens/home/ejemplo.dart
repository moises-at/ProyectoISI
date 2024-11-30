import 'package:flutter/material.dart';
import 'reminder_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Lista de recordatorios
  List<Map<String, String>> reminders = [
    {'medicamento': 'Paracetamol', 'hora': '8:00 AM'},
    {'medicamento': 'Ibuprofeno', 'hora': '12:00 PM'},
    {'medicamento': 'Vitamina C', 'hora': '6:00 PM'},
  ];

  // Método para eliminar un recordatorio
  void _removeReminder(int index) {
    setState(() {
      reminders.removeAt(index); // Remueve el recordatorio de la lista
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recordatorios'),
        backgroundColor: Colors.teal,
      ),
      body: reminders.isEmpty
          ? const Center(
              child: Text(
                'No hay recordatorios',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final reminder = reminders[index];
                return ReminderCard(
                  medicamento: reminder['medicamento']!,
                  hora: reminder['hora']!,
                  onCompleted: () => _removeReminder(index), // Maneja el evento
                );
              },
            ),
    );
  }
}
