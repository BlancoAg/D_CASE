//import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Character> getCharacter(String characterId) async {
  final databaseReference = FirebaseDatabase.instance.reference();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Character character = new Character();
  character.id = characterId;
  character.pcIsUnlocked = false;
  character.phoneIsUnlocked = false;

  if (characterId != "Home") {
    await databaseReference
        .child("Usuarios")
        .child(_auth.currentUser.uid)
        .child("Characters")
        .child(characterId)
        .once()
        .then((DataSnapshot data) {
      if (data.value != null) {
        character.id = characterId;
        character.name = data.value["Name"] ?? "";
        character.pcIsUnlocked = data.value["PC"];
        character.phoneIsUnlocked = data.value["Phone"];
        character.urlVideo = data.value["URLVideo"] ?? "";
      } else
        return character;
    });
  }
  return character;
}

Future<bool> getPhoneOrPcPasswordByKey(
    String key, String itemName, String characterId) async {
  final databaseReference = FirebaseDatabase.instance.reference();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool result = false;

  String tabla = itemName == "PC" ? "PCPassword" : "PhonePassword";

  await databaseReference
      .child(tabla)
      .child(characterId)
      .once()
      .then((DataSnapshot data) {
    if (data.value == key) {
      databaseReference
          .child("Usuarios")
          .child(_auth.currentUser.uid)
          .child("Characters")
          .child(characterId)
          .child(itemName)
          .set(true);
      result = true;
    }
  });
  return result;
}

class Character {
  ///ESTE ES LA LETRA DEL CHARACTER EJEMPLO "A"
  String id;
  String name;
  bool pcIsUnlocked;
  bool phoneIsUnlocked;
  String urlVideo;

  //Character(String name, bool pcIsUnlocked, bool phoneIsUnlocked);
}

Future<void> saveInitialCharactersUser() async {
  final databaseReference = FirebaseDatabase.instance.reference();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  await databaseReference
      .child("Usuarios")
      .child(_auth.currentUser.uid)
      .child("Characters")
      .set(<String, Object>{
    "Home": {
      "Phone": false,
      "PC": true,
      "Name": "Home",
      "URLVideo":
          "https://github.com/maxmouser/D-CASE/blob/main/estar_360_4k.mp4?raw=true%22"
    },
    "A": {
      "Phone": false,
      "PC": false,
      "Name": "German",
      "URLVideo":
          "https://github.com/maxmouser/D-CASE/blob/main/estar_360_4k.mp4?raw=true%22"
    },
    "B": {
      "Phone": false,
      "PC": false,
      "Name": "Leonel",
      "URLVideo":
          "https://github.com/maxmouser/D-CASE/blob/main/estar_360_4k.mp4?raw=true%22"
    },
    "C": {
      "Phone": false,
      "PC": false,
      "Name": "Joaquina",
      "URLVideo":
          "https://github.com/maxmouser/D-CASE/blob/main/estar_360_4k.mp4?raw=true%22"
    },
    "D": {
      "Phone": false,
      "PC": false,
      "Name": "Kevin",
      "URLVideo":
          "https://github.com/maxmouser/D-CASE/blob/main/estar_360_4k.mp4?raw=true%22"
    },
    "E": {
      "Phone": false,
      "PC": false,
      "Name": "Ezequiel",
      "URLVideo":
          "https://github.com/maxmouser/D-CASE/blob/main/estar_360_4k.mp4?raw=true%22"
    },
    "F": {
      "Phone": false,
      "PC": false,
      "Name": "Natan",
      "URLVideo":
          "https://github.com/maxmouser/D-CASE/blob/main/estar_360_4k.mp4?raw=true%22"
    },
    "G": {
      "Phone": false,
      "PC": true,
      "Name": "Mauro",
      "URLVideo":
          "https://github.com/maxmouser/D-CASE/blob/main/estar_360_4k.mp4?raw=true%22"
    },
    "H": {
      "Phone": false,
      "PC": false,
      "Name": "Abril",
      "URLVideo":
          "https://github.com/maxmouser/D-CASE/blob/main/estar_360_4k.mp4?raw=true%22"
    },
  });
}

Future<bool> checkPatternInDatabase(String codes, String characterId) async {
  final databaseReference = FirebaseDatabase.instance.reference();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool result = false;

  await databaseReference
      .child("PatternLockCodes")
      .child(characterId)
      .once()
      .then((DataSnapshot data) {
    if (data.value.toString() == codes) {
      // databaseReference
      //     .child("Usuarios")
      //     .child(_auth.currentUser.uid)
      //     .child("Characters")
      //     .child(characterId)
      //     .child("PatternLock")
      //     .child(codes)
      //     .set(true);
      databaseReference
          .child("Usuarios")
          .child(_auth.currentUser.uid)
          .child("Characters")
          .child(characterId)
          .child("Phone")
          .set(true);
      result = true;
    }
  });
  return result;
}

Future<void> updateCharacterPhoneOrPcStatusInUser(
    String characterId, String itemName) async {
  final databaseReference = FirebaseDatabase.instance.reference();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  switch (itemName) {
    case "Phone":
      databaseReference
          .child("Usuarios")
          .child(_auth.currentUser.uid)
          .child("Characters")
          .child(characterId)
          .child("Phone")
          .set(true);
      break;

    case "PC":
      databaseReference
          .child("Usuarios")
          .child(_auth.currentUser.uid)
          .child("Characters")
          .child(characterId)
          .child("PC")
          .set(true);
      break;
  }
}

Future<String> getCorrectString(String characterId, String itemName) async {
  final databaseReference = FirebaseDatabase.instance.reference();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String result = '';
  String tabla = itemName == "PC" ? "PCPassword" : "PhonePassword";

  await databaseReference
      .child(tabla)
      .child(characterId)
      .once()
      .then((DataSnapshot data) {
    if (data.value.toString() != null) {
      result = data.value.toString();
    }
  });
  return result;
}

//llamar al patternLock con este navigator of, tiene que ser desde un lugar donde se tenga el characterId
//POR EJEMPLO PARA TESTEAR, LLAMARLO EN PCPHONEWIDGETCALLS.DART POPUPDESBLOQUEADOS CUANDO DA FALSE

//Navigator.of(context).push(MaterialPageRoute(
//                    builder: (context) => MyPatternLock(
//                          key: new Key("mykey"),
//                          title: "mytitle",
//                          characterId: characterId,
//                        )));
