import 'package:appflutter/NewCSVHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

///Crea una pantalla de Chat que ya esta filtrado por contactoNombre
class MailContent extends StatefulWidget {
  MailContent({Key key, this.messages, this.name}) : super(key: key);

  final List<SuspectMessage> messages;
  final String name;

  @override
  _MailContentState createState() => _MailContentState();
}

class _MailContentState extends State<MailContent> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SuspectMessage suspect = widget.messages.take(1).first;
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xFF1BD25C),
          iconTheme: IconThemeData(color: Colors.white),
          automaticallyImplyLeading: true,
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
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
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(
                    suspect.contactoNombre,
                    // style: FlutterFlowTheme.bodyText1.override(
                    //   fontFamily: 'Poppins',
                    //   color: Colors.white,
                    // ),
                  ),
                )
              ],
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 4,
        ),
        body: SafeArea(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [createChat(widget.messages)]),
              )
            ],
          ),
        ));
  }

  ///Crea cada row con ListView de mensajes
  Widget createChat(List<SuspectMessage> message) {
    return SafeArea(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: createMsgRectangle(message)),
          )
        ],
      ),
    );
  }

  ///Crea un solo rectangulo que contiene el mensaje
  List<Widget> createMsgRectangle(List<SuspectMessage> messages) {
    List<Widget> list = new List<Widget>();

    for (var item in messages) {
      Widget widgetRectangle;

      if (item.tipoEmisorReceptor == "R") {
        widgetRectangle = createReceptorWidget(item);
      } else {
        widgetRectangle = createEmisorWidget(item);
      }

      list.add(widgetRectangle);
    }

    return list;
  }

  Widget createReceptorWidget(SuspectMessage item) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.black54,
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Text(
            item.mensajeTexto,
            // style: FlutterFlowTheme.bodyText1.override(
            //   fontFamily: 'Poppins',
            // ),
          ),
        ),
      ),
    );
  }

  Widget createEmisorWidget(SuspectMessage item) {
    return Padding(
      padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.green.shade400,
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Text(
            item.mensajeTexto,
            // style: FlutterFlowTheme.bodyText1.override(
            //   fontFamily: 'Poppins',
            // ),
          ),
        ),
      ),
    );
  }
}
