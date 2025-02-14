import 'package:demo_app/firebase_options.dart';
import 'package:demo_app/src/app_bootstrap.dart';
import 'package:demo_app/src/app_bootstrap_firebase.dart';
import 'package:demo_app/src/app_bootstrap_stripe.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final appBootstrap = AppBootstrap();
  await appBootstrap.setupStripe();
  final container = await appBootstrap.createFirebaseProviderContainer();
  final root = appBootstrap.createRootWidget(container: container);
  runApp(root);
}
