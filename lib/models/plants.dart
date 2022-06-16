import 'package:plantamas/models/base_model.dart';

class Contact extends BaseModel {
  late String _age;
  late String _name;
  late String _genre;
  late String _irrigation;
  late String _sun;
  late String _size;
  late String _temperature;

  Contact(this._name, this._age, this._genre, this._irrigation, this._sun,
      this._size, this._temperature);

  Contact.map(dynamic obj) {
    setId(obj["id"]);
    _name = obj["name"];
    _age = obj["age"];
    _genre = obj["genre"];
    _irrigation = obj["irrigation"];
    _sun = obj["sun"];
    _size = obj["size"];
    _temperature = obj["temperature"];
  }

  String get name => _name;
  String get age => _age;
  String get genre => _genre;
  String get irrigation => _irrigation;
  String get sun => _sun;
  String get size => _size;
  String get temperature => _temperature;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map["name"] = _name;
    map["age"] = _age;
    map["genre"] = _genre;
    map["irrigation"] = _irrigation;
    map["sun"] = _sun;
    map["size"] = _size;
    map["temperature"] = _temperature;

    return map;
  }
}
