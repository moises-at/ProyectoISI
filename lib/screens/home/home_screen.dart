import 'package:flutter/material.dart';
import 'package:pastiya/screens/home/reminder_card.dart';
import '../../reminder_service.dart'; // Importa la lógica de recordatorios
import 'bottom_nav_bar.dart'; // Importa la barra de navegación personalizada
import '../../add_reminder_button.dart'; // Importa el botón flotante
import '../reminderscreen/add_reminder_screen.dart';
// Importa el nuevo widget ReminderCard

class HomeScreen extends StatefulWidget {
  final String email;

  HomeScreen({required this.email});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> reminders = [];
  final ReminderService _reminderService = ReminderService(); // Instancia del servicio

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    reminders = await _reminderService.loadReminders(widget.email);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recordatorios'),
      ),
      body: reminders.isEmpty
          ? const Center(
              child: Text(
                'No tienes recordatorios para hoy',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final reminder = reminders[index];
                return ReminderCard(
                  medicamento: reminder['medicamento'],
                  hora: reminder['hora'],
                );
              },
            ),
      bottomNavigationBar: CustomBottomNavBar(
        onAddPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddReminderScreen(email: widget.email),
            ),
          ).then((value) {
            _loadReminders();
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AddReminderButton(
        email: widget.email,
        refreshReminders: _loadReminders,
      ),
    );
  }
}
