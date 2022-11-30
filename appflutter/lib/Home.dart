import 'package:appflutter/DataBaseService.dart';
import 'package:flutter/material.dart';
import 'BodyHome.dart';
import 'Character.dart';
import 'Constantes.dart';
import 'DataBaseService.dart';

// ignore: must_be_immutable
class HomeNuevoWidget extends StatefulWidget {
  //Crear un Las character selected por parametro.
  HomeNuevoWidget({Key key, this.characterSelected, this.indexBody})
      : super(key: key);

  Character characterSelected;
  int indexBody;

  @override
  _HomeNuevoWidgetState createState() => _HomeNuevoWidgetState();
}

class _HomeNuevoWidgetState extends State<HomeNuevoWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String characterSelected = "A";
  Character character = new Character();
  SuspectPageWidget script = new SuspectPageWidget();

  void _onItemTapped(int index) async {
    //DESPUES BORRAR
    if (index == 2) {
      await saveInitialCharactersUser();
      widget.indexBody = 0;
    }
    //DESPUES BORRAR

    widget.characterSelected = await getCharacter(characterSelected);
    setState(() {
      widget.indexBody = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Hacer un get real de la BD

    List<Widget> _children = [
      BodyHomeWidget(), //BODY HOME
      SuspectPageWidget(
        characterSelected: widget.characterSelected,
      ),
      //DESPUES BORRAR
      BodyHomeWidget(),
      //DESPUES BORRAR
    ];

    //Si viene en 1 el widget.indexBody va al Character, sino va a home (es index 0)
    // if (widget.indexBody == 1) _currentIndex = widget.indexBody;

    return Scaffold(
        key: scaffoldKey,
        appBar: (widget.indexBody == 0
            ? null
            : appbar()), //si es character poner appbar, sino sacarlo
        backgroundColor: Color(backgroundcolor), //0xOPACIDAD + HEX
        body: _children[widget.indexBody],
        bottomNavigationBar: navigatorBottomBar());
  }

  Widget navigatorBottomBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Characters',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.restore,
            color: Colors.red,
          ),
          label: 'Restore Game',
        ),
      ],
      currentIndex: widget.indexBody,
      backgroundColor: Colors.black,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }

  appbar() {
    return AppBar(
      backgroundColor: Color(appbarcolor),
      iconTheme: IconThemeData(color: Colors.white),
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.fromLTRB(2, 0, 0, 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              // FaIcon(
              //   FontAwesomeIcons.home,
              //   color: Colors.white,
              //   size: 30,
              // ),
              traerSospechosos(context, "A"),
              traerSospechosos(context, "B"),
              traerSospechosos(context, "C"),
              traerSospechosos(context, "D"),
              traerSospechosos(context, "E"),
              traerSospechosos(context, "F"),
              traerSospechosos(context, "G"),
              traerSospechosos(context, "H"),
            ],
          ),
        ),
      ),
      actions: [],
      centerTitle: true,
      elevation: 4,
    );
  }

  Widget traerSospechosos(BuildContext context, String letter) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.123,
        height: MediaQuery.of(context).size.width * 0.123,
        clipBehavior: Clip.antiAlias,
        decoration: letter == widget.characterSelected.id
            ? BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Colors.orange.shade600,
              )
            : BoxDecoration(
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
            //Character character = await getCharacterPCandPhoneState(letter);
            characterSelected = letter;
            _onItemTapped(1);
            //character.name = getRealName(letter);
            //await Navigator.push(
            //  context,
            //  MaterialPageRoute(
            //    builder: (context) => HomeNuevoWidget(
            //      characterSelected: character,
            //      indexBody: 1,
            //    ),
            //  ),
            //);
          },
        ),
      ),
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
