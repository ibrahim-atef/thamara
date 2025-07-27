import 'package:dio/dio.dart';
import '../../features/task_management/data/dtos/task_dto.dart';
import '../../features/task_management/data/dtos/routine_dto.dart';

class ApiClient {
  final Dio dio;
  ApiClient(this.dio);

  Future<List<TaskDto>> getTasks() async {
    final response = await dio.get('/tasks');
    return (response.data as List).map((e) => TaskDto.fromJson(e)).toList();
  }

  Future<List<RoutineDto>> getRoutines() async {
    final response = await dio.get('/routines');
    return (response.data as List).map((e) => RoutineDto.fromJson(e)).toList();
  }

  Future<void> updateTask(int id, Map<String, dynamic> data) async {
    await dio.post('/tasks/$id/update', data: data);
  }

  Future<void> completeRoutine(int id) async {
    await dio.post('/routines/$id/complete');
  }
}
