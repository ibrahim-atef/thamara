import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/task.dart';

class DraggableTaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDatePressed;

  const DraggableTaskItem({
    required Key key,
    required this.task,
    required this.onToggle,
    required this.onDatePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: key,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Checkbox(
          value: task.status == 'completed',
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          task.action,
          style: GoogleFonts.cairo(
            decoration: task.status == 'completed'
                ? TextDecoration.lineThrough
                : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الكتاب: ${task.bookTitle}',
              style: GoogleFonts.cairo(fontSize: 14),
            ),
            if (task.dueDate != null)
              Text(
                'تاريخ التسليم: ${_formatDate(task.dueDate!)}',
                style: GoogleFonts.cairo(fontSize: 14),
              ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.date_range),
          onPressed: onDatePressed,
        ),
      ),
    );
  }

  String _formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return isoDate;
    }
  }
}