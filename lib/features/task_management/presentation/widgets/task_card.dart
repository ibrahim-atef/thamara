import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDateChange;
  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDateChange,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Checkbox(
          value: task.status == 'completed',
          onChanged: (_) => onToggle(),
        ),
        title: Text(task.action, style: GoogleFonts.cairo()),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الكتاب: ${task.bookTitle}',
              style: GoogleFonts.cairo(fontSize: 14),
            ),
            if (task.dueDate != null)
              Text(
                'تاريخ التسليم: ${task.dueDate}',
                style: GoogleFonts.cairo(fontSize: 14),
              ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.date_range),
          onPressed: onDateChange,
        ),
      ),
    );
  }
}
