import '../../domain/entities/task.dart';
import '../../domain/entities/routine.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final List<Routine> routines;

  TaskLoaded({required this.tasks, required this.routines});
}

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);
}

