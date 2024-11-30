import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import './frequency_selector.dart';

class AddReminderScreen extends StatefulWidget {
  final String email;

  AddReminderScreen({required this.email});

  @override
  _AddReminderScreenState createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final _medicamentoController = TextEditingController();
  final _horaController = TextEditingController();
  String? _selectedFrequency; // Para almacenar la frecuencia seleccionada

  Future<void> _addReminder() async {
    String medicamento = _medicamentoController.text;
    String hora = _horaController.text;
    String? frecuencia = _selectedFrequency;

    if (medicamento.isNotEmpty && hora.isNotEmpty && frecuencia != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? reminderData = prefs.getString('${widget.email}_reminders');

      List<Map<String, dynamic>> reminders = reminderData != null
          ? List<Map<String, dynamic>>.from(jsonDecode(reminderData) as List)
          : [];

      reminders.add({
        'medicamento': medicamento,
        'hora': hora,
        'frecuencia': frecuencia,
      });

      await prefs.setString('${widget.email}_reminders', jsonEncode(reminders));

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, llena todos los campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Recordatorio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _medicamentoController,
              decoration: const InputDecoration(labelText: 'Nombre del Medicamento'),
            ),
            const SizedBox(height: 16),
            FrequencySelector(
              onSelected: (selected) {
                setState(() {
                  _selectedFrequency = selected;
                });
              },
            ),
            if (_selectedFrequency != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Frecuencia seleccionada: $_selectedFrequency',
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
            const SizedBox(height: 16),
            TextField(
              controller: _horaController,
              readOnly: true,
              onTap: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (selectedTime != null) {
                  setState(() {
                    _horaController.text =
                        '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';
                  });
                }
              },
              decoration: const InputDecoration(labelText: 'Hora'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addReminder,
              child: const Text('Agregar Recordatorio'),
            ),
          ],
        ),
      ),
    );
  }
}
