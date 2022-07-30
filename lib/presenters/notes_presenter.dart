import 'dart:async';
import 'package:plantamas/data/database_helper.dart';
import 'package:plantamas/models/notes.dart';
import 'package:plantamas/views/base_view.dart';
import 'package:plantamas/widget/custom_banner_ad.dart';

class NotesPresenter {
  late final BaseView _view;

  NotesPresenter();
  NotesPresenter.withView(this._view);

  Future<List<Note>> getAll() async {
    List<Map> list = await DatabaseHelper.internal().query("notes");
    List<Note> contacts = [];

    for (int i = 0; i < list.length; i++) {
      contacts.add(Note.map(list[i]));
    }

    return contacts;
  }

  save(Note contact) async {
    if (contact.id != null) {
      return DatabaseHelper.internal().update("notes", contact);
    }
    return DatabaseHelper.internal().insert("notes", contact);
  }

  delete(Note contact) async {
    print(contact.id);
    await DatabaseHelper.internal().delete("notes", contact);
    const CustomBannerAd();

    updateScreen();
  }

  updateScreen() {
    _view.screenUpdate();
  }
}
