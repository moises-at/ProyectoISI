import 'package:flutter/material.dart';

class SpecificDaysSelector extends StatelessWidget {
  final Function(String) onSelected;

  const SpecificDaysSelector({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> daysOfWeek = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
    List<String> selectedDays = [];

    return AlertDialog(
      title: const Text('Selecciona los días'),
      content: SingleChildScrollView(
        child: Column(
          children: daysOfWeek.map((day) {
            return CheckboxListTile(
              title: Text(day),
              value: selectedDays.contains(day),
              onChanged: (bool? value) {
                if (value == true) {
                  selectedDays.add(day);
                } else {
                  selectedDays.remove(day);
                }
                (context as Element).markNeedsBuild(); // Actualiza el estado del diálogo
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text('Aceptar'),
          onPressed: () {
            Navigator.pop(context);
            onSelected('Días específicos: ${selectedDays.join(', ')}');
          },
        ),
      ],
    );
  }
}
