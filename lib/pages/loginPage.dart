import 'dart:convert';

import 'package:campamento_estelar/models/user.dart';
import 'package:campamento_estelar/pages/homePage.dart';
import 'package:campamento_estelar/pages/registerPage.dart';
import 'package:campamento_estelar/pages/search_book_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _gmail = TextEditingController();
  final _password = TextEditingController();

  User userLoad = User.Empty();

  @override
  void initState(){
    _getUser();
    super.initState();
  }


  _getUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = jsonDecode(prefs.getString("user")!);
    userLoad = User.fromJson(userMap);
  }

  void _showMsg(String msg){
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(content: Text(msg),
        action: SnackBarAction(
            label: "Aceptar", onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _validateUser() async {
          _getUser();
    if (_gmail.text == userLoad.gmail && _password.text == userLoad.password){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SearchBookPage() ));
      }else{
        _showMsg("Contraseña o gmail incorrectos");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 14),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Image(image: AssetImage("assets/images/astronauta3.png")),
                const SizedBox(
                  height: 14,
                ),
                TextFormField(
                  controller: _gmail,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Correo electrónico"),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 14,
                ),
                TextFormField(
                  controller: _password,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Contraseña"),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 14,
                ),
                ElevatedButton(
                    onPressed: (){
                      _validateUser();
                    },
                    child: const Text("Iniciar Sesión")),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.blueGrey,
                    ),
                  ),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                    },
                    child: const Text("Registrarse"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
