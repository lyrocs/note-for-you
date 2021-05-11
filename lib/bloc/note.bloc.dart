import 'package:note_for_you/model/note.model.dart';
import 'package:note_for_you/bloc/user.bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteBloc {
  String cursorDate = '';
  CollectionReference notesCollection =
      FirebaseFirestore.instance.collection('notes');

  Note _currentNote = Note('', '', '');
  Note get currentNote => _currentNote;

  getNotes() async {
    var notesRequest = await notesCollection
        .where('token', isEqualTo: userBloc.currentUser.token)
        .get();
    List<Note> noteList = [];
    notesRequest.docs.forEach((element) {
      noteList.add(
          Note(element.get('text'), element.get('date'), element.get('token')));
    });
  }

  getByDate(date) async {
    _currentNote.date = '';
    _currentNote.text = '';
    var notesRequest = await notesCollection
        .where('token', isEqualTo: userBloc.currentUser.token)
        .where('date', isEqualTo: date)
        .get();
    if (notesRequest.size != 0) {
      Note aNote = Note(
          notesRequest.docs.first.get('text'),
          notesRequest.docs.first.get('date'),
          notesRequest.docs.first.get('token'));
      _currentNote = aNote;
    }
  }

  insertNote() async {
    var notesRequest = await notesCollection
        .where('token', isEqualTo: userBloc.currentUser.token)
        .where('date', isEqualTo: cursorDate)
        .get();
    if (notesRequest.size != 0) {
      await notesCollection
          .doc(notesRequest.docs.first.id)
          .update({'text': currentNote.text});
    } else {
      await notesCollection.add({
        'token': userBloc.currentUser.token,
        'text': currentNote.text,
        'date': cursorDate
      });
    }
  }
}

final noteBloc = NoteBloc();
