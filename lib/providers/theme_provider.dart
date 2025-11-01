import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  SharedPreferences? _prefs;

  ThemeProvider() {
    _loadThemeMode();
  }

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // Load saved theme mode from SharedPreferences
  Future<void> _loadThemeMode() async {
    _prefs = await SharedPreferences.getInstance();
    final savedThemeMode = _prefs?.getString(AppConstants.keyThemeMode);

    if (savedThemeMode != null) {
      _themeMode = savedThemeMode == 'dark' ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }

  // Toggle between light and dark mode
  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _saveThemeMode();
    notifyListeners();
  }

  // Set specific theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode != mode) {
      _themeMode = mode;
      await _saveThemeMode();
      notifyListeners();
    }
  }

  // Save theme mode to SharedPreferences
  Future<void> _saveThemeMode() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs?.setString(
      AppConstants.keyThemeMode,
      _themeMode == ThemeMode.dark ? 'dark' : 'light',
    );
  }
}