import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/models/task.dart';
import '../core/services/tasks/task_service.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Container(
          width: 30,
          height: 30,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80),
              )),
              side: WidgetStateProperty.all<BorderSide>(BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              )),
            ),
            onPressed: () => TaskService().removeTask(task.id),
            child: Text(''),
          ),
        ),
        title: Text(
          task.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          'Entrega: ${DateFormat('d MMM y').format(task.deliveryDate)}',
        ),
      ),
    );
  }
}
