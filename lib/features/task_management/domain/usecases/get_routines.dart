import '../repositories/task_repository.dart';
import '../entities/routine.dart';

class GetRoutines {
  final TaskRepository repository;
  GetRoutines(this.repository);
  Future<List<Routine>> call() => repository.getRoutines();
}
