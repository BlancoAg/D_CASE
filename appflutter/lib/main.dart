import 'package:firebase_core/firebase_core.dart';
import 'Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Splash.dart';
//Localization
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //FirebaseAuth _auth = FirebaseAuth.instance;
  final Auth _auth = Auth();

  final bool isLogged = await _auth.isLogged();

  final MyApp myApp = MyApp(initialRoute: isLogged ? '/home' : '/auth', user: _auth.userAuth);
  runApp(myApp);
}

class Auth {
  User userAuth;
  Future<bool> isLogged() async {
    try {
      final User user = FirebaseAuth.instance.currentUser;
      userAuth = user;
      print('CURRENT USER ' + userAuth.toString());
      return user != null;
    } catch (e) {
      return false;
    }
  }
}

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuthDemo(),
    );
  }
}*/

class MyApp extends StatelessWidget {
  final String initialRoute;
  final User user;

  MyApp({this.initialRoute, this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // List all of the app's supported locales here
      supportedLocales: [
        Locale('en', 'US'),
        Locale('es', 'ES'),
      ],
      // These delegates make sure that the localization data for the proper language is loaded
      localizationsDelegates: [
        // THIS CLASS WILL BE ADDED LATER
        // A class which loads the translations from JSON files
        AppLocalizations.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
      home: FirebaseAuthDemo(), //HouseMain(),
      initialRoute: initialRoute,
      routes: {
        '/auth': (context) => FirebaseAuthDemo(),
        '/home': (context) => MainPage(user: user),
        //'/settings': (context) => SettingsPage(),
      },
    );
  }
}
