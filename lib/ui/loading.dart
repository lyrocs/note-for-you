import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_for_you/bloc/user.bloc.dart';



class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}


class _LoadingPageState extends State<LoadingPage> {
  TextEditingController textController = TextEditingController();

  initValues() {
    userBloc.reloging().then((response) {
      if (response != false) {
        if (userBloc.currentUser.isWriter) {
          Navigator.pushNamed(
              context, '/writer/home');
        } else {
          Navigator.pushNamed(
              context, '/reader/home');
        }
      } else {
        Navigator.pushNamed(
            context, '/signin');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initValues();
  }



  @override
  Widget build(BuildContext context) {

    return Center(child:
      Column(
        children: [
          CircularProgressIndicator(),
        ],
      )
    );
  }



}