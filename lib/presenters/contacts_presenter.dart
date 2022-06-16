import 'dart:async';
import 'package:plantamas/data/database_helper.dart';
import 'package:plantamas/models/plants.dart';
import 'package:plantamas/views/base_view.dart';

class ContactsPresenter {
  late final BaseView _view;

  ContactsPresenter();
  ContactsPresenter.withView(this._view);

  Future<List<Contact>> getAll() async {
    List<Map> list = await DatabaseHelper.internal().query("plants");
    List<Contact> contacts = [];

    for (int i = 0; i < list.length; i++) {
      contacts.add(Contact.map(list[i]));
    }

    return contacts;
  }

  save(Contact contact) async {
    if (contact.id != null) {
      return DatabaseHelper.internal().update("plants", contact);
    }
    return DatabaseHelper.internal().insert("plants", contact);
  }

  delete(Contact contact) async {
    print(contact.id);
    await DatabaseHelper.internal().delete("plants", contact);
    updateScreen();
  }

  updateScreen() {
    _view.screenUpdate();
  }
}
