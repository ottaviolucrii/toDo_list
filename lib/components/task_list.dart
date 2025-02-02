// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
import 'package:flutter/material.dart';

import '../core/models/task.dart';
import '../core/services/tasks/task_service.dart';
import 'task_card.dart';

class TasksList extends StatelessWidget {
  // final Function(String) onRemove;

  const TasksList({super.key});

  // _deletTask(String id) {
  //   TaskService().removeTask(id);
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
      stream: TaskService().tasksStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Nenhuma tarefa cadastrada',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 20),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          );
        } else {
          final tasks = snapshot.data!;
          return ListView.separated(
            padding: EdgeInsets.all(3),
            itemCount: tasks.length,
            itemBuilder: (ctx, i) => TaskCard(
              key: ValueKey(tasks[i].id),
              task: tasks[i],
              // onRemove: _deletTask,
            ),
            separatorBuilder: (ctx, i) {
              return SizedBox(height: 4);
            },
          );
        }
      },
    );
  }
}
