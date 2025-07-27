import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../cubit/task_cubit.dart';
import 'todo_list_tab.dart';
import 'routine_tab.dart';

class TaskManagementPage extends StatefulWidget {
  const TaskManagementPage({super.key});

  @override
  State<TaskManagementPage> createState() => _TaskManagementPageState();
}

class _TaskManagementPageState extends State<TaskManagementPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TaskCubit>()..loadAll(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('مهامي'),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'قائمة المهام'),
                Tab(text: 'روتيني اليومي'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: const [TodoListTab(), RoutineTab()],
          ),
        ),
      ),
    );
  }
}