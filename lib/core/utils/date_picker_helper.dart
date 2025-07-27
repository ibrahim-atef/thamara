import 'package:flutter/material.dart';

class DatePickerHelper {
  static Future<void> showCustomDatePicker({
    required BuildContext context,
    required Function(DateTime) onDateSelected,
    DateTime? initialDate,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      helpText: 'اختر تاريخ التسليم',
      cancelText: 'إلغاء',
      confirmText: 'موافق',
      locale: const Locale('ar'),
    );

    if (picked != null) {
      onDateSelected(picked);
    }
  }
}