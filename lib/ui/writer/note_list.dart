import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_for_you/bloc/note.bloc.dart';
import 'package:note_for_you/bloc/user.bloc.dart';
import 'menu.dart';

class NoteListPage extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteListPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _key,
      backgroundColor: Color(0xfffdfdfd),
      appBar: AppBar(
        title: Text('Note writer'),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff56c7e3),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
      ),
      drawer: buildMenu(context),
      body: StreamBuilder(
          stream: noteBloc.getNotesSnapshot(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center( child: Text('Something went wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return _buildNoteList(snapshot, context);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var today = DateTime.now().toString().substring(0, 10);
          noteBloc.cursorDate = today;
          Navigator.pushNamed(context, '/writer/note/form');
        },
        tooltip: 'Add score',
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

ListView _buildNoteList(
    AsyncSnapshot<QuerySnapshot<Object?>> snapshot, context) {
  return new ListView(
    children: snapshot.data!.docs.map((DocumentSnapshot document) {
      return new Card(
        child: ListTile(
          leading: document.get('isRead') == true ? Icon(Icons.check): Text(''),
          title: Text(document.get('text')),
          subtitle: Text(DateFormat('d LLLL y')
              .format(DateTime.parse(document.get('date')))
              .toString()),
          trailing: GestureDetector(
            onTap: () {
              noteBloc.cursorDate = document.get('date');
              Navigator.pushNamed(context, '/writer/note/form');
            },
            child: Icon(Icons.create),
          ),
        ),
      );
    }).toList(),
  );
}
