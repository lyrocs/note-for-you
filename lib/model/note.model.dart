class Note {
  String text = '';
  String date = '';
  String token = '';

  Note(aText, aDate, aToken)  {
    text = aText;
    date = aDate;
    token = aToken;
  }

  Note.fromJson(Map<String, dynamic> parsedJson) {
    text = parsedJson['text'];
    date = parsedJson['date'];
    token = parsedJson['token'];
  }
}
