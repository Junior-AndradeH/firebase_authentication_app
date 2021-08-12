// import
import 'package:flutter/material.dart';

/*  ************************************************************************  */

// class principal
class HomeScreen extends StatelessWidget {
  /*  **********************************************************************  */

  // global
  String _email;
  String _name;
  String _photo;

  /*  **********************************************************************  */

  // constructor
  HomeScreen(this._email, this._name, this._photo);

  /*  **********************************************************************  */

  // widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /* com brightness você pode alterar o tema do seu status bar
          (a barra que fica a hora, sinal, wifi, notificação e etc) */
        brightness: Brightness.dark,
        title: Text("Firebase Authentication"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          elevation: 5.0,
          child: ListTile(
            leading: _photo == null || _photo == ""
                ? Icon(Icons.person)
                : CircleAvatar(
                backgroundImage: NetworkImage(_photo)),
            title: _name == null || _name == ""
                ? Text("Nulo")
                : Text("$_name"),
            subtitle: _email == null || _email == ""
                ? Text("Nulo")
                : Text("$_email"),
          ),
        ),
      ),
    );
  }

  /*  **********************************************************************  */
}