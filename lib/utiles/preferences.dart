import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  bool get flag {
    return _prefs.getBool('frompage') ?? false;
  }

  set flag(bool value) {
    _prefs.setBool('frompage', value);
  }

  bool get load {
    return _prefs.getBool('load') ?? false;
  }

  set load(bool value) {
    _prefs.setBool('load', value);
  }
}
