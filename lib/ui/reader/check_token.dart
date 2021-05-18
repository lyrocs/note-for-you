import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_for_you/bloc/user.bloc.dart';

class CheckTokenPage extends StatefulWidget {
  @override
  _CheckTokenPageState createState() => _CheckTokenPageState();
}

class _CheckTokenPageState extends State<CheckTokenPage> {
  var tokenError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/login-background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text('Please enter the token given to you'),
                Visibility(
                    visible: tokenError != '',
                    child: Text(
                      tokenError,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  child: TextField(
                    maxLength: 6,
                    decoration: InputDecoration(hintText: 'eg: A1B2C3'),
                    onChanged: (value) async {
                      if (value.length == 6) {
                        var userExist = await userBloc.checkToken(value);
                        if (userExist) {
                          // Navigator.pushNamed(context, '/note');
                          Navigator.pushNamed(context, '/signup');
                        } else {
                          tokenError = 'Token not found';
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
          ],
        ),
      ),
    ));
  }
}
