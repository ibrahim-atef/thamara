import '../repositories/task_repository.dart';

class CompleteRoutine {
  final TaskRepository repository;
  CompleteRoutine(this.repository);
  Future<void> call(int id) => repository.completeRoutine(id);
}
