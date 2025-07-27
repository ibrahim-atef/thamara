import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial(const Locale('ar')));

  void toggleLanguage() {
    final newLocale = state.locale.languageCode == 'ar'
        ? const Locale('en')
        : const Locale('ar');
    emit(LanguageChanged(newLocale));
  }

  void changeLanguage(Locale locale) {
    emit(LanguageChanged(locale)); // ✅ Use concrete class
  }

  void setLocale(Locale locale) {
    emit(LanguageChanged(locale)); // Optional alias
  }
}
