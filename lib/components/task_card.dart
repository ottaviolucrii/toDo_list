// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/models/task.dart';
import '../core/services/tasks/task_service.dart';
// import '../core/services/tasks/task_service.dart';

// Arquivo que implementa a estrutura base de um Card de uma Task
class TaskCard extends StatelessWidget {
  final Task task;
  // final Function(String) onRemove;

  const TaskCard({
    super.key, 
    required this.task, 
    // required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        // Container: botão de conclusão de uma task
        leading: Container(
          width: 30,
          height: 30,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80),
                )
              ),
              side: WidgetStateProperty.all<BorderSide>(
                BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                )
              ),
            ),
            // Função de conclusão de uma task do botão
            onPressed: () => TaskService().removeTask(task.id),
            child: Text(''),
          ),
        ),
        
        // Título da task
        title: Text(
          task.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        
        // Data de entrega da task
        subtitle: Text(
          'Entrega: ${DateFormat('d MMM y').format(task.deliveryDate)}',
        ),
      ),
    );
  }
}