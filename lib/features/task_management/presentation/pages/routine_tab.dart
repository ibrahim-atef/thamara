import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/routine.dart';
import '../cubit/task_cubit.dart';
import '../cubit/task_state.dart';
import '../widgets/draggable_routine_item.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/loading_widget.dart';

class RoutineTab extends StatelessWidget {
  const RoutineTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        return switch (state) {
          TaskLoading() => const LoadingWidget(message: 'جاري تحميل الروتين...'),
          TaskLoaded() => _buildRoutineList(context, state.routines),
          TaskError() => _buildErrorState(context, state.message),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  Widget _buildRoutineList(BuildContext context, List<Routine> routines) {
    if (routines.isEmpty) {
      return const EmptyStateWidget(
        message: 'لا يوجد روتين حالياً\nابدأ بإضافة روتين جديد',
        icon: Icons.schedule,
      );
    }

    return ReorderableListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: routines.length,
      itemBuilder: (context, index) {
        final routine = routines[index];
        return DraggableRoutineItem(
          key: ValueKey(routine.id),
          routine: routine,
          onToggle: () => context.read<TaskCubit>().completeRoutineAction(routine.id),
        );
      },
      onReorder: (oldIndex, newIndex) {
        context.read<TaskCubit>().reorderRoutines(oldIndex, newIndex);
      },
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const EmptyStateWidget(
            message: 'حدث خطأ في تحميل البيانات',
            icon: Icons.error_outline,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<TaskCubit>().loadAll(),
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }
}