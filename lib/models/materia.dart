
import 'dart:convert';

class Materia {
  int _id;
  String _nombre;
  String _profesor;
  String _cuatrimestre;
  String _horario;
  int _calificacion;

  int get id => _id;
  String get nombre => _nombre;
  String get profesor => _profesor;
  String get cuatrimestre => _cuatrimestre;
  String get horario => _horario;
  int get calificacion => _calificacion;

  Materia({
      int id,
      String nombre,
      String profesor,
      String cuatrimestre,
      String horario,
      int calificacion}){
    _id = id;
    _nombre = nombre;
    _profesor = profesor;
    _cuatrimestre = cuatrimestre;
    _horario = horario;
    _calificacion = calificacion;
}

  Materia._fromJson(dynamic json) {
    _id = json["id"];
    _nombre = json["nombre"];
    _profesor = json["profesor"];
    _cuatrimestre = json["cuatrimestre"];
    _horario = json["horario"];
    _calificacion = json["calificacion"];
  }

  Map<String, dynamic> _toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["nombre"] = _nombre;
    map["profesor"] = _profesor;
    map["cuatrimestre"] = _cuatrimestre;
    map["horario"] = _horario;
    map["calificacion"] = _calificacion;
    return map;
  }

  static List<Materia> fromJson(String jsonData){
    final data = json.decode(jsonData);
    return List<Materia>.from(data.map(
            (item) => Materia._fromJson(item)
    ));
  }

  static String toJson(Materia data){
    final jsonData = data._toJson();
    return json.encode(jsonData);
  }
}