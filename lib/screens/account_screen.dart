// import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_app/model/image_model.dart';
import 'package:firebase_authentication_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

/*  ************************************************************************  */

// class principal
class AccountScreen extends StatelessWidget {
  /*  **********************************************************************  */

  // final
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  /*  **********************************************************************  */

  // global
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User _currentUser;

  String _email;
  String _name;
  String _photo;

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
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset(
                      ImagesModel.logoFirebase,
                      fit: BoxFit.cover,
                      width: 20.0,
                      height: 20.0,
                    ),
                    SizedBox(width: 10.0),
                    Text("Firebase",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))
                  ],
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "E-mail",
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: "Ex: meu_e-mail@gmail.com",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  validator: (text) {
                    if (text.isEmpty ||
                        !text.contains("@") ||
                        !text.contains(".com"))
                      return "E-mail inválido!";
                    else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: "Ex: 123456",
                  ),
                  cursorColor: Colors.black,
                  obscureText: true,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Senha inválida";
                    else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                      child: Text(
                        "Criar conta no Firebase",
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          // autenticação do firebase
                          _firebaseAuth
                              .createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text)
                              .then((user) async {
                            _email = user.user.email;
                            _name = "Teste";
                            _photo = "";

                            /*
                              como o app é somente autenticação,
                              então ele acaba que não resgata o nome,
                              imagem e etc, porém basta você setar os valores:

                              _name = user.user.displayName;
                              _avatar = user.user.photoURL;
                            */

                            onSucess(context, _email, _name, _photo);
                          }).catchError((e) {
                            onFail(context);
                          });
                        }
                      }),
                ),
              ],
            ),
          ),
        ));
  }

  /*  **********************************************************************  */

  // void
  void onSucess(BuildContext context, String email, String name, String photo) {
    // snackbar
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Sucesso ao fazer o login."),
      backgroundColor: Colors.greenAccent,
      duration: Duration(seconds: 2),
      onVisible: () {
        // navigator
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomeScreen(email, name, photo)));
      },
    ));
  }

  void onFail(BuildContext context) {
    // snackbar
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Falha ao fazer o login."),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }

  /*  **********************************************************************  */
}