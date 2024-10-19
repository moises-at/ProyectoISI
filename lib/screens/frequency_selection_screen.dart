import 'package:flutter/material.dart';

class FrequencySelectionScreen extends StatefulWidget {
  @override
  _FrequencySelectionScreenState createState() => _FrequencySelectionScreenState();
}

class _FrequencySelectionScreenState extends State<FrequencySelectionScreen> {
  String selectedFrequency = '';

  void _selectFrequency(String frequency) {
    setState(() {
      selectedFrequency = frequency;
      Navigator.pop(context, frequency); // Devolver la frecuencia seleccionada
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar Frecuencia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Frecuencia',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                _buildFrequencyButton('cada dia', selectedFrequency == 'cada dia' ? Colors.orange : Colors.grey),
                _buildFrequencyButton('dia por medio', selectedFrequency == 'dia por medio' ? Colors.orange : Colors.grey),
                _buildFrequencyButton('especificar dia de la semana', selectedFrequency == 'especificar dia de la semana' ? Colors.orange : Colors.grey),
                _buildFrequencyButton('cada x dia', selectedFrequency == 'cada x dia' ? Colors.orange : Colors.grey),
                _buildFrequencyButton('cada x semana', selectedFrequency == 'cada x semana' ? Colors.orange : Colors.grey),
                _buildFrequencyButton('cada x meses', selectedFrequency == 'cada x meses' ? Colors.orange : Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFrequencyButton(String text, Color color) {
    return ElevatedButton(
      onPressed: () => _selectFrequency(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
