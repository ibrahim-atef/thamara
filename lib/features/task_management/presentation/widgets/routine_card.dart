import 'package:flutter/material.dart';
import '../../domain/entities/routine.dart';
import 'package:google_fonts/google_fonts.dart';

class RoutineCard extends StatelessWidget {
  final Routine routine;
  final VoidCallback onToggle;
  const RoutineCard({super.key, required this.routine, required this.onToggle});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Checkbox(
          value: routine.completed,
          onChanged: (_) => onToggle(),
        ),
        title: Text(routine.action, style: GoogleFonts.cairo()),
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
          ),
        ),
      ),
    );
  }
}
