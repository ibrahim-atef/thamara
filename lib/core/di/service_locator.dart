import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../network/dio_provider.dart';
import '../network/api_client.dart';
import '../../features/task_management/data/datasources/task_remote_datasource.dart';
import '../../features/task_management/data/datasources/task_local_datasource.dart';
import '../../features/task_management/data/repositories/task_repository_impl.dart';
import '../../features/task_management/domain/repositories/task_repository.dart';
import '../../features/task_management/domain/usecases/get_tasks.dart';
import '../../features/task_management/domain/usecases/update_task.dart';
import '../../features/task_management/domain/usecases/get_routines.dart';
import '../../features/task_management/domain/usecases/complete_routine.dart';
import '../../features/task_management/presentation/cubit/task_cubit.dart';
 import '../utils/dummy_data_service.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<Dio>(() => DioProvider.create());
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl<Dio>()));

  sl.registerLazySingleton<TaskRemoteDataSource>(
        () => TaskRemoteDataSourceImpl(sl<ApiClient>()),
  );
  sl.registerLazySingleton<TaskLocalDataSource>(
        () => TaskLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<TaskRepository>(
        () => TaskRepositoryImpl(sl(), sl()),
  );

  sl.registerLazySingleton<GetTasks>(() => GetTasks(sl()));
  sl.registerLazySingleton<UpdateTask>(() => UpdateTask(sl()));
  sl.registerLazySingleton<GetRoutines>(() => GetRoutines(sl()));
  sl.registerLazySingleton<CompleteRoutine>(() => CompleteRoutine(sl()));

  sl.registerLazySingleton<DummyDataService>(() => DummyDataService());

  sl.registerFactory(() => TaskCubit(sl(), sl(), sl(), sl(), sl()));
}