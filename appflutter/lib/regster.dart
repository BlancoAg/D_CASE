import 'Splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:appflutter/DataBaseService.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance.reference();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //@override
  //bool _isSuccess;

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
            key: _formKey,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: _displayName,
                      decoration: const InputDecoration(labelText: 'Full Name'),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      alignment: Alignment.center,
                      child: OutlineButton(
                        child: Text("Register"),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _registerAccount();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  void _registerAccount() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;

    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      await user.updateProfile(displayName: _displayName.text);
      final user1 = _auth.currentUser;
      addUserToFirebase(); //llamar funcion de registrar en tabla de usuarios
      saveInitialCharactersUser(); //llama a funcion para tener todos los characters armados

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainPage(
                user: user1,
              )));
    } else {
      //_isSuccess = false;
    }
  }

  /// Graba en la tabla Usuarios el ID de Usuario con Key, Valor {Mail: UserID}.
  /// Graba en la Base de Datos el caso y los videos desbloqueados.
  void addUserToFirebase() {
    try {
      databaseReference
          .child("Usuarios")
          .child(_auth.currentUser.uid)
          .child("Mail")
          .set(_auth.currentUser.email);

      databaseReference
          .child("Usuarios")
          .child(_auth.currentUser.uid)
          .child("VideosDesbloqueados")
          .child("VideoPrueba")
          .set(false);

      databaseReference
          .child("Usuarios")
          .child(_auth.currentUser.uid)
          .child("CasosDesbloqueados")
          .child("Caso1")
          .set("");
    } catch (e) {
      _buildErrorRegistroAlertDialog(e);
    }
  }

  Widget _buildErrorRegistroAlertDialog(String e) {
    return AlertDialog(
      title: Text('Error'),
      content: Text("Ocurrió un error. Intentalo nuevamente! " + "[Error de Tipo: " + e + "]"),
      actions: [
        FlatButton(
            child: Text("Ok"),
            textColor: Colors.blue[300],
            onPressed: () {
              Navigator.of(context).pop();
            }),
        /*FlatButton(
            child: Text("Cancelar"),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).pop();
            }),*/
      ],
    );
  }
}
