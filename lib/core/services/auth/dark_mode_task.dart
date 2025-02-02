import 'package:flutter/material.dart';

class DarkModeTask with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode {
    return _isDarkMode;
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: Colors.redAccent),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.grey[900],
  hintColor: Colors.redAccent,
  appBarTheme: AppBarTheme(
    color: Colors.grey[850],
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.grey[900]!,
    secondary: Colors.redAccent,
  ),
);