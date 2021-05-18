import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_for_you/bloc/user.bloc.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignInPage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double textSize = MediaQuery.of(context).size.width <= 600 ? 14.0 : 20.0;
    double horizontalSize = MediaQuery.of(context).size.width <= 600
        ? MediaQuery.of(context).size.width - 75
        : MediaQuery.of(context).size.width / 3;
    double separatorSize = MediaQuery.of(context).size.height <= 1200
        ? MediaQuery.of(context).size.height / 10
        : MediaQuery.of(context).size.height / 5;

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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Column(
                    children: [
                      Container(
                        width: horizontalSize,
                        child: Column(
                          children: [
                            Text('Signin',
                                style: TextStyle(fontSize: textSize)),
                            TextField(
                                controller: loginController,
                                decoration: InputDecoration(hintText: 'Email')),
                            TextField(
                                obscureText: true,
                                controller: passwordController,
                                decoration:
                                    InputDecoration(hintText: 'Password')),
                            Padding(padding: EdgeInsets.only(bottom: 15.0)),
                            SizedBox(
                                width: horizontalSize,
                                child: TextButton(
                                    onPressed: () async {
                                      try {
                                        await userBloc.login(
                                            loginController.text,
                                            passwordController.text);
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(e.toString()),
                                          duration: const Duration(seconds: 5),
                                          backgroundColor: Colors.red,
                                        ));
                                        return;
                                      }
                                      if (userBloc.currentUser.isWriter) {
                                        Navigator.pushNamed(
                                            context, '/writer/home');
                                      } else {
                                        Navigator.pushNamed(
                                            context, '/reader/home');
                                      }
                                    },
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(EdgeInsets.all(15)),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors.black)))),
                                    child: Text('Login',
                                        style: TextStyle(fontSize: textSize)))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: separatorSize),
                        child: Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width / 1.5,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                          width: horizontalSize,
                          child: Column(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/signup/choice');
                                  },
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.all(15)),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                  ),
                                  child: Text('Create an account',
                                      style: TextStyle(fontSize: textSize)))
                            ],
                          ))
                    ],
                  ),
                ]))));
  }
}
