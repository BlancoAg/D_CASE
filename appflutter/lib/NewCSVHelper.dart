import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class CSVHelper {
  Future<List<List<dynamic>>> loadingCsvData(String root) async {
    final myData = await rootBundle.loadString(root);
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
    return csvTable;
  }

  ///Se le pasa un CSV y trae un rawList de Chats de todos los Sospechosos
  Future<List<SimpleChatView>> listToSimpleChatView() async {
    var newList = await this.loadingCsvData("lib/DB/shortChatDB.csv");

    List<SimpleChatView> listMessage = List<SimpleChatView>();
    List<String> stringList = List<String>();

    newList.removeAt(0);

    for (var line in newList) {
      for (var item in line) {
        //Aca agregamos cada celda del excel a una lista auxiliar
        //para luego mapearla a la clase y agregarla clase mensajes
        stringList.add(item.toString());
      }
      //Mapea cada celda en un atributo de la clase.
      listMessage.add(SimpleChatView.fromList(stringList));
      stringList.removeRange(0, stringList.length);
    }
    return listMessage;
  }

  ///Se le pasa un CSV y trae un rawList de Chats de todos los Sospechosos
  Future<List<FullChatView>> listToFullChatView() async {
    List<FullChatView> listMessage = List<FullChatView>();

    var newList = await this.loadingCsvData("lib/DB/fullChatDB.csv");
    List<String> stringList = List<String>();
    newList.removeAt(0);
    for (var line in newList) {
      for (var item in line) {
        //Aca agregamos cada celda del excel a una lista auxiliar
        //para luego mapearla a la clase y agregarla clase mensajes
        stringList.add(item.toString());
      }
      //Mapea cada celda en un atributo de la clase.
      listMessage.add(FullChatView.fromList(stringList));
      stringList.removeRange(0, stringList.length);
    }
    return listMessage;
  }

  ///devuelve una lista de chats filtrados por el contactoID (sospechoso)
  List<SimpleChatView> listToSimpleChatViewFiltered(
      List<SimpleChatView> listCSV, String contactoID) {
    List<SimpleChatView> listMessage = List<SimpleChatView>();
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
  List<FullChatView> listToFullChatViewFiltered(
      List<FullChatView> listCSV, String contactoID) {
    List<FullChatView> listMessage = List<FullChatView>();
    String prev = "";
    //contactoID es el sospechoso que tocamos
    for (var suspect in listCSV) {
      if (suspect.idChat == contactoID) {
      listMessage.add(suspect);
      prev = suspect.escritor;
      }
    }
    return listMessage;
  }

  ///Obtiene una lista de chats filtrados por el nombre de contacto
  List<SimpleChatView> listToSimpleChatViewFilteredByContactoNombre(
      List<SimpleChatView> list, String contactoNombre) {
    List<SimpleChatView> listMessage = List<SimpleChatView>();
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
  SuspectMessage(this.personaje, this.nombrePersonaje, this.contactoNombre,
      this.contactoID, this.mensajeTexto, this.tipoEmisorReceptor, this.hora);
  SuspectMessage.fromList(List<String> items)
      : this(items[0], items[1], items[2], items[3], items[4], items[5],
            items[6]);
  @override
  String toString() {
    return 'SuspectMessage{personaje: $personaje, nombrePersonaje: $nombrePersonaje, contactoNombre: $contactoNombre, contactoID: $mensajeTexto, tipoEmisorReceptor: $tipoEmisorReceptor, hora: $hora}';
  }
}

class FullChatView {
  String idChat;
  String esGrupo;
  String chatNombre;
  String mensaje;
  String escritor;
  String datetime;
  FullChatView(this.idChat, this.esGrupo, this.chatNombre, this.mensaje,
      this.escritor, this.datetime);
  FullChatView.fromList(List<String> items)
      : this(items[0], items[1], items[2], items[3], items[4], items[5]);
  @override
  String toString() {
    return 'FullChatView{idChat: $esGrupo, esGrupo: $chatNombre, chatNombre: $chatNombre, mensaje: $mensaje, escritor: $escritor, datetime: $datetime}';
  }
}

class SimpleChatView {
  String idContactoChat;
  String idChat;
  String chatNombre;
  String mensajeShort;
  String escritor;
  String datetime;
  SimpleChatView(this.idContactoChat, this.idChat, this.chatNombre,
      this.mensajeShort, this.escritor, this.datetime);
  SimpleChatView.fromList(List<String> items)
      : this(items[0], items[1], items[2], items[3], items[4], items[5]);
  @override
  String toString() {
    return 'SimpleChatView{idContactoChat: $idContactoChat, idChat: $idChat, chatNombre: $chatNombre, mensajeShort: $mensajeShort, escritor: $escritor, datetime: $datetime}';
  }
}
