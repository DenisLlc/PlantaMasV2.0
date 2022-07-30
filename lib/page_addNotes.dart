import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plantamas/notes_details.dart';
import 'package:plantamas/models/notes.dart';
import 'package:plantamas/notes_list.dart';
import 'package:plantamas/presenters/notes_presenter.dart';
import 'package:plantamas/views/base_view.dart';
import 'views/base_view.dart';
import 'package:plantamas/widget/custom_banner_ad.dart';

class HomePageNotes extends StatefulWidget {
  const HomePageNotes({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageNotesState createState() => _HomePageNotesState();
}

class _HomePageNotesState extends State<HomePageNotes> implements BaseView {
  late NotesPresenter contactsPresenter;

  @override
  void initState() {
    super.initState();
    contactsPresenter = NotesPresenter.withView(this);
  }

  displayRecord() {
    setState(() {});
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
        Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.center;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: horizontalTitleAlignment,
        children: const <Widget>[
          const CustomBannerAd(),
          Text(
            'Notas',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
    );
  }

  Future _openAddUserDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          ContactDialog().build(context, this, false, null),
    );

    screenUpdate();
  }

  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(
          Icons.add_circle_outline_rounded,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        onPressed: _openAddUserDialog,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(context),
        actions: _buildActions(),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: FutureBuilder<List<Note>>(
        future: contactsPresenter.getAll(),
        builder: (context, snapshot) {
          return NotesList(snapshot.data ?? [], contactsPresenter);
        },
      ),
    );
  }

  @override
  void screenUpdate() {
    setState(() {});
  }
}
