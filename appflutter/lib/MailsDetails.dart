import 'package:appflutter/CSVHelperMails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

///Crea una pantalla de Chat que ya esta filtrado por contactoNombre
class MailsWidget extends StatefulWidget {
  MailsWidget({Key key, this.messages, this.idMail, this.remitente}) : super(key: key);

  final List<MailView> messages;
  final String idMail;
  final String remitente;

  @override
  _MailsWidgetState createState() => _MailsWidgetState();
}

class _MailsWidgetState extends State<MailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    MailView suspect = widget.messages.take(1).first;

    CSVHelperMails csvHelper = new CSVHelperMails();
    //cargamos base de datos

    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xffd93025),
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 120, 0),
                        child: Text(
                          suspect.asunto,
                          // style: FlutterFlowTheme.bodyText1.override(
                          //   fontFamily: 'Poppins',
                          //   color: Colors.white,
                          // ),
                        ),
                      ),
                      Container(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.width * 0.1,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          // child: Image(
                          //   image: AssetImage("images/images/" +
                          //       widget.characterSelected.id +
                          //       "_" +
                          //       widget.characterSelected.name +
                          //       ".png"),
                          //   fit: BoxFit.fill)
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
        body: FutureBuilder<List<MailDetails>>(
            future: csvHelper.listToFullChatView(),
            //buildeo con la data, cada clase con el snapshot
            builder: (context, AsyncSnapshot<List<MailDetails>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var mailsDetailsActualCharacter =
                    csvHelper.listToFullChatViewFiltered(snapshot.data, widget.idMail);

                //return Container();
                return SafeArea(
                    child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children:
                              createMsgRectangle(mailsDetailsActualCharacter, widget.remitente)),
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
  List<Widget> createMsgRectangle(List<MailDetails> mailsDetailsActualCharacter, String remitente) {
    List<Widget> list = new List<Widget>();
    String lastDate;
    String actualDate;
    bool saleMensaje = false;

    for (var mailDetail in mailsDetailsActualCharacter) {
      Widget widgetRectangle;
      //actualDate = DateFormat("dd/MM").format(DateTime.parse(msg.datetime));

      if (mailDetail.remitente == remitente.toLowerCase()) {
        saleMensaje = true;
      } else {
        saleMensaje = false;
      }
      widgetRectangle = createMailDetailWidget(mailDetail, saleMensaje, mailDetail.tieneImagen);

      list.add(widgetRectangle);

      //if (actualDate != lastDate) {
      //list.add(createDateBlock(msg));
      //lastDate = DateFormat("dd/MM").format(DateTime.parse(msg.datetime));
      //}
    }

    return list;
  }

  Widget createDateBlock(MailDetails item) {
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
            style: GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w500),
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

  Widget createMailDetailWidget(MailDetails item, bool saleMensaje, String tieneImagen) {
    String emojiEntra = "📥 ";
    String emojiSale = "📤 ";

    //if (tieneImagen != "No" && tieneImagen != null) createImageWidget(item.imgName);

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
                        Text(
                            (saleMensaje == true ? emojiEntra : emojiSale) +
                                item.remitente.toLowerCase(),
                            style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600)),
                        SizedBox(height: 8),
                        Text(item.mensaje,
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400)),
                        tieneImagen != "No" && tieneImagen != null
                            ? createImageWidget(item.imgName)
                            : Spacer(),
                        Container(
                          padding: EdgeInsets.all(6),
                        ),
                        Container(
                          //child: Flexible(
                          child: Text(item.datetime,
                              style: GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w400)),
                        ),
                        //padding: EdgeInsets.fromLTRB(180, 0, 0, 0))
                        //)
                      ],
                    ),
                    padding: EdgeInsets.all(5),
                  ))),
          Flexible(flex: 2, child: Container())
          // Flexible(
          //   child: Container(color: Colors.green, child: Text('dasdasd'))),
        ]));
  }

  Widget createEmisorWidget(MailDetails item) {
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
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400),
                            textAlign: TextAlign.left),
                        Container(
                          padding: EdgeInsets.all(6),
                        ),
                        Container(
                          child: Text(item.datetime,
                              style: GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w400)),
                          //padding: EdgeInsets.fromLTRB(180, 0, 0, 0),
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(5),
                  ))),
        ]));
  }

  Widget createImageWidget(String imgName) {
    return ListBody(children: [
      Container(
        padding: EdgeInsets.all(7),
      ),
      Container(
          child: Image(
        image: AssetImage('images/mails/' + imgName + '.png'),
        fit: BoxFit.cover,
      )),
      Container(
        padding: EdgeInsets.all(7),
      ),
    ]);
  }
}
