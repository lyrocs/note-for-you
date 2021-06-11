import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_for_you/bloc/user.bloc.dart';
import 'package:note_for_you/ui/writer/menu.dart';

class HomeWriterPage extends StatefulWidget {
  @override
  _HomeWriterState createState() => _HomeWriterState();
}

class _HomeWriterState extends State<HomeWriterPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double textTitleSize =
        MediaQuery.of(context).size.width <= 600 ? 20.0 : 25.0;

    return Scaffold(
        key: _key,
        backgroundColor: Color(0xfffdfdfd),
        appBar: AppBar(
          title: Text('Note writer'),
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff56c7e3),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _key.currentState!.openDrawer();
            },
          ),
        ),
        drawer: buildMenu(context),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Column(children: [
                Container(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(bottom: 10.0)),
                      Text('Please give this token to your note reader',
                          style: TextStyle(fontSize: textTitleSize),
                          textAlign: TextAlign.center),
                      Padding(padding: EdgeInsets.all(10.0)),
                      Text(userBloc.currentUser.token,
                          style: TextStyle(fontSize: 40.0)),
                      Padding(padding: EdgeInsets.only(bottom: 20.0)),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/writer/note/list');
                          },
                          child: Text('Go to your notes',
                              style: TextStyle(fontSize: 20.0)))
                    ],
                  ),
                ),
              ])
            ])));
  }
}
