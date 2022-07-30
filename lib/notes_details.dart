import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plantamas/presenters/notes_presenter.dart';
import 'models/notes.dart';

class ContactDialog {
  final te_name = TextEditingController();
  final te_text = TextEditingController();

  late Note contact;

  final NotesPresenter contactsPresenter = NotesPresenter();

  static const TextStyle linkStyle = TextStyle(
    color: Color.fromARGB(255, 33, 243, 61),
    decoration: TextDecoration.underline,
  );

  Widget build(BuildContext context, viewState, bool isEdit, Note? contact) {
    if (contact != null) {
      this.contact = contact;
      te_name.text = this.contact.name;
      te_text.text = this.contact.text;
    }

    return AlertDialog(
      title: Text(isEdit ? 'Editar nota' : 'Agregar Nueva Nota'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("Ingresa el nombre", te_name),
            getTextField("Ingresa la nota", te_text),
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
    var contact = Note(
        te_name.text.toString(),
        te_text.text.toString());

    if (isEdit && this.contact.id != null) {
      contact.setId(this.contact.id!);
    }

    return contactsPresenter.save(contact);
  }
}
