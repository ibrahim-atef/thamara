// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `بحث`
  String get Search {
    return Intl.message('بحث', name: 'Search', desc: '', args: []);
  }

  /// `الكتب`
  String get Books {
    return Intl.message('الكتب', name: 'Books', desc: '', args: []);
  }

  /// `الملفات`
  String get Files {
    return Intl.message('الملفات', name: 'Files', desc: '', args: []);
  }

  /// `مهامي`
  String get MyTasks {
    return Intl.message('مهامي', name: 'MyTasks', desc: '', args: []);
  }

  /// `قائمة المهام`
  String get ToDoList {
    return Intl.message('قائمة المهام', name: 'ToDoList', desc: '', args: []);
  }

  /// `روتيني اليومي`
  String get MyDailyRoutine {
    return Intl.message(
      'روتيني اليومي',
      name: 'MyDailyRoutine',
      desc: '',
      args: [],
    );
  }

  /// `جاري تحميل المهام...`
  String get LoadingTasks {
    return Intl.message(
      'جاري تحميل المهام...',
      name: 'LoadingTasks',
      desc: '',
      args: [],
    );
  }

  /// `اضغط مطولا و اسحب العناصر لأعلى \nأو لأسفل لإعادة الترتيب`
  String get Dragitemsupordowntoreorder {
    return Intl.message(
      'اضغط مطولا و اسحب العناصر لأعلى \nأو لأسفل لإعادة الترتيب',
      name: 'Dragitemsupordowntoreorder',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد مهام حالياً\nابدأ بإضافة مهمة جديدة`
  String get NoTasks {
    return Intl.message(
      'لا توجد مهام حالياً\nابدأ بإضافة مهمة جديدة',
      name: 'NoTasks',
      desc: '',
      args: [],
    );
  }

  /// `جاري تحميل الروتينات...`
  String get LoadingRoutines {
    return Intl.message(
      'جاري تحميل الروتينات...',
      name: 'LoadingRoutines',
      desc: '',
      args: [],
    );
  }

  /// `لا يوجد روتين حالياً\nابدأ بإضافة روتين جديد`
  String get NoRoutines {
    return Intl.message(
      'لا يوجد روتين حالياً\nابدأ بإضافة روتين جديد',
      name: 'NoRoutines',
      desc: '',
      args: [],
    );
  }

  /// `حدث خطأ في تحميل البيانات`
  String get DataLoadError {
    return Intl.message(
      'حدث خطأ في تحميل البيانات',
      name: 'DataLoadError',
      desc: '',
      args: [],
    );
  }

  /// `اعادة المحاولة`
  String get Retry {
    return Intl.message('اعادة المحاولة', name: 'Retry', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
