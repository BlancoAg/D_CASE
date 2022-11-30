import 'package:flutter/material.dart';
import 'regster.dart';
import 'signIn.dart';

class FirebaseAuthDemo extends StatefulWidget {
  @override
  _FirebaseAuthDemoState createState() => _FirebaseAuthDemoState();
}

class _FirebaseAuthDemoState extends State<FirebaseAuthDemo> {
  @override
  Widget build(BuildContext context) {
    //return loginWidget(context);
    return new WillPopScope(
        onWillPop: () async => false, child: loginWidget(context));
  }

  Widget loginWidget(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        //title: Text("Unsolved Cases Files"),
        title: Text(AppLocalizations.of(context).translate('first_string')),
        automaticallyImplyLeading: false,
      ),
      */
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: OutlineButton(
              child: Text("Sign In"),
              onPressed: () => _pushPage(context, SignIn()),
            ),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),
          Container(
            child: OutlineButton(
              child: Text("Register"),
              onPressed: () => _pushPage(context, Register()),
            ),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
