import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntervalDaysInput extends StatelessWidget {
  final Function(String) onSelected;

  const IntervalDaysInput({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return AlertDialog(
      title: const Text('Ingrese el intervalo de días'),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number, // Solo números
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // Permite solo dígitos
        ],
        decoration: const InputDecoration(
          labelText: 'Días',
          hintText: 'Ingresa el número de días',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            String days = _controller.text;
            if (days.isNotEmpty && int.tryParse(days) != null) {
              onSelected('Intervalo de días: $days');
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Por favor, ingrese un número válido')),
              );
            }
          },
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
