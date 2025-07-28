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
    final isCompleted = task.status == 'completed';

    return Card(
      key: key,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Stack(
        children: [
          if (isCompleted)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Color(0xFF7D913A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'مكتمل',
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ListTile(
            leading: Checkbox(
              value: isCompleted,
              onChanged: (_) => onToggle(),
              activeColor: Color(0xFF7D913A),
            ),
            title: Text(
              task.action,
              style: GoogleFonts.cairo(
                color: isCompleted ? Colors.grey[600] : null,
                fontWeight: isCompleted ? FontWeight.normal : FontWeight.w500,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الكتاب: ${task.bookTitle}',
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    color: isCompleted ? Colors.grey[500] : null,
                  ),
                ),
                if (task.dueDate != null)
                  Text(
                    'تاريخ التسليم: ${_formatDate(task.dueDate!)}',
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      color: isCompleted ? Colors.grey[500] : null,
                    ),
                  ),
              ],
            ),
            trailing: Column(mainAxisAlignment: MainAxisAlignment.end ,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                IconButton(
                  icon: Icon(Icons.date_range, color: isCompleted ? Colors.grey[500] : null),
                  onPressed: onDatePressed,
                ),
              ],
            ),
          ),
        ],
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