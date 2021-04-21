import 'package:flutter/material.dart';
import 'package:note_for_you/ui/login.dart';
import 'package:note_for_you/ui/note.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

Future main() async {
  await DotEnv.load(fileName: ".env");
  runApp(NoteForYou());
}

class NoteForYou extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/login': (context) => LoginPage(),
        '/note': (context) => NotePage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  LoginPage();
  }
}