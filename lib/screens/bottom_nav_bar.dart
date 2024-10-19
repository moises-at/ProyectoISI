import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final VoidCallback onAddPressed; // Callback para el botón de añadir

  CustomBottomNavBar({required this.onAddPressed});

    @override
    Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromARGB(255, 138, 184, 221),
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Container(
        height: 60.0, // Asegura que la barra inferior tenga altura
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Acción futura para el botón de usuario
              },
            ),
            IconButton(
              icon: Icon(Icons.local_hospital),
              onPressed: () {
                // Acción futura para el botón de pastillas
              },
            ),
          ],
        ),
      ),
    );
  }
}
