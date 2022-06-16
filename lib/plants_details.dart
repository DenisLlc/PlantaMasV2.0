import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plantamas/presenters/contacts_presenter.dart';
import 'models/plants.dart';

class ContactDialog {
  final te_name = TextEditingController();
  final te_age = TextEditingController();
  final te_genre = TextEditingController();
  final te_irrigation = TextEditingController();
  final te_sun = TextEditingController();
  final te_size = TextEditingController();
  final te_temperature = TextEditingController();

  late Contact contact;

  final ContactsPresenter contactsPresenter = ContactsPresenter();

  static const TextStyle linkStyle = TextStyle(
    color: Color.fromARGB(255, 33, 243, 61),
    decoration: TextDecoration.underline,
  );

  Widget build(BuildContext context, viewState, bool isEdit, Contact? contact) {
    if (contact != null) {
      this.contact = contact;
      te_name.text = this.contact.name;
      te_age.text = this.contact.age;
      te_genre.text = this.contact.genre;
      te_irrigation.text = this.contact.irrigation;
      te_sun.text = this.contact.sun;
      te_size.text = this.contact.size;
      te_temperature.text = this.contact.temperature;
    }

    return AlertDialog(
      title: Text(isEdit ? 'Editar planta' : 'Agregar Nueva Planta'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("Ingresa el Nombre", te_name),
            getTextField("Ingresa la edad", te_age),
            getTextField("Ingresa el genero", te_genre),
            getTextField("Ingresa el tiempo de irrigacion", te_irrigation),
            getTextField("Ingresa la cantidad de sol", te_sun),
            getTextField("Ingresa el tamaño", te_size),
            getTextField("Ingresa la temperatura ideal", te_temperature),
            GestureDetector(
              onTap: () async {
                await saveContact(isEdit);
                viewState.displayRecord();
                Navigator.of(context).pop();
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: getAppBorderButton(isEdit ? "Editar" : "Agregar",
                    const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    var loginBtn = Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        controller: inputBoxController,
        decoration: InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );
    return loginBtn;
  }

  Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
    var loginBtn = Container(
      margin: margin,
      padding: const EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF28324E)),
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
      ),
      child: Text(
        buttonLabel,
        style: const TextStyle(
          color: Color(0xFF28324E),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
    return loginBtn;
  }

  Future saveContact(bool isEdit) async {
    var contact = Contact(
        te_name.text.toString(),
        te_age.text.toString(),
        te_genre.text.toString(),
        te_irrigation.text.toString(),
        te_sun.text.toString(),
        te_size.text.toString(),
        te_temperature.text.toString());

    if (isEdit && this.contact.id != null) {
      contact.setId(this.contact.id!);
    }

    return contactsPresenter.save(contact);
  }
}
