import 'package:flutter/material.dart';

abstract class LanguageState {
  final Locale locale;
  LanguageState(this.locale);
}

class LanguageInitial extends LanguageState {
  LanguageInitial(Locale locale) : super(locale);
}

class LanguageChanged extends LanguageState {
  LanguageChanged(Locale locale) : super(locale);
}
