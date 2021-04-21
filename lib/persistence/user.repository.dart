import 'package:http/http.dart' show Client;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserRepository {
  Client client = Client();
  final _baseUrl = env['API_URI'];

  Future<bool> get(token) async {
      final response = await client.get(Uri.parse(_baseUrl+ "user?token=" + token), headers: {'Accept': 'application/json; charset=UTF-8'});

      if (response.statusCode == 200) {
        return true; //Return decoded response
      } else {
        return false;
      }
  }
}
