import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/date_picker_helper.dart';
import '../cubit/task_cubit.dart';
import '../cubit/task_state.dart';
import '../../domain/entities/task.dart';
import '../widgets/draggable_task_item.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/loading_widget.dart';

class TodoListTab extends StatelessWidget {
  const TodoListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        return switch (state) {
          TaskLoading() => const LoadingWidget(message: 'جاري تحميل المهام...'),
          TaskLoaded() => _buildTaskList(context, state.tasks),
          TaskError() => _buildErrorState(context, state.message),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  Widget _buildTaskList(BuildContext context, List<Task> tasks) {
    if (tasks.isEmpty) {
      return const EmptyStateWidget(
        message: 'لا توجد مهام حالياً\nابدأ بإضافة مهمة جديدة',
        icon: Icons.task_alt,
      );
    }

    return ReorderableListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return DraggableTaskItem(
          key: ValueKey(task.id),
          task: task,
          onToggle: () => context.read<TaskCubit>().toggleTaskStatus(task),
          onDatePressed: () => DatePickerHelper.showCustomDatePicker(
            context: context,
            onDateSelected: (date) => context.read<TaskCubit>().updateTaskDueDate(
              task,
              date.toIso8601String(),
            ),
            initialDate: task.dueDate != null ? DateTime.parse(task.dueDate!) : null,
          ),
        );
      },
      onReorder: (oldIndex, newIndex) {
        context.read<TaskCubit>().reorderTasks(oldIndex, newIndex);
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