// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/services/tasks/task_service.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> _submitForm() async {
    final title = _titleController.text;

    if (title.isEmpty || _selectedDate == null) {
      return;
    }

    await TaskService().save(title, _selectedDate);

    Navigator.of(context).pop();
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Título',
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Nenhuma data de entrega selecionada!'
                          : 'Data de entrega: ${DateFormat('dd/MM/y').format((_selectedDate))}',
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all<Color>(
                          Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: _showDatePicker,
                    child: Text(
                      'Selecionar data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              height: 60,
              width: 60,
              child: IconButton(
                onPressed: () => _submitForm(),
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primary)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
