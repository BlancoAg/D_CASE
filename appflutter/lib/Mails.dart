import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ChatsDetails.dart';
import 'MailContent.dart';
import 'MailsDetails.dart';
import 'CSVHelperMails.dart';
import 'package:intl/intl.dart';

class MailsList extends StatefulWidget {
  MailsList({Key key, this.suspectID}) : super(key: key);

  final String suspectID;

  @override
  MailsListState createState() => MailsListState();
}

class MailsListState extends State<MailsList> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<dynamic> data;
    CSVHelperMails csvHelper = new CSVHelperMails();
    //cargamos base de datos

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xffd93025),
          automaticallyImplyLeading: true,
          title: Text(
            'Mails',
            // style: FlutterFlowTheme.title2.override(
            //   fontFamily: 'Poppins',
            // ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 4,
        ),
        //se crea un body future builder con la clase
        body: FutureBuilder<List<MailView>>(
          //Obtengo el CSV con toda la Data Raw
          future: csvHelper.listToMailView(),
          //buildeo con la data, cada clase con el snapshot
          builder: (context, AsyncSnapshot<List<MailView>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var listFilteredNoDuplicated =
                  csvHelper.listToMailViewFiltered(snapshot.data, widget.suspectID);

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
                              children:
                                  listWidgetsSuspects //Ver como mandarle el nombre de contacto
                              ),
                        )
                      ],
                    ))
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey.shade300,
                ),
              );
            }
          },
        ));
  }

  ///Crea la lista de widgets de contactos con sus respectivas funcionalidad.
  List<Widget> listWidgetsSuspect(List<MailView> suspectsNoDuplicated, List<MailView> suspectRAW) {
    List<Widget> widgetList = new List<Widget>();

    for (var item in suspectsNoDuplicated) {
      widgetList.add(contactFromList(item, suspectRAW));
    }

    return widgetList;
  }

  ///Crea 1 widget contacto con su funcionalidad
  Widget contactFromList(MailView contacto, List<MailView> suspectRAW) {
    CSVHelperMails csvHelper = new CSVHelperMails();
    List<MailView> listFiltered =
        csvHelper.listToMailViewFilteredByContactoNombre(suspectRAW, contacto.escritor);

    return InkWell(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            pictureChat(contacto),
            Expanded(
              child: dataChat(contacto),
            )
          ],
        ),
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MailsWidget(
                      messages: listFiltered,
                      idMail: contacto.idMail,
                      remitente: contacto.escritor)));
        });
  }

  asdasD(String date) {
    return date;
  }

  Widget pictureChat(MailView contacto) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 1, 1, 1),
      child: Container(
        width: 70,
        height: 100,
        alignment: Alignment(0, 0),
        child: contacto.escritor.length > 0
            ? letterCircle(contacto.escritor.substring(0, 1).toUpperCase())
            : letterCircle("-"),
      ),
    );
  }

  Widget letterCircle(String idContactoChat) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.width * 0.2,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        shape: BoxShape.circle,
      ),
      child: Align(
        alignment: AlignmentDirectional(0, 0),
        child: Text(
          idContactoChat,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
    );
  }
// Container(
//           child: Text("L"),
//             width: MediaQuery.of(context).size.width * 0.2,
//             height: MediaQuery.of(context).size.width * 0.2,
//             clipBehavior: Clip.antiAlias,
//             decoration: BoxDecoration(
//               color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
//               shape: BoxShape.circle,
//             ),
//         )

  Widget dataChat(MailView contacto) {
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
              //ASUNTO
              Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  strutStyle: StrutStyle(fontSize: 2.0),
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 19), text: contacto.asunto),
                ),
              ),
              // // DATETIME
              // Flexible(
              //   child:RichText(
              //     overflow: TextOverflow.ellipsis,
              //     strutStyle: StrutStyle(fontSize: 2.0),
              //     text: TextSpan(
              //         style: TextStyle(color: Colors.black, fontSize: 16),
              //         text: contacto.datetime.substring(0,5)),
              // )),
              SizedBox(width: 10),
            ],
          ),
        ),
        Padding(
          //MensajeTextoPreview
          padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
          child: Text(
            contacto.escritor,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            maxLines: 1,
          ),
        ),
        Padding(
          //MensajeTextoPreview
          padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
          child: Text(
            contacto.mensajePrev,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            maxLines: 1,
          ),
        )
      ],
    );
  }
}
