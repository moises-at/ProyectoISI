import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderService {
  // Cargar recordatorios
  Future<List<Map<String, dynamic>>> loadReminders(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? reminderData = prefs.getString('${email}_reminders');
    if (reminderData != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(reminderData) as List);
    }
    return [];
  }

  // Guardar un nuevo recordatorio
  Future<void> saveReminder(String email, Map<String, dynamic> reminder) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> reminders = await loadReminders(email);
    reminders.add(reminder);
    prefs.setString('${email}_reminders', jsonEncode(reminders));
  }

  // Eliminar un recordatorio
  Future<void> deleteReminder(String email, Map<String, dynamic> reminder) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = '${email}_reminders'; // La clave es única para cada usuario
    List<Map<String, dynamic>> reminders = await loadReminders(email);
    
    // Elimina el recordatorio de la lista
    reminders.removeWhere((r) => r['medicamento'] == reminder['medicamento'] && r['hora'] == reminder['hora']);
    
    // Guarda la lista actualizada en SharedPreferences
    prefs.setString(key, jsonEncode(reminders));
  }


  // Actualizar un recordatorio
  Future<void> updateReminder(String email, Map<String, dynamic> oldReminder, Map<String, dynamic> newReminder) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> reminders = await loadReminders(email);
    int index = reminders.indexWhere((r) => r['medicamento'] == oldReminder['medicamento'] && r['hora'] == oldReminder['hora']);
    if (index != -1) {
      reminders[index] = newReminder;
      prefs.setString('${email}_reminders', jsonEncode(reminders));
    }
  }

}
