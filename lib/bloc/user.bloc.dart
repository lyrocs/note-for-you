import 'package:note_for_you/persistence/user.repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc {
  UserRepository _repository = UserRepository();

  String token;
  bool isWriter;

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    isWriter = prefs.getBool('isWriter');
    print('Token is $token.');
    print('isWriter is $isWriter.');
    // await prefs.setString('token', '1234');
  }

  getUser(tokenParams) async {
    var userExists = await _repository.get(tokenParams);
    if (userExists) {
      token = tokenParams;
      isWriter = false;
      return true;
    }
    return false;
  }
}

final userBloc = UserBloc();
