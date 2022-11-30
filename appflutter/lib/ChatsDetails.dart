import 'package:appflutter/NewCSVHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

///Crea una pantalla de Chat que ya esta filtrado por contactoNombre
class ChatWidget extends StatefulWidget {
  ChatWidget({Key key, this.messages, this.idChat, this.escritor}) : super(key: key);

  final List<SimpleChatView> messages;
  final String idChat;
  final String escritor;

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SimpleChatView suspect = widget.messages.take(1).first;

    CSVHelper csvHelper = new CSVHelper();
    //cargamos base de datos

    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 10, 93, 85),
          iconTheme: IconThemeData(color: Colors.white),
          automaticallyImplyLeading: true,
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 300, 0),
                  child: Row(
                    children: [
                      Container(
                        child: InkWell(
                          onTap: () async {
                            // await Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => RedesSocialWidget(),
                            //   ),
                            // );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            height: MediaQuery.of(context).size.width * 0.1,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              'https://picsum.photos/seed/749/600',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 140, 0),
                        child: Text(
                          suspect.chatNombre,
                          // style: FlutterFlowTheme.bodyText1.override(
                          //   fontFamily: 'Poppins',
                          //   color: Colors.white,
                          // ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 4,
        ),
        body: FutureBuilder<List<FullChatView>>(
            future: csvHelper.listToFullChatView(),
            //buildeo con la data, cada clase con el snapshot
            builder: (context, AsyncSnapshot<List<FullChatView>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var listFilteredNoDuplicated =
                    csvHelper.listToFullChatViewFiltered(snapshot.data, widget.idChat);

                return SafeArea(
                    child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: createMsgRectangle(listFilteredNoDuplicated, widget.escritor)),
                    ),
                  ],
                ));
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey.shade300,
                  ),
                );
              }
            }));
  }

  ///Crea un solo rectangulo que contiene el mensaje
  List<Widget> createMsgRectangle(List<FullChatView> messages, String escritor) {
    List<Widget> list = new List<Widget>();
    String lastDate;
    String actualDate;
    for (var item in messages) {
      Widget widgetRectangle;
      actualDate = DateFormat("dd/MM").format(DateTime.parse(item.datetime));

      if (item.escritor != escritor) {
        widgetRectangle = createReceptorWidget(item);
      } else {
        widgetRectangle = createEmisorWidget(item);
      }
      list.add(widgetRectangle);

      if (actualDate != lastDate) {
        list.add(createDateBlock(item));
        lastDate = DateFormat("dd/MM").format(DateTime.parse(item.datetime));
      }
    }

    return list;
  }

  Widget createDateBlock(FullChatView item) {
    return new Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      //decoration: BoxDecoration(
      //  color: Colors.white54, borderRadius: new BorderRadius.all(new Radius.circular(10))),
      child: Row(children: [
        Flexible(
          flex: 6,
          child: Container(),
        ),
        Flexible(
          //fit: FlexFit.tight,
          flex: 4,
          child: Text(
            DateFormat("dd/MM").format(DateTime.parse(item.datetime)),
            style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w300),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 4,
          child: Container(),
        ),
      ]),
    );
  }

  Widget createReceptorWidget(FullChatView item) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(children: [
          Flexible(
            flex: 2,
            child: Container(),
          ),
          Flexible(
              flex: 30,
              child: Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: new BorderRadius.all(new Radius.circular(10))),
                  child: Padding(
                    child: ListBody(
                      children: [
                        Text(item.mensaje,
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400)),
                        Container(
                          padding: EdgeInsets.all(6),
                        ),
                        Container(
                          //child: Flexible(
                          child: Text(DateFormat("hh:mm").format(DateTime.parse(item.datetime)),
                              style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w300)),
                        ),
                        //padding: EdgeInsets.fromLTRB(180, 0, 0, 0))
                        //)
                      ],
                    ),
                    padding: EdgeInsets.all(5),
                  ))),
          Flexible(flex: 10, child: Container())
          // Flexible(
          //   child: Container(color: Colors.green, child: Text('dasdasd'))),
        ]));
  }

  Widget createEmisorWidget(FullChatView item) {
    return Container(
        padding: EdgeInsets.fromLTRB(100, 10, 20, 0),
        child: Row(children: [
          Flexible(
              flex: 10,
              child: Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 217, 247, 193),
                      borderRadius: new BorderRadius.all(new Radius.circular(10))),
                  child: Padding(
                    child: ListBody(
                      children: [
                        Text(item.mensaje,
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400)),
                        Container(
                          padding: EdgeInsets.all(6),
                        ),
                        Container(
                          child: Text(DateFormat("hh:mm").format(DateTime.parse(item.datetime)),
                              style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w300)),
                          //padding: EdgeInsets.fromLTRB(180, 0, 0, 0),
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(5),
                  ))),
        ]));
  }
}
