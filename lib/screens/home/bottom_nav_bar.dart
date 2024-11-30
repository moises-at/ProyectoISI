import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final VoidCallback onAddPressed; // Callback para el botón de añadir

  // ignore: use_key_in_widget_constructors
  const CustomBottomNavBar({required this.onAddPressed});

    @override
    Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromARGB(255, 3  , 103, 165),
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Container(
        height: 60.0, // Asegura que la barra inferior tenga altura
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.person),color: Colors.white,iconSize: 30,
              onPressed: () {
                // Acción futura para el botón de usuario
              },
            ),
            IconButton(
              icon: const Icon(Icons.medication,),color: Colors.white, iconSize: 30,
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
