import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'NewCSVHelper.dart';
import 'package:csv/csv.dart';
import 'ChatsDetails.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class MensajesWidget extends StatefulWidget {
  MensajesWidget({Key key, this.suspectID}) : super(key: key);

  final String suspectID;

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<MensajesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<dynamic> data;
    CSVHelper csvHelper = new CSVHelper();
    //cargamos base de datos

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 10, 93, 85),
          automaticallyImplyLeading: true,
          title: Text(
            'Qué Onda App',
            // style: FlutterFlowTheme.title2.override(
            //   fontFamily: 'Poppins',
            // ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 4,
        ),
        //se crea un body future builder con la clase
        body: FutureBuilder<List<SimpleChatView>>(
          //Obtengo el CSV con toda la Data Raw
          future: csvHelper.listToSimpleChatView(),
          //buildeo con la data, cada clase con el snapshot
          builder: (context, AsyncSnapshot<List<SimpleChatView>> snapshot) {
            var listFilteredNoDuplicated =
                csvHelper.listToSimpleChatViewFiltered(snapshot.data, widget.suspectID);

            //csvHelper.listToSuspectMessageFilteredByContactoNombre(snapshot.data, widget.contactoNombre)

            var listWidgetsSuspects = listWidgetsSuspect(listFilteredNoDuplicated, snapshot.data);

            return snapshot.hasData
                ? SafeArea(
                    child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: ListView(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            //Crea el listview de los chats.
                            children: listWidgetsSuspects //Ver como mandarle el nombre de contacto
                            ),
                      )
                    ],
                  ))
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ));
  }

  ///Crea la lista de widgets de contactos con sus respectivas funcionalidad.
  List<Widget> listWidgetsSuspect(
      List<SimpleChatView> suspectsNoDuplicated, List<SimpleChatView> suspectRAW) {
    List<Widget> widgetList = new List<Widget>();

    for (var item in suspectsNoDuplicated) {
      widgetList.add(contactFromList(item, suspectsNoDuplicated, suspectRAW));
    }

    return widgetList;
  }

  ///Crea 1 widget contacto con su funcionalidad
  Widget contactFromList(SimpleChatView contacto, List<SimpleChatView> listNoDuplicated,
      List<SimpleChatView> suspectRAW) {
    CSVHelper csvHelper = new CSVHelper();
    var listFiltered =
        csvHelper.listToSimpleChatViewFilteredByContactoNombre(suspectRAW, contacto.escritor);

    return InkWell(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            pictureChat(listFiltered, contacto),
            Expanded(
              child: dataChat(contacto),
            )
          ],
        ),
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatWidget(
                      messages: listFiltered,
                      idChat: contacto.idChat,
                      escritor: contacto.idContactoChat)));
        });
  }

  asdasD(String date) {
    return date;
  }

  Widget pictureChat(List<SimpleChatView> listFiltered, SimpleChatView contacto) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 1, 1, 1),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          // color: FlutterFlowTheme.tertiaryColor,
          shape: BoxShape.rectangle,
        ),
        alignment: Alignment(0, 0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.width * 0.2,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.network(
            //fotoperfil
            'https://picsum.photos/seed/568/600',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget dataChat(SimpleChatView contacto) {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // physics: const ClampingScrollPhysics(),
      children: [
        Padding(
          //NombreContacto
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Row(
            children: [
              Text(contacto.chatNombre,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500)),
              Spacer(),
              Text(
                DateFormat("dd/MM - hh:mm").format(DateTime.parse(contacto.datetime)),
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
        Padding(
          //MensajeTextoPreview
          padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
          child: Text(
            contacto.mensajeShort,
            style: TextStyle(fontSize: 16),
            maxLines: 1,
          ),
        )
      ],
    );
  }
}
