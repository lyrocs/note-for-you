import 'dart:convert';
import 'package:note_for_you/model/note.model.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NoteRepository {
  Client client = Client();
  final _baseUrl = env['API_URI'];

  Future<Note> fetchToday(token) async {
    final response = await client.get(Uri.parse(_baseUrl+ "note?token=" + token), headers: {'Accept': 'application/json; charset=UTF-8'}); // Make the network call asynchronously to fetch the London weather data.

      if (response.statusCode == 200) {
        return Note.fromJson(json.decode(response.body)); //Return decoded response
      } else if (response.statusCode == 204) {
        throw 'EMPTY';
      } else {
        throw 'NETWORK_ERROR';
      }
  }
  Future<List<Note>> fetchAll(token) async {
    final response = await client.get(Uri.parse(_baseUrl+ "writer/notes?token=" + token), headers: {'Accept': 'application/json; charset=UTF-8'}); // Make the network call asynchronously to fetch the London weather data.

    if (response.statusCode == 200) {
      List<Note> notes = [];
      var responseJson = json.decode(response.body);
      responseJson.forEach((element) {
        notes.add(Note.fromJson(json.decode(element)));
      });
      return notes;
    } else if (response.statusCode == 204) {
      throw 'EMPTY';
    } else {
      throw 'NETWORK_ERROR';
    }
  }


}
