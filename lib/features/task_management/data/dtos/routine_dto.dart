class RoutineDto {
  final int id;
  final int bookId;
  final String bookTitle;
  final String action;
  final String frequency;
  final int progress;
  final int total;
  final bool completed;

  RoutineDto({
    required this.id,
    required this.bookId,
    required this.bookTitle,
    required this.action,
    required this.frequency,
    required this.progress,
    required this.total,
    required this.completed,
  });

  factory RoutineDto.fromJson(Map<String, dynamic> json) => RoutineDto(
    id: json['id'],
    bookId: json['bookId'],
    bookTitle: json['bookTitle'],
    action: json['action'],
    frequency: json['frequency'],
    progress: json['progress'],
    total: json['total'],
    completed: json['completed'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'bookId': bookId,
    'bookTitle': bookTitle,
    'action': action,
    'frequency': frequency,
    'progress': progress,
    'total': total,
    'completed': completed,
  };
}
