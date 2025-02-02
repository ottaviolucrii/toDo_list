
import '../../models/task.dart';
import 'task_firebase_service.dart';

abstract class TaskService {
  Stream<List<Task>> tasksStream();
  Future<Task?> save(String title, DateTime deliveryDate);

  removeTask(String paramId);

  factory TaskService() {
    return TaskFirebaseService();
  }
}