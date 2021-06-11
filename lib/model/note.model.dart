class Note {
  String id = '';
  String text = '';
  String date = '';
  String token = '';
  bool isRead = false;

  Note(aId, aText, aDate, aToken, aIsRead)  {
    id = aId;
    text = aText;
    date = aDate;
    token = aToken;
    isRead = aIsRead;
  }

  Note.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    text = parsedJson['text'];
    date = parsedJson['date'];
    token = parsedJson['token'];
    isRead = parsedJson['isRead'];
  }
}
