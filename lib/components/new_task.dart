// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'task_form.dart';

class NewTaks extends StatelessWidget {
  const NewTaks({super.key});

  _openTaskFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TaskForm();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      child: IconButton(
        onPressed: () => _openTaskFormModal(context),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
                Theme.of(context).colorScheme.primary)),
      ),
    );
  }
}