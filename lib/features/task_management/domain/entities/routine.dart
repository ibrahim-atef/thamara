class Routine {
  final int id;
  final int bookId;
  final String bookTitle;
  final String action;
  final String frequency;
  final int progress;
  final int total;
  final bool completed;

  Routine({
    required this.id,
    required this.bookId,
    required this.bookTitle,
    required this.action,
    required this.frequency,
    required this.progress,
    required this.total,
    required this.completed,
  });

  Routine copyWith({
    int? id,
    int? bookId,
    String? bookTitle,
    String? action,
    String? frequency,
    int? progress,
    int? total,
    bool? completed,
  }) {
    return Routine(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      bookTitle: bookTitle ?? this.bookTitle,
      action: action ?? this.action,
      frequency: frequency ?? this.frequency,
      progress: progress ?? this.progress,
      total: total ?? this.total,
      completed: completed ?? this.completed,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Routine && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
