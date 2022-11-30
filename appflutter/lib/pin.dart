import 'package:flutter_screen_lock/functions.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/DataBaseService.dart';
import 'Character.dart';
import 'Home.dart';
import 'Constantes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PinWidget(character: new Character()),
      ),
    );
  }
}

class PinWidget extends StatefulWidget {
  PinWidget({this.character, this.context, this.itemName});

  final Character character;
  final BuildContext context;
  final String itemName;

  @override
  _PinWidgetState createState() => _PinWidgetState();
}

class _PinWidgetState extends State<PinWidget> {
  List<int> pattern;
  @override
  Widget build(BuildContext context) {
    Future<String> str = getCorrectString(widget.character.id, widget.itemName);
    return Scaffold(
        backgroundColor: Color(backgroundcolor),
        body: SizedBox(
            width: double.infinity,
            child: FutureBuilder(
                future: str,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all<TextStyle>(
                              TextStyle(fontSize: 18)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.pink),
                        ),
                        onPressed: () => screenLock<void>(
                            context: context,
                            title: Text('Introduzca la contraseña'),
                            digits: snapshot.data.length,
                            confirmTitle: Text('Confirmá la contraseña'),
                            correctString: snapshot.data,
                            didUnlocked: () => exitPinScreen(
                                widget.character.id, widget.itemName, context)),
                        child: Text('Insert the ' +
                            widget.itemName +
                            ' PIN' +
                            ' for: ' +
                            widget.character.name),
                      ),
                    ],
                  );
                })));
  }

  void exitPinScreen(
      String characterName, String itemName, BuildContext context) async {
    updateCharacterPhoneOrPcStatusInUser(characterName, itemName);
    // gameplayState.refreshAppBar(characterName);
    // gameplayState.refreshBody(itemName);
    Character char = await getCharacter(characterName);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomeNuevoWidget(
              characterSelected: char, indexBody: 1,
              //// characterSelected: char,
            )));
  }
}
