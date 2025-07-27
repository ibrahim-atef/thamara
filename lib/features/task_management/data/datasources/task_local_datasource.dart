import '../dtos/task_dto.dart';
import '../dtos/routine_dto.dart';

abstract class TaskLocalDataSource {
  Future<void> cacheTasks(List<TaskDto> tasks);
  List<TaskDto> getCachedTasks();
  Future<void> cacheRoutines(List<RoutineDto> routines);
  List<RoutineDto> getCachedRoutines();
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  List<TaskDto> _tasks = [];
  List<RoutineDto> _routines = [];

  @override
  Future<void> cacheTasks(List<TaskDto> tasks) async {
    _tasks = List.from(tasks);
  }

  @override
  List<TaskDto> getCachedTasks() => List.from(_tasks);

  @override
  Future<void> cacheRoutines(List<RoutineDto> routines) async {
    _routines = List.from(routines);
  }

  @override
  List<RoutineDto> getCachedRoutines() => List.from(_routines);
}
