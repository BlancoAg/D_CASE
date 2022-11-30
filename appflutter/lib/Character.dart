import 'package:appflutter/Mails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player_360/video_player_360.dart';
import 'DataBaseService.dart';
import 'Chats.dart';
import 'PaternLock2.dart';
import 'PcPhoneWidgetCalls.dart';
import "pin.dart";
import 'redsocial.dart';
import 'Constantes.dart';
import 'Home.dart';

class SuspectPageWidget extends StatefulWidget {
  SuspectPageWidget({
    Key key,
    this.characterSelected,
  }) : super(key: key);

  final Character characterSelected;

  @override
  _SuspectPageWidgetState createState() => _SuspectPageWidgetState();
}

class _SuspectPageWidgetState extends State<SuspectPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(backgroundcolor),
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, 0),
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                children: [
                  buttonBedroom(),
                  //aca va ternario
                  widget.characterSelected.pcIsUnlocked
                      ? childButtonsPC_Character(widget.characterSelected)
                      : buttonPcCharacter(widget.characterSelected),
                  //aca va ternario
                  widget.characterSelected.phoneIsUnlocked
                      ? childButtonsPhone_Character(widget.characterSelected)
                      : buttonPhoneCharacter(widget.characterSelected),
                ],
              ),
            ),
            Align(
              alignment: Alignment(0.91, -0.91),
              child: FloatingActionButton(
                child: Image(
                    image: AssetImage("images/images/" +
                        widget.characterSelected.id +
                        "_" +
                        widget.characterSelected.name +
                        ".png"),
                    fit: BoxFit.fill),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          myBackWidget(widget.characterSelected)));
                },
                backgroundColor: Color(appbarcolor),
                elevation: 10,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget myBackWidget(Character character) {
    return new Scaffold(
      // key: scaffoldKey,
      backgroundColor: Colors.brown.shade800,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(7, 50, 7, 50),
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage('assets/fondos/png_top_secret_folder.png'),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 30, 50),
                child: Container(
                  child: Image(
                      height: 3,
                      width: 4,
                      image: AssetImage("images/images/" +
                          widget.characterSelected.id +
                          "_" +
                          widget.characterSelected.name +
                          ".png")),
                ))
          ],
        ),
      ),
    );
  }

  Widget buttonPcCharacter(Character character) {
    return Padding(
        padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
        child: Container(
          width: 100,
          height: MediaQuery.of(context).size.height * 0.24,
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: GestureDetector(
                    child: Image(
                      image: AssetImage('assets/fondos/FondoPC.png'),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 1,
                      fit: BoxFit.cover,
                    ),
                    onTap: () {
                      print('tocando boton fondo pc ...');
                    },
                  )),
              Align(
                  alignment: Alignment(0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock, color: Colors.white, size: 40),
                      Text(" PC",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          ))
                    ],
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1,
                child: OutlineButton(
                  onPressed: () async {
                    if (character.id == "A" ||
                        character.id == "C" ||
                        character.id == "D" ||
                        character.id == "F" ||
                        character.id == "G") {
                      return Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => newBlockedScreenPCAndPhone(
                                  context, character.id, "PC")));
                    } else {
                      //CON PIN
                      return Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PinWidget(
                                  character: character,
                                  context: context,
                                  itemName: "PC")));
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }

  Widget buttonPhoneCharacter(Character character) {
    return Padding(
        padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
        child: Container(
          width: 100,
          height: MediaQuery.of(context).size.height * 0.24,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image(
                  image: AssetImage('assets/fondos/FondoPhone.png'),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                  alignment: Alignment(0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock, color: Colors.white, size: 40),
                      Text(" Phone",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          ))
                    ],
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1,
                child: OutlineButton(
                  onPressed: () {
                    //Joaquina
                    if (character.id == "C") {
                      return Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PatternLockWidget(character: character)));
                    } else if (character.id == "B" ||
                        character.id == "G" ||
                        character.id == "H") {
                      //CON PIN
                      return Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PinWidget(
                                  character: character,
                                  context: context,
                                  itemName: "Phone")));
                    } else {
                      return Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => newBlockedScreenPCAndPhone(
                                  context, character.id, "Phone")));
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }

  Widget buttonBedroom() {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
      child: Container(
        width: 100,
        height: MediaQuery.of(context).size.height * 0.24,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image(
                image: AssetImage('images/images/bedroom.jpeg'),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1,
                fit: BoxFit.cover,
              ),
            ),
            Align(
                alignment: Alignment(0, 0),
                child: Text(
                  (widget.characterSelected.name ?? " ") + "'s Bedroom",
                  style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 37)),
                )),
            //TextStyle(color: Colors.black, fontSize: 40, fontFamily: 'RobotoMono'))),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              child: OutlineButton(onPressed: () async {
                await VideoPlayer360.playVideoURL(
                    widget.characterSelected.urlVideo);
                // gameplayState.refresh();
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget childButtonsPC_Character(Character character) {
    return Padding(
        padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
        child: Container(
          width: 100,
          height: MediaQuery.of(context).size.height * 0.24,
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: GestureDetector(
                    child: Image(
                      image: AssetImage('assets/fondos/Notebook.png'),
                      width: MediaQuery.of(context).size.width * 0.55,
                      height: MediaQuery.of(context).size.height * 0.5,
                      fit: BoxFit.fill,
                    ),
                    onTap: () {
                      print('tocando boton fondo pc ...');
                    },
                  )),
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: OutlineButton(
                    child: Image(
                      image: AssetImage('assets/Nuevos iconos/espada.png'),
                      height: MediaQuery.of(context).size.height * 0.15,
                      fit: BoxFit.cover,
                    ),
                    borderSide: BorderSide(color: Colors.black, width: 3),
                    onPressed: () {
                      print(""); //funcion de sword
                    },
                  )),
                  Expanded(
                    child: OutlineButton(
                      child: Icon(Icons.mail,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.height * 0.165123),
                      borderSide: BorderSide(color: Colors.black, width: 3),
                      onPressed: () {
                        return Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MailsList(
                                      suspectID: character.id,
                                    )));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget childButtonsPhone_Character(Character character) {
    return Padding(
        padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
        child: Container(
          width: 100,
          height: MediaQuery.of(context).size.height * 0.24,
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: GestureDetector(
                    child: Image(
                      image: AssetImage('assets/fondos/FondoPhone.png'),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 1,
                      fit: BoxFit.cover,
                    ),
                    onTap: () {
                      print('tocando boton fondo phone ...');
                    },
                  )),
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: OutlineButton(
                    child: Image(
                      image: AssetImage('assets/Nuevos iconos/Wp.png'),
                      height: MediaQuery.of(context).size.height * 0.15,
                      fit: BoxFit.cover,
                    ),
                    borderSide: BorderSide(color: Colors.black, width: 3),
                    onPressed: () {
                      return Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MensajesWidget(
                                    suspectID: character.id,
                                  )));
                    },
                  )),
                  Expanded(
                      child: OutlineButton(
                    child: Image(
                      image: AssetImage('assets/Nuevos iconos/Ig.png'),
                      height: MediaQuery.of(context).size.height * 0.15,
                      fit: BoxFit.cover,
                    ),
                    borderSide: BorderSide(color: Colors.black, width: 3),
                    onPressed: () {
                      return Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RedesSocialWidget()));
                    },
                  )),
                ],
              ),
            ],
          ),
        ));
  }

  Widget traerSospechosos(BuildContext context, String letter) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.123,
          height: MediaQuery.of(context).size.width * 0.123,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: InkWell(
            child: Image(
                image: AssetImage("images/images/" +
                    letter +
                    "_" +
                    getRealName(letter) +
                    ".png")),
            onTap: () async {
              Character character = await getCharacter(letter);
              character.name = getRealName(letter);
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SuspectPageWidget(characterSelected: character),
                ),
              );
            },
          )),
    );
  }

  String getRealName(String value) {
    String realName = "";

    switch (value) {
      case "Home":
        realName = "Home";
        break;

      case "A":
        realName = "German";
        break;

      case "B":
        realName = "Leonel";
        break;

      case "C":
        realName = "Joaquina";
        break;

      case "D":
        realName = "Kevin";
        break;

      case "E":
        realName = "Ezequiel";
        break;

      case "F":
        realName = "Natan";
        break;

      case "G":
        realName = "Mauro";
        break;

      case "H":
        realName = "Abril";
        break;
    }

    return realName;
  }
}
