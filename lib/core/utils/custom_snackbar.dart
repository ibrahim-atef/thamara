import 'package:flutter/material.dart';

import '../../intl/l10n.dart';

class CustomSnackBar {
  static void showDragHint(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.drag_handle, color: Colors.white),
            SizedBox(width: 8),
            Text(
              S.of(context).Dragitemsupordowntoreorder,
              style: TextStyle(fontFamily: 'Cairo'),
            ),
          ],
        ),
        backgroundColor: Color(0xFF7D913A),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.all(16),
      ),
    );
  }
}