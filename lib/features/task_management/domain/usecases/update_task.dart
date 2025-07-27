import '../repositories/task_repository.dart';

class UpdateTask {
  final TaskRepository repository;
  UpdateTask(this.repository);
  Future<void> call(int id, Map<String, dynamic> data) =>
      repository.updateTask(id, data);
}
