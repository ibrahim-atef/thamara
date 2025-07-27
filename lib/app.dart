import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';
import 'intl/l10n.dart';
import 'main_layout.dart';
import 'core/localization/cubit/language_cubit.dart';
import 'core/localization/cubit/language_state.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          final isRtl = state.locale.languageCode == 'ar';

          return MaterialApp(
            title: 'Thamara',
            debugShowCheckedModeBanner: false,
            theme:  AppTheme.lightTheme,
            localizationsDelegates: const [
               S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('ar'), Locale('en')],
            locale: state.locale,
            builder: (context, child) {
              return Directionality(
                textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                child: child!,
              );
            },
            home: const MainLayout(),
          );
        },
      ),
    );
  }
}
