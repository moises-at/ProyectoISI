import 'package:flutter/material.dart';
import 'add_reminder_screen.dart'; // Importar la pantalla para agregar recordatorios

class AddReminderButton extends StatelessWidget {
  final String email;
  final Function refreshReminders;

  AddReminderButton({required this.email, required this.refreshReminders});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      width: 60.0,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddReminderScreen(email: email),
            ),
          ).then((value) {
            refreshReminders();
          });
        },
        borderRadius: BorderRadius.circular(50.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
