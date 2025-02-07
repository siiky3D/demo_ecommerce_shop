import 'package:demo_ecommerce_shop/src/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('th')],
        path: 'assets/langs',
        fallbackLocale: Locale('en', 'US'),
        child: const MyApp(),
      ),
    ),
  );
}
