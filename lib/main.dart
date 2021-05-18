import 'package:flutter/material.dart';
import 'package:note_for_you/ui/loading.dart';
import 'package:note_for_you/ui/signin.dart';
import 'package:note_for_you/ui/signup.dart';
import 'package:note_for_you/ui/signup_choice.dart';

import 'package:note_for_you/ui/reader/check_token.dart';
import 'package:note_for_you/ui/reader/home.dart';

import 'package:note_for_you/ui/writer/home_writer.dart';
import 'package:note_for_you/ui/writer/note_list.dart';
import 'package:note_for_you/ui/writer/note_form.dart';
import 'package:note_for_you/services/notification_service.dart';

import 'package:firebase_core/firebase_core.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await notificationService.init();
  notificationService.scheduleDailyTenAMNotification();
  await Firebase.initializeApp();
  runApp(NoteForYou());
}


class NoteForYou extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/loading': (context) => LoadingPage(),
        '/signin': (context) => SignInPage(),
        '/signup': (context) => SignUpPage(),
        '/signup/choice': (context) => SignUpChoicePage(),
        '/reader/check-token': (context) => CheckTokenPage(),
        '/reader/home': (context) => HomeReaderPage(),
        '/writer/home': (context) => HomeWriterPage(),
        '/writer/note/list': (context) => NoteListPage(),
        '/writer/note/form': (context) => NoteFormPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  LoadingPage();
  }
}