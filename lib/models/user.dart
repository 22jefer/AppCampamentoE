import 'package:flutter/src/widgets/editable_text.dart';

class User{
  var _name;
  var _gmail;
  var _password;
  var _gender;
  var _favorites;
  var _date;


  User(this._name, this._gmail, this._password, this._gender, this._favorites,
      this._date);

  User.Empty();

  User.fromJson(Map<String, dynamic> json)
    : _name = json["name"],
      _gmail = json["gmail"],
      _password = json["password"],
      _gender = json["gender"],
      _favorites = json["favorites"],
      _date = json["date"];

  Map<String, dynamic> toJson() => {
    "name" : _name,
    "gmail" : _gmail,
    "password" : _password,
    "gender" : _gender,
    "favorites" : _favorites,
    "date" : _date,
  };

  get date => _date;

  set date(value) {
    _date = value;
  }

  get favorites => _favorites;

  set favorites(value) {
    _favorites = value;
  }

  get gender => _gender;

  set gender(value) {
    _gender = value;
  }

  get password => _password;

  set password(value) {
    _password = value;
  }

  get gmail => _gmail;

  set gmail(value) {
    _gmail = value;
  }

  get name => _name;

  set name(value) {
    _name = value;
  }
/*
  get dateBirth => _date;

  set dateBirth(value) {
    _date = value;
  }

 */


}