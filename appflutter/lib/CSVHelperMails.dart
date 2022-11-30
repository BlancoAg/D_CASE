import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class CSVHelperMails {
  Future<List<List<dynamic>>> loadingCsvData(String root) async {
    final myData = await rootBundle.loadString(root);
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
    return csvTable;
  }

  ///Se le pasa un CSV y trae un rawList de Chats de todos los Sospechosos
  Future<List<MailView>> listToMailView() async {
    var newList = await this.loadingCsvData("lib/DB/Mails.csv");

    List<MailView> listMessage = List<MailView>();
    List<String> stringList = List<String>();

    newList.removeAt(0);

    for (var line in newList) {
      for (var item in line) {
        //Aca agregamos cada celda del excel a una lista auxiliar
        //para luego mapearla a la clase y agregarla clase mensajes
        stringList.add(item.toString());
      }
      //Mapea cada celda en un atributo de la clase.
      listMessage.add(MailView.fromList(stringList));
      stringList.removeRange(0, stringList.length);
    }
    return listMessage;
  }

  ///Se le pasa un CSV y trae un rawList de Chats de todos los Sospechosos
  Future<List<MailDetails>> listToFullChatView() async {
    List<MailDetails> listMessage = List<MailDetails>();

    var newList = await this.loadingCsvData("lib/DB/MailsDetails.csv");
    List<String> stringList = List<String>();
    newList.removeAt(0);
    for (var line in newList) {
      for (var item in line) {
        //Aca agregamos cada celda del excel a una lista auxiliar
        //para luego mapearla a la clase y agregarla clase mensajes
        stringList.add(item.toString());
      }
      //Mapea cada celda en un atributo de la clase.
      listMessage.add(MailDetails.fromList(stringList));
      stringList.removeRange(0, stringList.length);
    }
    return listMessage;
  }

  ///devuelve una lista de chats filtrados por el contactoID (sospechoso)
  List<MailView> listToMailViewFiltered(List<MailView> listCSV, String contactoID) {
    List<MailView> listMessage = List<MailView>();
    String prev = "";
    //contactoID es el sospechoso que tocamos
    for (var suspect in listCSV) {
      if (suspect.idContactoChat == contactoID) {
        listMessage.add(suspect);
        prev = suspect.idContactoChat;
      }
    }
    return listMessage;
  }

  ///devuelve una lista de chats filtrados por el contactoID (sospechoso)
  List<MailDetails> listToFullChatViewFiltered(List<MailDetails> listCSV, String contactoID) {
    List<MailDetails> listMessage = List<MailDetails>();
    //contactoID es el sospechoso que tocamos
    for (MailDetails suspect in listCSV) {
      if (suspect.idMail == contactoID) {
        //MailDetails aux = new MailDetails(
        //   'idMail', 'asunto', 'mensaje', '', ' remitente', '1/1/2021', 'receptor');
        //aux.mensaje = suspect.mensaje;
        //aux.remitente = aux.mensaje = suspect.remitente;
        listMessage.add(suspect);
      }
    }
    return listMessage;
  }

  ///Obtiene una lista de chats filtrados por el nombre de contacto
  List<MailView> listToMailViewFilteredByContactoNombre(
      List<MailView> list, String contactoNombre) {
    List<MailView> listMessage = List<MailView>();
    for (var suspect in list) {
      if (suspect.escritor == contactoNombre) {
        listMessage.add(suspect);
      }
    }
    return listMessage;
  }
}

class SuspectMessage {
  //Personaje,Nombre Personaje,Contacto/Nombre,Contacto/Id,Mensaje/Texto,Mensaje/TipoEmisorReceptor,Mensaje/Hora
  String personaje;
  String nombrePersonaje;
  String contactoNombre;
  String contactoID;
  String mensajeTexto;
  String tipoEmisorReceptor;
  String hora;
  SuspectMessage(this.personaje, this.nombrePersonaje, this.contactoNombre, this.contactoID,
      this.mensajeTexto, this.tipoEmisorReceptor, this.hora);
  SuspectMessage.fromList(List<String> items)
      : this(items[0], items[1], items[2], items[3], items[4], items[5], items[6]);
  @override
  String toString() {
    return 'SuspectMessage{personaje: $personaje, nombrePersonaje: $nombrePersonaje, contactoNombre: $contactoNombre, contactoID: $mensajeTexto, tipoEmisorReceptor: $tipoEmisorReceptor, hora: $hora}';
  }
}

class MailDetails {
  String idMail;
  String asunto;
  String mensaje;
  String imagen;
  String remitente;
  String datetime;
  String receptor;
  String imgName;
  String tieneImagen;

  MailDetails(this.idMail, this.asunto, this.mensaje, this.imagen,
      this.remitente, this.datetime, this.receptor, this.tieneImagen, this.imgName);
  MailDetails.fromList(List<String> items)
      : this(items[0], items[1], items[2], items[3], items[4], items[5],
            items[6], items[7], items[8]);
  @override
  String toString() {
    return 'MailDetails{idMail: $idMail, asunto: $asunto, mensaje: $mensaje, imagen: $imagen, remitente: $remitente, datetime: $datetime, receptor: $receptor, tieneImagen: $tieneImagen, imgName: $imgName}';
  }
}

class MailView {
  String idContactoChat;
  String idMail;
  String asunto;
  String mensajePrev;
  String escritor;
  String datetime;
  MailView(this.idContactoChat, this.idMail, this.asunto, this.mensajePrev, this.escritor,
      this.datetime);
  MailView.fromList(List<String> items)
      : this(items[0], items[1], items[2], items[3], items[4], items[5]);
  @override
  String toString() {
    return 'MailView{idContactoChat: $idContactoChat, idMail: $idMail, asunto: $asunto, mensajePrev: $mensajePrev, escritor: $escritor, datetime: $datetime}';
  }
}
