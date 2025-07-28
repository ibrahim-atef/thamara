

import '../../features/task_management/domain/entities/routine.dart';
import '../../features/task_management/domain/entities/task.dart';

class DummyDataService {
  static final List<Task> _dummyTasks = [
    Task(
      id: 5,
      bookId: 105,
      bookTitle: 'الأذكار للنووي',
      action: 'مراجعة أذكار الصباح والمساء',
      dueDate: DateTime.now().add(const Duration(days: 1)).toIso8601String(),
      status: 'pending',
    ),
    Task(
      id: 2,
      bookId: 102,
      bookTitle: 'تفسير ابن كثير',
      action: 'مراجعة تفسير سورة البقرة (الآيات 1-20)',
      dueDate: DateTime.now().add(const Duration(days: 3)).toIso8601String(),
      status: 'pending',
    ),
    Task(
      id: 1,
      bookId: 101,
      bookTitle: 'الفقه الميسر',
      action: 'قراءة الفصل الأول - أحكام الطهارة',
      dueDate: DateTime.now().add(const Duration(days: 7)).toIso8601String(),
      status: 'pending',
    ),
    Task(
      id: 3,
      bookId: 103,
      bookTitle: 'صحيح البخاري',
      action: 'حفظ 5 أحاديث من كتاب الإيمان',
      dueDate: DateTime.now().add(const Duration(days: 14)).toIso8601String(),
      status: 'completed',
    ),
    Task(
      id: 4,
      bookId: 104,
      bookTitle: 'السيرة النبوية لابن هشام',
      action: 'قراءة فترة الطفولة والشباب',
      status: 'pending',
    ),
  ];

  static final List<Routine> _dummyRoutines = [
    Routine(
      id: 4,
      bookId: 204,
      bookTitle: 'الأربعون النووية',
      action: 'حفظ حديث أسبوعياً مع الشرح',
      frequency: 'أسبوعي',
      progress: 40,
      total: 40,
      completed: true,
    ),
    Routine(
      id: 2,
      bookId: 202,
      bookTitle: 'الأذكار للنووي',
      action: 'مراجعة الأذكار الصباحية والمسائية',
      frequency: 'يومي',
      progress: 28,
      total: 30,
      completed: false,
    ),
    Routine(
      id: 3,
      bookId: 203,
      bookTitle: 'رياض الصالحين',
      action: 'قراءة باب أسبوعياً مع التدبر',
      frequency: 'أسبوعي',
      progress: 12,
      total: 20,
      completed: false,
    ),
    Routine(
      id: 5,
      bookId: 205,
      bookTitle: 'كتاب التوحيد',
      action: 'مراجعة باب شهرياً',
      frequency: 'شهري',
      progress: 8,
      total: 12,
      completed: false,
    ),
    Routine(
      id: 1,
      bookId: 201,
      bookTitle: 'القرآن الكريم',
      action: 'قراءة صفحة يومياً من المصحف',
      frequency: 'يومي',
      progress: 45,
      total: 604,
      completed: false,
    ),
  ];
  List<Task> getDummyTasks() => List.from(_dummyTasks);

  List<Routine> getDummyRoutines() => List.from(_dummyRoutines);

  void updateTaskStatus(int id, String newStatus) {
    final taskIndex = _dummyTasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _dummyTasks[taskIndex] = Task(
        id: _dummyTasks[taskIndex].id,
        bookId: _dummyTasks[taskIndex].bookId,
        bookTitle: _dummyTasks[taskIndex].bookTitle,
        action: _dummyTasks[taskIndex].action,
        dueDate: _dummyTasks[taskIndex].dueDate,
        status: newStatus,
      );
    }
  }

  void updateTaskDueDate(int id, String dueDate) {
    final taskIndex = _dummyTasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _dummyTasks[taskIndex] = Task(
        id: _dummyTasks[taskIndex].id,
        bookId: _dummyTasks[taskIndex].bookId,
        bookTitle: _dummyTasks[taskIndex].bookTitle,
        action: _dummyTasks[taskIndex].action,
        dueDate: dueDate,
        status: _dummyTasks[taskIndex].status,
      );
    }
  }

  void completeRoutine(int id) {
    final routineIndex = _dummyRoutines.indexWhere((routine) => routine.id == id);
    if (routineIndex != -1) {
      final routine = _dummyRoutines[routineIndex];
      final newProgress = routine.progress < routine.total
          ? routine.progress + 1
          : routine.total;

      _dummyRoutines[routineIndex] = Routine(
        id: routine.id,
        bookId: routine.bookId,
        bookTitle: routine.bookTitle,
        action: routine.action,
        frequency: routine.frequency,
        progress: newProgress,
        total: routine.total,
        completed: newProgress >= routine.total,
      );
    }
  }

  void toggleRoutineCompletion(int id) {
    final routineIndex = _dummyRoutines.indexWhere((routine) => routine.id == id);
    if (routineIndex != -1) {
      final routine = _dummyRoutines[routineIndex];
      _dummyRoutines[routineIndex] = Routine(
        id: routine.id,
        bookId: routine.bookId,
        bookTitle: routine.bookTitle,
        action: routine.action,
        frequency: routine.frequency,
        progress: routine.progress  ,
        total: routine.total,
        completed: !routine.completed,
      );
    }
  }
  Routine? getRoutineById(int id) {
    try {
      return _dummyRoutines.firstWhere((routine) => routine.id == id);
    } catch (e) {
      return null;
    }
  }
}
