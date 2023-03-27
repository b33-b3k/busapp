import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yatri_app/components/tripHistory.dart';
import 'package:yatri_app/screens/homepage.dart';
import 'package:yatri_app/screens/login.dart';
import 'package:yatri_app/screens/profile.dart';
import 'package:yatri_app/screens/register.dart';
import 'package:yatri_app/screens/splashscreen.dart';
import 'package:yatri_app/screens/welcome.dart';
import 'components/appBar.dart';
import 'firebase_options.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'screens/mapApp.dart';
import 'components/textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import './screens/login.dart';
import 'screens/forgotpass.dart';
import 'screens/verify.dart';
import 'components/googleSignIn.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(
      child: MaterialApp(
    home: MapApp(),
    routes: {
      '/mapApp': (context) => MapApp(),
      '/forgotPass': (context) => ForgotPass(),
      '/signUp': (context) => SignUp(),
      '/login': (context) => LoginPage(),
      '/verify': (context) => Verify(),
      '/welcome': (context) => WelcomePage(),
      '/profile': (context) => ProfileScreen()

      //verify null
    },
    debugShowCheckedModeBanner: false,
  )));
}

var emailController = TextEditingController();
var passwordController = TextEditingController();
var userNameController = TextEditingController();
var confirmPassController = TextEditingController();
final counterStateProvider = StateProvider<int>((ref) {
  return 0;
}); //

