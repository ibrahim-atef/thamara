import '../../domain/repositories/task_repository.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/routine.dart';
import '../datasources/task_remote_datasource.dart';
import '../datasources/task_local_datasource.dart';
import '../dtos/routine_dto.dart';
import '../dtos/task_dto.dart';


class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remote;
  final TaskLocalDataSource local;

  TaskRepositoryImpl(this.remote, this.local);

  @override
  Future<List<Task>> getTasks() async {
    try {
      final dtos = await remote.getTasks();
      await local.cacheTasks(dtos);
      return _mapTaskDtosToEntities(dtos);
    } catch (e) {
      final cachedDtos = local.getCachedTasks();
      if (cachedDtos.isNotEmpty) {
        return _mapTaskDtosToEntities(cachedDtos);
      }
      throw Exception('No cached tasks available and API failed: $e');
    }
  }

  @override
  Future<List<Routine>> getRoutines() async {
    try {
      final dtos = await remote.getRoutines();
      await local.cacheRoutines(dtos);
      return _mapRoutineDtosToEntities(dtos);
    } catch (e) {
      final cachedDtos = local.getCachedRoutines();
      if (cachedDtos.isNotEmpty) {
        return _mapRoutineDtosToEntities(cachedDtos);
      }
      throw Exception('No cached routines available and API failed: $e');
    }
  }

  @override
  Future<void> updateTask(int id, Map<String, dynamic> data) async {
    await remote.updateTask(id, data);
  }

  @override
  Future<void> completeRoutine(int id) async {
    await remote.completeRoutine(id);
  }

  List<Task> _mapTaskDtosToEntities(List<TaskDto> dtos) {
    return dtos.map((dto) => Task(
      id: dto.id,
      bookId: dto.bookId,
      bookTitle: dto.bookTitle,
      action: dto.action,
      dueDate: dto.dueDate,
      status: dto.status,
    )).toList();
  }

  List<Routine> _mapRoutineDtosToEntities(List<RoutineDto> dtos) {
    return dtos.map((dto) => Routine(
      id: dto.id,
      bookId: dto.bookId,
      bookTitle: dto.bookTitle,
      action: dto.action,
      frequency: dto.frequency,
      progress: dto.progress,
      total: dto.total,
      completed: dto.completed,
    )).toList();
  }
}