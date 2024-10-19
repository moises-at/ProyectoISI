import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderService {
  // Cargar los recordatorios desde SharedPreferences
  Future<List<Map<String, dynamic>>> loadReminders(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? reminderData = prefs.getString('${email}_reminders');

    if (reminderData != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(reminderData) as List);
    }
    return [];
  }
}
