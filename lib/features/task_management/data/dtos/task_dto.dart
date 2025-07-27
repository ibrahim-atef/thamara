class TaskDto {
  final int id;
  final int bookId;
  final String bookTitle;
  final String action;
  final String? dueDate;
  final String status;

  TaskDto({
    required this.id,
    required this.bookId,
    required this.bookTitle,
    required this.action,
    this.dueDate,
    required this.status,
  });

  factory TaskDto.fromJson(Map<String, dynamic> json) => TaskDto(
    id: json['id'],
    bookId: json['bookId'],
    bookTitle: json['bookTitle'],
    action: json['action'],
    dueDate: json['dueDate'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'bookId': bookId,
    'bookTitle': bookTitle,
    'action': action,
    'dueDate': dueDate,
    'status': status,
  };
}