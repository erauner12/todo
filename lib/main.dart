import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:todo/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/core/constants/storage_value.dart';
import 'package:todo/core/theme/theme.dart';
import 'package:todo/core/util/storage.dart';
import 'package:todo/data/models/attachment_model.dart';
import 'package:todo/data/models/comment_model.dart';
import 'package:todo/data/models/due_model.dart';
import 'package:todo/data/models/duration_model.dart';
import 'package:todo/data/models/project_model_response.dart';
import 'package:todo/data/models/sync_model.dart';
import 'package:todo/data/sync_manager.dart';
import 'package:todo/presentation/route/app_router.dart';

import 'core/di/di.dart';
import 'data/models/task_model_response.dart';

final storage = GetIt.I<Storage>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelResponseAdapter());
  Hive.registerAdapter(ProjectModelResponseAdapter());
  Hive.registerAdapter(SyncOperationAdapter());
  Hive.registerAdapter(DurationModelAdapter());
  Hive.registerAdapter(DueModelAdapter());
  Hive.registerAdapter(AttachmentModelAdapter());
  Hive.registerAdapter(CommentModelAdapter());
  const token = '396cfbb60d2860647d5451920dc1962eb2505c01';
  await setupLocator(token);
  bool isDarkTheme = await storage.getData<bool>(StorageKey.IS_DARK_THEME) ?? false;
  String? languageCode = await storage.getLanguage();
  final syncManager = getIt<SyncManager>();
  syncManager.monitorConnection();
  runApp(MyApp(
    isDarkTheme: isDarkTheme,
    initialLocale: languageCode != null ? Locale(languageCode) : const Locale('en'),
  ));
}

class MyApp extends StatefulWidget {
  final bool isDarkTheme;
  final Locale initialLocale;

  MyApp({super.key, required this.isDarkTheme, required this.initialLocale});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppRouter appRouter = GetIt.I<AppRouter>();
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale;
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: widget.isDarkTheme ? darkTheme : lightTheme,
      builder: (_, myTheme) {
        return MaterialApp.router(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: myTheme,
          locale: _locale,
          supportedLocales: const [
            Locale('en'), // English
            Locale('de'), // German
          ],
          routerConfig: appRouter.router,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}