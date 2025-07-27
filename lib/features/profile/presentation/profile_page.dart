// lib/features/profile/presentation/pages/profile_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/cubit/language_cubit.dart';
import '../../../../core/localization/cubit/language_state.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            final isArabic = state.locale.languageCode == 'ar';

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Change Language (${isArabic ? 'العربية' : 'English'})'),
                Switch(
                  value: isArabic,
                  onChanged: (_) {
                    context.read<LanguageCubit>().changeLanguage(
                      isArabic ? const Locale('en') : const Locale('ar'),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
