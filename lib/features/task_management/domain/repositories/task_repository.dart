import '../entities/task.dart';
import '../entities/routine.dart';



abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> updateTask(int id, Map<String, dynamic> data);
  Future<List<Routine>> getRoutines();
  Future<void> completeRoutine(int id);
}