// filepath: /C:/Users/ottav/UNIFEI/Asimov/todo_list/lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/services/notification/task_notification_service.dart';
import 'package:todo_list/pages/auth_or_app_page.dart';
import 'core/services/auth/dark_mode_task.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskNotificationService()),
        ChangeNotifierProvider(create: (_) => DarkModeTask()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeTask>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          home: const AuthOrAppPage(),
          debugShowCheckedModeBanner: false,
          title: 'ToDo App',
          theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: Colors.redAccent),
          ),
        );
      },
    );
  }
}