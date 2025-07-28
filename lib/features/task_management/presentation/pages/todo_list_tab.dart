import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/date_picker_helper.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../intl/l10n.dart';
import '../cubit/task_cubit.dart';
import '../cubit/task_state.dart';
import '../../domain/entities/task.dart';
import '../widgets/draggable_task_item.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/loading_widget.dart';
import '../../../../core/localization/cubit/language_cubit.dart';
import '../../../../core/localization/cubit/language_state.dart';

// Custom scroll behavior to ensure proper directionality
class CustomScrollBehavior extends ScrollBehavior {
  final TextDirection textDirection;

  const CustomScrollBehavior({required this.textDirection});

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    return Directionality(
      textDirection: textDirection,
      child: super.buildScrollbar(context, child, details),
    );
  }
}

class TodoListTab extends StatelessWidget {
  const TodoListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        return switch (state) {
          TaskLoading() => LoadingWidget(message: S.of(context).LoadingTasks),
          TaskLoaded() => _buildTaskList(context, state.tasks),
          TaskError() => _buildErrorState(context, state.message),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  Widget _buildTaskList(BuildContext context, List<Task> tasks) {
    if (tasks.isEmpty) {
      return EmptyStateWidget(
        message: S.of(context).NoTasks,
        icon: Icons.task_alt,
      );
    }

    DateTime? lastScrollTime;

    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, languageState) {
        final isRtl = languageState.locale.languageCode == 'ar';
        final textDirection = isRtl ? TextDirection.rtl : TextDirection.ltr;

        return NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward ||
                notification.direction == ScrollDirection.reverse) {
              final now = DateTime.now();
              if (lastScrollTime == null ||
                  now.difference(lastScrollTime!) > const Duration(seconds: 30)) {
                CustomSnackBar.showDragHint(context);
                lastScrollTime = now;
              }
            }
            return false;
          },
          child: ScrollConfiguration(
            behavior: CustomScrollBehavior(textDirection: textDirection),
            child: Directionality(
              textDirection: textDirection,
              child: ReorderableListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: tasks.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Directionality(key:  ValueKey(task.id),
                    textDirection: textDirection,
                    child: DraggableTaskItem(
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
                    ),
                  );
                },
                onReorder: (oldIndex, newIndex) {
                  context.read<TaskCubit>().reorderTasks(oldIndex, newIndex);
                  lastScrollTime = null;
                },
              ),
            ),
          ),
        );
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