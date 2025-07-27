class Task {
  final int id;
  final int bookId;
  final String bookTitle;
  final String action;
  final String? dueDate;
  final String status;

  Task({
    required this.id,
    required this.bookId,
    required this.bookTitle,
    required this.action,
    this.dueDate,
    required this.status,
  });

  Task copyWith({
    int? id,
    int? bookId,
    String? bookTitle,
    String? action,
    String? dueDate,
    String? status,
  }) {
    return Task(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      bookTitle: bookTitle ?? this.bookTitle,
      action: action ?? this.action,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Task && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}