import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../intl/l10n.dart';
import '../../domain/entities/routine.dart';
import '../cubit/task_cubit.dart';
import '../cubit/task_state.dart';
import '../widgets/draggable_routine_item.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/loading_widget.dart';
// Import your language cubit
import '../../../../core/localization/cubit/language_cubit.dart';
import '../../../../core/localization/cubit/language_state.dart';

class RoutineTab extends StatelessWidget {
  const RoutineTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        return switch (state) {
          TaskLoading() => LoadingWidget(message: S.of(context).LoadingRoutines ?? 'جاري تحميل الروتين...'),
          TaskLoaded() => _buildRoutineList(context, state.routines),
          TaskError() => _buildErrorState(context, state.message),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  Widget _buildRoutineList(BuildContext context, List<Routine> routines) {
    if (routines.isEmpty) {
      return EmptyStateWidget(
        message: S.of(context).NoRoutines ?? 'لا يوجد روتين حالياً\nابدأ بإضافة روتين جديد',
        icon: Icons.schedule,
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
          child: Directionality(
            textDirection: textDirection,
            child: ReorderableListView.builder(
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
                lastScrollTime = null;
              },
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
          EmptyStateWidget(
            message: S.of(context).DataLoadError ?? 'حدث خطأ في تحميل البيانات',
            icon: Icons.error_outline,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<TaskCubit>().loadAll(),
            child: Text(S.of(context).Retry ?? 'إعادة المحاولة'),
          ),
        ],
      ),
    );
  }
}