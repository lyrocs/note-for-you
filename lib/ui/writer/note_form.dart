import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_for_you/bloc/note.bloc.dart';

class NoteFormPage extends StatefulWidget {
  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteFormPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  TextEditingController textController = TextEditingController();

  initValues() {
    noteBloc.getByDate(noteBloc.cursorDate).then((data) {
      setState(() {
        textController.text = noteBloc.currentNote.text;
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
    DateTime cursorDateTime = DateTime.parse(noteBloc.cursorDate);
    double textSize = MediaQuery.of(context).size.width <= 600 ? 14.0 : 20.0;
    double horizontalSize = MediaQuery.of(context).size.width <= 600
        ? MediaQuery.of(context).size.width - 75
        : MediaQuery.of(context).size.width / 3;

    return Scaffold(
        key: _key,
        backgroundColor: Color(0xfffdfdfd),
        appBar: AppBar(
          title: Text('Note writer'),
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff000931),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
            child: Column(children: [
          Column(children: [
            Container(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(bottom: 10.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () async {
                            noteBloc.cursorDate =
                                DateTime.parse(noteBloc.cursorDate)
                                    .subtract(const Duration(days: 1))
                                    .toString()
                                    .substring(0, 10);
                            initValues();
                          },
                          child: Text(' < ')),
                      TextButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: cursorDateTime,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2025),
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData
                                    .dark(), // This will change to light theme.
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            noteBloc.cursorDate =
                                picked.toString().substring(0, 10);
                            initValues();
                          }
                        },
                        child: Text(
                            '${DateFormat('d LLLL y').format(DateTime.parse(noteBloc.cursorDate)).toString()}'),
                      ),
                      TextButton(
                          onPressed: () async {
                            noteBloc.cursorDate =
                                DateTime.parse(noteBloc.cursorDate)
                                    .add(const Duration(days: 1))
                                    .toString()
                                    .substring(0, 10);
                            initValues();
                          },
                          child: Text(' > ')),
                    ],
                  ),

                  // Padding(padding: EdgeInsets.only(bottom: separatorSize)),
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: textController,
                          onSubmitted: (value) {
                            noteBloc.currentNote.text = value;
                          },
                          onChanged: (value) {
                            noteBloc.currentNote.text = value;
                          },
                          decoration: InputDecoration(hintText: 'Text'))),

                  Padding(padding: EdgeInsets.only(bottom: 15.0)),
                  SizedBox(
                      width: horizontalSize,
                      child: TextButton(
                          onPressed: () async {
                            await noteBloc.insertNote();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Note saved'),
                              duration: const Duration(seconds: 5),
                              backgroundColor: Colors.green,
                            ));
                            // Navigator.pushNamed(context, '/note-list');
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(15)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.black)))),
                          child: Text('Save',
                              style: TextStyle(fontSize: textSize)))),
                ],
              ),
            ),
          ])
        ])));
  }
}
