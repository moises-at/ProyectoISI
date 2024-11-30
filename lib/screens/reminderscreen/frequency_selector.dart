import 'package:flutter/material.dart';
import 'interval_days_input.dart'; // Importa la clase IntervalDaysInput
import 'specific_days_selector.dart'; // Importa la clase SpecificDaysSelector

class FrequencySelector extends StatelessWidget {
  final Function(String) onSelected;

  const FrequencySelector({
    super.key,
    required this.onSelected,
  });

  void _showFrequencyOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: const Text('Cada dia'),
              onTap: () {
                onSelected('Cada dia');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Dias Especificos'),
              onTap: () {
                Navigator.pop(context); // Cierra el BottomSheet
                _showSpecificDaysSelector(context); // Abre el selector de días específicos
              },
            ),
            ListTile(
              title: const Text('Intervalo de dias'),
              onTap: () {
                Navigator.pop(context); // Cierra el BottomSheet
                _showIntervalInput(context); // Abre el cuadro de texto para el intervalo de días
              },
            ),
          ],
        );
      },
    );
  }

  void _showSpecificDaysSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SpecificDaysSelector(
          onSelected: (String frequency) {
            onSelected(frequency);
          },
        );
      },
    );
  }

  void _showIntervalInput(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return IntervalDaysInput(
          onSelected: (String frequency) {
            onSelected(frequency);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showFrequencyOptions(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.teal[50],
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.teal),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Seleccionar Frecuencia',
              style: TextStyle(
                fontSize: 16,
                color: Colors.teal,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.teal),
          ],
        ),
      ),
    );
  }
}
