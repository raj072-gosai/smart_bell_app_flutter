import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  // Set default theme to light mode
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  // Toggle theme method
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _saveThemeToPreferences();
    notifyListeners();
  }

  // Method to save the theme preference
  Future<void> _saveThemeToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', _isDarkTheme);
  }

  // Method to load the theme preference when the app starts
  Future<void> loadThemeFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    notifyListeners();
  }
}
