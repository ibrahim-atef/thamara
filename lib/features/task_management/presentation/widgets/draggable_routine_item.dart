import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/routine.dart';

class DraggableRoutineItem extends StatelessWidget {
  final Routine routine;
  final VoidCallback onToggle;

  const DraggableRoutineItem({
    required Key key,
    required this.routine,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: key,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Checkbox(
          value: routine.completed,
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          routine.action,
          style: GoogleFonts.cairo(
            decoration: routine.completed
                ? TextDecoration.lineThrough
                : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الكتاب: ${routine.bookTitle}',
              style: GoogleFonts.cairo(fontSize: 14),
            ),
            Text(
              'التكرار: ${routine.frequency}',
              style: GoogleFonts.cairo(fontSize: 14),
            ),
            Text(
              'التقدم: ${routine.progress}/${routine.total}',
              style: GoogleFonts.cairo(fontSize: 14),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 60,
          child: LinearProgressIndicator(
            value: routine.total > 0 ? routine.progress / routine.total : 0,
            minHeight: 8,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              Color(0xFF7D913A),
            ),
          ),
        ),
      ),
    );
  }
}