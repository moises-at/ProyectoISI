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
  DateTime? _selectedDateTime;

  Future<void> _addReminder() async {
    String medicamento = _medicamentoController.text;
    String? hora = _selectedDateTime != null
        ? "${_selectedDateTime!.hour.toString().padLeft(2, '0')}:${_selectedDateTime!.minute.toString().padLeft(2, '0')} del ${_selectedDateTime!.day}/${_selectedDateTime!.month}/${_selectedDateTime!.year}"
        : null;

    if (medicamento.isNotEmpty && hora != null) {
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

  Future<void> _selectDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
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
            SizedBox(height: 20),
            InkWell(
              onTap: _selectDateTime,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Fecha y Hora',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  _selectedDateTime != null
                      ? "${_selectedDateTime!.hour.toString().padLeft(2, '0')}:${_selectedDateTime!.minute.toString().padLeft(2, '0')} del ${_selectedDateTime!.day}/${_selectedDateTime!.month}/${_selectedDateTime!.year}"
                      : "Seleccionar fecha y hora",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
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
