import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/services/notification/task_notification_service.dart';
import 'package:todo_list/pages/notification_page.dart';
import '../components/new_task.dart';
import '../components/task_list.dart';
import '../core/services/auth/auth_service.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ToDo App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        SizedBox(width: 10),
                        Text('Sair'),
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  AuthService().logout();
                }
              },
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) {
                      return NotificationPage();
                    }),
                  );
                },
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: Colors.deepPurple.shade200,
                  child: Text(
                    '${Provider.of<TaskNotificationService>(context).itemsCount}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: TasksList(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: NewTaks(),
          ),
        ],
      ),
    );
  }
}
