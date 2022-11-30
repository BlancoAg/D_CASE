//import 'dart:js';
import 'package:appflutter/Constantes.dart';
import 'package:flutter/material.dart';
import 'DataBaseService.dart';
import 'Home.dart';

Widget newBlockedScreenPCAndPhone(BuildContext context, String characterName, String itemName) {
  final TextEditingController _passwordController = TextEditingController();

  return Scaffold(
      backgroundColor: Color(backgroundcolor),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            itemName == "PC"
                ? new Text(
                    "INGRESE LA CONTRASEÑA DE LA PC",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                : new Text("INGRESE LA CONTRASEÑA DEL CELULAR",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
            new TextField(
              style: TextStyle(color: Colors.white, fontSize: 15),
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  hintText: "TYPE PASSWORD HERE",
                  hintStyle: TextStyle(color: Colors.grey.shade200, fontSize: 15)),
              controller: _passwordController,
            ),
            new FlatButton(
              child: new Text(
                "UNLOCK",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              color: Colors.pink,
              onPressed: () async {
                bool result = await getPhoneOrPcPasswordByKey(
                    _passwordController.text, itemName, characterName);

                // gameplayState.gameplayAppBar.characterSelected =
                //     await getCharacterPCandPhoneSate(characterName);

                newPopUpDesbloqueadoStatus(
                    context,
                    result ? "¡" + itemName + " " + "desbloqueado!" : "¡La contraseña es inválida!",
                    result,
                    itemName,
                    characterName);

                //Navigator.pop(context);
              },
            )
          ],
        ),
      ));
}

newPopUpDesbloqueadoStatus(BuildContext context, String mensaje, bool hasUnblocked, String itemName,
    String characterName) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            mensaje,
            style: hasUnblocked ? TextStyle(color: Colors.black) : TextStyle(color: Colors.white),
          ),
          backgroundColor: hasUnblocked ? Colors.green : Colors.red,
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text(
                'Aceptar',
                style:
                    hasUnblocked ? TextStyle(color: Colors.black) : TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (hasUnblocked) {
                  final char = await getCharacter(characterName);

                  return Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomeNuevoWidget(
                            characterSelected: char, indexBody: 1,
                            //// characterSelected: char,
                          )));
                }
                Navigator.of(context).pop();

                //Navigator.of(context).push(MaterialPageRoute(
                //    builder: (context) => MyPatternLock(
                //          key: new Key("mykey"),
                //          title: "mytitle",
                //          characterName: characterName,
                //        )));
              },
            )
          ],
        );
      });
}
