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
      child: Stack(
        children: [
          if (routine.progress == routine.total)
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
              value: routine.completed,
              onChanged: (bool? value) {
                print('Checkbox clicked: $value');
                if (value != null) {
                  onToggle();
                }
              },
              activeColor: Color(0xFF7D913A),
            ),
            title: Text(
              routine.action,
              style: GoogleFonts.cairo(
                color: routine.completed ? Colors.grey[600] : null,
                fontWeight: routine.completed ? FontWeight.normal : FontWeight.w500,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الكتاب: ${routine.bookTitle}',
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    color: routine.completed ? Colors.grey[500] : null,
                  ),
                ),
                Text(
                  'التكرار: ${routine.frequency}',
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    color: routine.completed ? Colors.grey[500] : null,
                  ),
                ),
                Text(
                  'التقدم: ${routine.progress}/${routine.total}',
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    color: routine.completed ? Colors.grey[500] : null,
                  ),
                ),
              ],
            ),
            trailing: SizedBox(
              width: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: routine.total > 0 ? routine.progress / routine.total : 0,
                  minHeight: 8,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    routine.completed ? Color(0xFF7D913A) : const Color(0xFF7D913A),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}