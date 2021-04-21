import 'package:rxdart/rxdart.dart';
import 'package:note_for_you/model/note.model.dart';
import 'package:note_for_you/persistence/note.repository.dart';
import 'package:note_for_you/bloc/user.bloc.dart';

class NoteBloc {
  NoteRepository _repository = NoteRepository();

  final _noteFetcher = PublishSubject<Note>();
  final _notesFetcher = PublishSubject<List<Note>>();
  var _noteToday;

  Observable<Note> get note => _noteFetcher.stream;
  Observable<List<Note>> get notes => _notesFetcher.stream;
  Note get todayNote => _noteToday;

  fetchNote() async {
    var token = userBloc.token;
    _repository.fetchToday(token).then((noteResponse) => {
      _noteFetcher.sink.add(noteResponse)
    }).catchError((error) {
      _noteFetcher.addError(error);
    });
  }

  fetchNotes() async {
    var token = userBloc.token;
    _repository.fetchAll(token).then((noteResponse) {
      print('result:');
      print(noteResponse);
      _notesFetcher.sink.add(noteResponse);
    }).catchError((error) {
      _notesFetcher.addError(error);
    });
  }

  dispose() {
    _noteFetcher.close();
  }
}

final noteBloc = NoteBloc();
