import 'package:campamento_estelar/models/user.dart';
import 'package:campamento_estelar/pages/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "dart:convert";
import "package:shared_preferences/shared_preferences.dart";

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
enum Gender {Masculino,Femenino}


class _RegisterPageState extends State<RegisterPage> {

  final _name = TextEditingController();
  final _apellido = TextEditingController();
  final _gmail = TextEditingController();
  final _password = TextEditingController();
  final _rePassword = TextEditingController();


  String _data = "";

  Gender? _gender = Gender.Masculino;

  bool _palmaEspania = false;
  bool _dolomitasEuropa = false;
  bool _archesEEUU = false;
  bool _desietoSahara = false;

  String buttonMsg = "Fecha de nacimiento";

  String _date2 = "";

  String _dateConverter(DateTime newDate){
    final DateFormat formatter = DateFormat("yyyy-MM-dd");
    final String dateFormatted = formatter.format(newDate);
    return dateFormatted;
  }

  void _showSelectDate() async{
    final DateTime? newDate = await showDatePicker(
        context: context,
        locale: const Locale("es","CO"),
        initialDate: DateTime(2022,8),
        firstDate: DateTime(1922,1),
        lastDate: DateTime(2022,12),
        helpText: "Fecha de nacimiento",
    );
    if (newDate != null) {
      setState(() {
        _date2 = _dateConverter(newDate);
        buttonMsg = "Fecha de nacimiento: ${_date2.toString()}";
      });
    }
  }

  //Metodo para generar error si las contraseñas son diferentes
  void _showMsg(String msg){
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(content: Text(msg),
        action: SnackBarAction(
          label: "Aceptar", onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
 //Json
  void saveUser(User user) async{
    SharedPreferences shaPre = await SharedPreferences.getInstance();
    shaPre.setString("user", jsonEncode(user));
  }



  void _onRegisterButtonClicked(){
    setState(() {
      //_data = "Bienvenido: ${_name.text}";
      if (_password.text == _rePassword.text){
        //variables genero y opcion de los lugares favoritos
        String gender = "O";
        String favorites = "";

        //Condicion genero
        if (_gender==Gender.Femenino){
          gender = "A";
        }else{
          gender = "O";
        }

        //Inpresion si escoge una opcion en el CheckBox
        /*
        if (_desietoSahara) favorites = "$favorites Desierto de Sahara, antecedido de Arches de estados unidos en el Ranking. ";
        if (_archesEEUU) favorites = "$favorites Arches de estados unidos, el tercer mejor lugar del mundo. ";
        if (_palmaEspania) favorites = "$favorites Palmas de españa, conciderado el mejor lugar del mundo. ";
        if (_dolomitasEuropa) favorites = "$favorites Dolomitas de Europa, antecedido de Palmas en el Ranking . ";

         */


        var user = User(_name.text,  _gmail.text, _password.text,  gender, "NUll" ,_date2.toString());
        saveUser(user);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));

      }else{
        _showMsg("Las contraseñas no coinciden");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  const Image(image: AssetImage("assets/images/logo.png")),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nombre"),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _apellido,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Apellido"),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _gmail,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Ingrese su correo electrónico"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _password,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Ingrese su contraseña"),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _rePassword,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Ingrese nuevamente su contraseña"),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    "Genero",
                    style: TextStyle(fontSize: 15),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: const Text("Masculino"),
                          leading: Radio<Gender>(
                            value: Gender.Masculino,
                            groupValue: _gender,
                            onChanged: (Gender? value){
                              setState(() {
                                _gender = value;
                              });
                            }
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text("Femenino"),
                          leading: Radio<Gender>(
                            value: Gender.Femenino,
                            groupValue: _gender,
                            onChanged: (Gender? value){
                              setState(() {
                                _gender = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    "Selecciona que lugares te gustaria ver, todos son de los mejores del mundo.",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  CheckboxListTile(
                    title: const Text("Palma de España"),
                    value: _palmaEspania,
                    selected: _palmaEspania,
                    onChanged: (bool? value){
                    setState(() {
                      _palmaEspania = value!;
                    });
                    }
                  ),
                  CheckboxListTile(
                    title: const Text("Dolomitas de Europa"),
                    value: _dolomitasEuropa,
                    selected: _dolomitasEuropa,
                    onChanged: (bool? value){
                    setState(() {
                      _dolomitasEuropa = value!;
                    });
                    }
                  ),
                  CheckboxListTile(
                    title: const Text("Arches de Estados unidos"),
                    value: _archesEEUU,
                    selected: _archesEEUU,
                    onChanged: (bool? value){
                    setState(() {
                      _archesEEUU = value!;
                    });
                    }
                  ),
                  CheckboxListTile(
                    title: const Text("Desierto del Sahara"),
                    value: _desietoSahara,
                    selected: _desietoSahara,
                    onChanged: (bool? value){
                      setState(() {
                        _desietoSahara = value!;
                      });
                    },
                  ),
                  ElevatedButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: (){
                        _showSelectDate();
                      },
                      child: Text(buttonMsg),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: (){
                      _onRegisterButtonClicked();
                    },
                    child: const Text("Registrar")
                  ),
                  /*
                  //Mostrar texto(el Nombre) en pantalla al precionar registrar
                  Text(_data,
                      style: const TextStyle(
                          fontSize: 12, fontStyle: FontStyle.italic))

                   */
                ],
              ),
            ),
          ),
      ),
    );
  }
}
