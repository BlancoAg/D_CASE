import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class LoadCsvDataScreen extends StatelessWidget {
  final List<List<dynamic>> data;
  LoadCsvDataScreen({this.data});
  final List<SuspectMessage> listSuspectMessage = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CSV DATA"),
      ),
      body: FutureBuilder(
        future: loadingCsvData(data),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          return snapshot.hasData
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: Column(
                      children: snapshot.data
                          .map(
                            (data) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    data[0].toString(),
                                  ),
                                  Text(
                                    data[1].toString(),
                                  ),
                                  Text(
                                    data[2].toString(),
                                  ),
                                  Text(
                                    data[3].toString(),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ))
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Future<List<List<dynamic>>> loadingCsvData(List<List<dynamic>> data) async {
    final myData = await rootBundle.loadString("lib/testcsv.csv");

    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);

    var list = listToSuspectMessage(csvTable);

    return data = csvTable;
  }

  List<SuspectMessage> listToSuspectMessage(List<List<dynamic>> listCSV) {
    List<SuspectMessage> listMessage = List<SuspectMessage>();

    List<String> stringList = List<String>();

    listCSV.removeAt(0);

    for (var line in listCSV) {
      for (var item in line) {
        stringList.add(item); //ejemplo ["A", "Jorge", "contacto1", "mensajexd"];
      }
      listMessage.add(SuspectMessage.fromList(stringList)); //lista de objeto mensaje
      stringList.removeRange(0, stringList.length); //Vaciar lista de items ej "A"
    }

    //Acá tenemos un filtro de prueba
    var test = listMessage.where((i) => i.personaje == "A").toList();

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
