import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/dummy_data_service.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/routine.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/update_task.dart';
import '../../domain/usecases/get_routines.dart';
import '../../domain/usecases/complete_routine.dart';
import 'task_state.dart';


class TaskCubit extends Cubit<TaskState> {
  final GetTasks getTasks;
  final UpdateTask updateTask;
  final GetRoutines getRoutines;
  final CompleteRoutine completeRoutine;
  final DummyDataService dummyDataService;

  List<Task> _currentTasks = [];
  List<Routine> _currentRoutines = [];

  TaskCubit(
      this.getTasks,
      this.updateTask,
      this.getRoutines,
      this.completeRoutine,
      this.dummyDataService,
      ) : super(TaskInitial());

  Future<void> loadAll() async {
    emit(TaskLoading());
    try {
      final tasks = await _loadTasksWithFallback();
      final routines = await _loadRoutinesWithFallback();

      _currentTasks = List.from(tasks);
      _currentRoutines = List.from(routines);

      emit(TaskLoaded(tasks: _currentTasks, routines: _currentRoutines));
    } catch (e) {
      emit(TaskError('فشل في تحميل البيانات: ${e.toString()}'));
    }
  }

  Future<List<Task>> _loadTasksWithFallback() async {
    try {
      return await getTasks();
    } catch (e) {
      return dummyDataService.getDummyTasks();
    }
  }

  Future<List<Routine>> _loadRoutinesWithFallback() async {
    try {
      return await getRoutines();
    } catch (e) {
      return dummyDataService.getDummyRoutines();
    }
  }

  Future<void> toggleTaskStatus(Task task) async {
    try {
      final newStatus = task.status == 'completed' ? 'pending' : 'completed';
      await updateTask(task.id, {'status': newStatus});
      await loadAll();
    } catch (e) {
      dummyDataService.updateTaskStatus(task.id,
          task.status == 'completed' ? 'pending' : 'completed');
      await loadAll();
    }
  }

  Future<void> updateTaskDueDate(Task task, String dueDate) async {
    try {
      await updateTask(task.id, {'due_date': dueDate});
      await loadAll();
    } catch (e) {
      dummyDataService.updateTaskDueDate(task.id, dueDate);
      await loadAll();
    }
  }

  Future<void> completeRoutineAction(int id) async {
    try {
      await completeRoutine(id);
      await loadAll();
    } catch (e) {
      dummyDataService.completeRoutine(id);
      await loadAll();
    }
  }

  void reorderTasks(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final task = _currentTasks.removeAt(oldIndex);
    _currentTasks.insert(newIndex, task);

    emit(TaskLoaded(tasks: List.from(_currentTasks), routines: List.from(_currentRoutines)));
  }

  void reorderRoutines(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final routine = _currentRoutines.removeAt(oldIndex);
    _currentRoutines.insert(newIndex, routine);

    emit(TaskLoaded(tasks: List.from(_currentTasks), routines: List.from(_currentRoutines)));
  }
}

