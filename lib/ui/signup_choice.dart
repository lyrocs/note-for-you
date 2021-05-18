import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_for_you/bloc/user.bloc.dart';

class SignUpChoicePage extends StatefulWidget {
  @override
  _SignUpChoiceState createState() => _SignUpChoiceState();
}

class _SignUpChoiceState extends State<SignUpChoicePage> {
  @override
  Widget build(BuildContext context) {
    double textSize = MediaQuery.of(context).size.width <= 600 ? 14.0 : 20.0;
    double horizontalSize = MediaQuery.of(context).size.width <= 600
        ? MediaQuery.of(context).size.width - 75
        : MediaQuery.of(context).size.width / 3;

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
                  Column(children: [
                    Container(
                      width: horizontalSize,
                      child: Column(
                        children: [
                          TextButton.icon(
                            icon: Icon(
                              Icons.message,
                              color: Colors.black,
                              size: 15.0,
                            ),
                            label: Text(' Create a reader account',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20.0)),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/reader/check-token');
                            },
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 20.0)),
                          TextButton.icon(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 15.0,
                            ),
                            label: Text(' Create a writer account',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20.0)),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/signup');
                            },
                          ),
                        ],
                      ),
                    ),
                  ])
                ]))));
  }
}
