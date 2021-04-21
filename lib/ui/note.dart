import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_for_you/bloc/note.bloc.dart';
import 'package:note_for_you/model/note.model.dart';

class NotePage extends StatefulWidget {
  NotePage({Key key}) : super(key: key);

  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    noteBloc.fetchNote();
    return Scaffold(
      body: StreamBuilder(
          stream: noteBloc.note,
          builder: (context, AsyncSnapshot<Note> snapshot) {
            if (snapshot.hasData) {
              return _buildHomeScreen(snapshot.data);
            } else if (snapshot.hasError) {
              print(snapshot.error.toString());
              if (snapshot.error.toString() == 'EMPTY') {
                return _buildEmptyNote();
              } else {
                return _buildErrorNetwork();
              }
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Center _buildEmptyNote() {
    return Center(
      child: Text("Pas de note aujourd\'hui"),
    );
  }

  Center _buildErrorNetwork() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Erreur de connection au serveur"),
        TextButton(
            onPressed: () async {
              noteBloc.fetchNote();
            },
            child: Text('Refresh'))
      ],
    ));
  }

  Center _buildHomeScreen(Note data) {
    return Center(
      child: Text(data.text,
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20)),
    );
  }
}
