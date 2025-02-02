import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../models/task_notification.dart';

class TaskNotificationService with ChangeNotifier {
  final List<TaskNotification> _items = [];

  List<TaskNotification> get items {
    // Notação para retornar um clone
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  void add(TaskNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i) {
    _items.removeAt(i);
    notifyListeners();
  }

  Future<void> init() async {}

  Future<bool> get _isAutorized async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> _configureForeground() async {
    if (await _isAutorized) {
      FirebaseMessaging.onMessage.listen((msg) {
        add(TaskNotification(
          title: msg.notification!.title ?? 'Não informado',
          body: msg.notification!.body ?? 'Não informado',
        ));
      });
    }
  }
}
