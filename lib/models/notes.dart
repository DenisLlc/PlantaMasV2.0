import 'package:plantamas/models/base_model.dart';

class Note extends BaseModel {
  late String _name;
  late String _text;

  Note(this._name, this._text);

  Note.map(dynamic obj) {
    setId(obj["id"]);
    _name = obj["name"];
    _text = obj["text"];
  }

  String get name => _name;
  String get text => _text;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map["name"] = _name;
    map["text"] = _text;

    return map;
  }
}
