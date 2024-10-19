import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AddReminderScreen extends StatefulWidget {
  final String email;

  AddReminderScreen({required this.email});

  @override
  _AddReminderScreenState createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final _medicamentoController = TextEditingController();
  final _horaController = TextEditingController();

  Future<void> _addReminder() async {
  String medicamento = _medicamentoController.text;
  String hora = _horaController.text;

  if (medicamento.isNotEmpty && hora.isNotEmpty) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? reminderData = prefs.getString('${widget.email}_reminders');

    List<Map<String, dynamic>> reminders = reminderData != null
        ? List<Map<String, dynamic>>.from(jsonDecode(reminderData) as List)
        : [];

    reminders.add({'medicamento': medicamento, 'hora': hora});

    await prefs.setString('${widget.email}_reminders', jsonEncode(reminders));

    Navigator.pop(context);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Por favor, llena todos los campos')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Recordatorio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _medicamentoController,
              decoration: InputDecoration(labelText: 'Nombre del Medicamento'),
            ),
            TextField(
              controller: _horaController,
              decoration: InputDecoration(labelText: 'Hora (HH:MM)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addReminder,
              child: Text('Agregar Recordatorio'),
            ),
          ],
        ),
      ),
    );
  }
}
