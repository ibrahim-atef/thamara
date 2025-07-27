import '../../../../core/network/api_client.dart';
import '../dtos/task_dto.dart';
import '../dtos/routine_dto.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskDto>> getTasks();
  Future<void> updateTask(int id, Map<String, dynamic> data);
  Future<List<RoutineDto>> getRoutines();
  Future<void> completeRoutine(int id);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final ApiClient apiClient;
  TaskRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<TaskDto>> getTasks() => apiClient.getTasks();

  @override
  Future<void> updateTask(int id, Map<String, dynamic> data) =>
      apiClient.updateTask(id, data);

  @override
  Future<List<RoutineDto>> getRoutines() => apiClient.getRoutines();

  @override
  Future<void> completeRoutine(int id) => apiClient.completeRoutine(id);
}