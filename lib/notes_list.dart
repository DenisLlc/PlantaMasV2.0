import 'package:flutter/material.dart';
import 'package:plantamas/presenters/notes_presenter.dart';
import 'notes_details.dart';
import 'models/notes.dart';

class NotesList extends StatelessWidget {
  late List<Note> contacts;
  late NotesPresenter contactsPresenter;

  NotesList(
    this.contacts,
    this.contactsPresenter, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
                child: Center(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                          radius: 40.0,
                          child: Text(getInitials(contacts[index]),
                              style: const TextStyle(
                                  fontSize: 24.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          backgroundColor: Color.fromARGB(255, 52, 131, 62)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                contacts[index].name,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Nota: " + contacts[index].text,
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Color.fromARGB(255, 21, 49, 22)),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Color(0xFF167F67),
                            ),
                            onPressed: () => edit(contacts[index], context),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_forever,
                                color: Color(0xFF167F67)),
                            onPressed: () =>
                                contactsPresenter.delete(contacts[index]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
          );
        });
  }

  displayRecord() {
    contactsPresenter.updateScreen();
  }

  edit(Note contact, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          ContactDialog().build(context, this, true, contact),
    );
    contactsPresenter.updateScreen();
  }

  String getInitials(Note contact) {
    String initials = "";
    if (contact.name.isNotEmpty) {
      initials = contact.name.substring(0, 1) + ".";
    }
    return initials;
  }
}
