import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_for_you/bloc/note.bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'menu.dart';

class HomeReaderPage extends StatefulWidget {
  @override
  _HomeReaderState createState() => _HomeReaderState();
}

class _HomeReaderState extends State<HomeReaderPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  String today = '';
  String textNote = 'No note today';

  initValues() {
    noteBloc.getByDate(DateTime.now().toString().substring(0, 10)).then((data) {
      setState(() {
        today = DateFormat('d LLLL y')
            .format(DateTime.parse(noteBloc.currentNote.date))
            .toString();
        textNote = noteBloc.currentNote.text;
      });
    });
  }

  @override
  void initState() {
    initValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double textSize = MediaQuery.of(context).size.width <= 600 ? 25.0 : 30.0;
    double paddingDate = MediaQuery.of(context).size.width <= 600 ? 70.0 : 50.0;
    double paddingBottom =
        MediaQuery.of(context).size.width <= 600 ? 70.0 : 50.0;

    noteBloc.readDayNote(DateTime.now().toString().substring(0, 10));
    return Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text('Your daily note'),

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
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/note-background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14)),
                Text(today, style: TextStyle(fontSize: textSize)),
                Spacer(),
                Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Text(textNote,
                        style: TextStyle(fontSize: textSize),
                        textAlign: TextAlign.center)),
                Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.12)),
              ]),
        ));
  }
}
