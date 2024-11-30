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

          //  child: Text('Registrarse', style: TextStyle(fontSize: 18, color: Colors.white)),
        title: const Text('Agregar Recordatorio', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: _medicamentoController,
                label: 'Nombre del Medicamento',
                icon: Icons.medical_services,
              ),
              const SizedBox(height: 16),

              // Selector de frecuencia
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      FrequencySelector(
                        onSelected: (selected) {
                          setState(() {
                            _selectedFrequency = selected;
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // Mostrar la frecuencia seleccionada
                      if (_selectedFrequency != null)
                        Text(
                          '$_selectedFrequency',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        )
                      else
                        const Text(
                          'Seleccionar Frecuencia',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Campo de hora con selector
              _buildTimeField(context),

              const SizedBox(height: 32),

              // Botón para agregar recordatorio
              Center(
                child: ElevatedButton(
                  onPressed: _addReminder,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.pink,
                  ),
                  child: const Text('Agregar Recordatorio', style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Función para construir los campos de texto reutilizables
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon,),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  // Campo de texto para la hora con el selector de hora
  Widget _buildTimeField(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
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
          decoration: const InputDecoration(
            labelText: 'Hora',
            prefixIcon: Icon(Icons.access_time),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
