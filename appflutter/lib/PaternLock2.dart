import 'package:appflutter/Character.dart';
import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:appflutter/DataBaseService.dart';

import 'Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurple.shade900,
        body: PatternLockWidget(character: new Character()),
      ),
    );
  }
}

class PatternLockWidget extends StatefulWidget {
  PatternLockWidget({this.character});
  final Character character;

  @override
  _PatternLockWidgetState createState() => _PatternLockWidgetState();
}

class _PatternLockWidgetState extends State<PatternLockWidget> {
  List<int> pattern;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurple.shade700,
        body: PatternLock(
          // color of selected points.
          selectedColor: Colors.deepPurple.shade100,
          // radius of points.
          pointRadius: 8,
          // whether show user's input and highlight selected points.
          showInput: true,
          // count of points horizontally and vertically.
          dimension: 3,
          // padding of points area relative to distance between points.
          relativePadding: 0.7,
          // needed distance from input to point to select point.
          selectThreshold: 25,
          // whether fill points.
          fillPoints: true,
          // callback that called when user's input complete. Called if user selected one or more points.
          onInputComplete: (List<int> input) async {
            var theCode = input.join("");

            //Resultasdo de pin, si es correcta el pin ingresado, setea en true en la db
            bool result = await checkPatternInDatabase(theCode, widget.character.id);

            if (result) {
              final newChar = await getCharacter(widget.character.id);
              //Navigator.of(context).pop();
              return showDialog(
                  context: context,
                  child: AlertDialog(
                    backgroundColor: Colors.green.shade700,
                    title: Text("¡CORRECTO!"),
                    actions: <Widget>[
                      MaterialButton(
                        color: Colors.green,
                        elevation: 5.0,
                        child: Text('Continuar...'),
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomeNuevoWidget(
                                    characterSelected: newChar, indexBody: 1,
                                    //// characterSelected: char,
                                  )));
                        },
                      )
                    ],
                  ));
            } else {
              return showDialog(
                  context: context,
                  child: AlertDialog(
                    backgroundColor: Colors.red.shade600,
                    title: Text("¡INCORRECTO!"),
                    actions: <Widget>[
                      MaterialButton(
                        color: Colors.red,
                        elevation: 5.0,
                        child: Text('Intentá otra vez...'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ));
            }
          },
        ),
      ),
    );
  }
}
