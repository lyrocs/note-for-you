import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_for_you/bloc/user.bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    userBloc.init();
    if (userBloc.token == null && userBloc.isWriter == null) {
      return SelectLogin();
    }
    return Scaffold(
        body: Center(
      child: Text('Home'),
    ));
  }
}


class SelectLogin extends StatefulWidget {
  @override
  _SelectLoginState createState() => _SelectLoginState();
}

class _SelectLoginState extends State<SelectLogin> {
  var tokenError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Saisisez le token'),
              Visibility(
                  visible: tokenError != '',
                  child: Text(
                      tokenError,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                  )
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: TextField(
                  maxLength: 6,
                  onChanged: (value) async {
                    if (value.length == 6) {
                      var userExist = await userBloc.getUser(value);
                      if (userExist) {
                        // Navigator.pushNamed(context, '/note');
                        Navigator.pushNamed(context, '/note');
                      } else {
                        tokenError = 'Token introuvable';
                        setState(() {});
                      }
                    } else {
                      tokenError = '';
                      setState(() {});
                    }
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }
}