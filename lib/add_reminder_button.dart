import 'package:flutter/material.dart';
import 'screens/reminderscreen/add_reminder_screen.dart'; // Importar la pantalla para agregar recordatorios

class AddReminderButton extends StatelessWidget {
  final String email;
  final Function refreshReminders;

  const AddReminderButton({super.key, required this.email, required this.refreshReminders});

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
            color: Colors.pink,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
