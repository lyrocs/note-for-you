import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_for_you/model/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';


class UserBloc {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  MyUser currentUser = MyUser('', '', false);

  var _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  String? token;

  createWriterAccount(email, password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      UserCredential user = await auth.signInWithEmailAndPassword(email: email, password: password);
      String newToken = getRandomString(6);

      await usersCollection.add({
        'uid': user.user?.uid,
        'token': newToken,
        'isWriter': true,
      });
      await usersCollection.add({
        'uid': '',
        'token': newToken,
        'isWriter': false,
      });
      await login(email, password);
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
      // if (e.code == 'weak-password') {
      //
      //   print('The password provided is too weak.');
      // } else if (e.code == 'email-already-in-use') {
      //   print('The account already exists for that email.');
      // }
    } catch (e) {
      throw e.toString();
      // print(e);
    }
  }

  createReaderAccount(email, password) async {
    try {
      var user = await usersCollection.where('token', isEqualTo: token)
          .where('isWriter', isEqualTo: false)
          .where('uid', isEqualTo: '')
          .get();
      if (user.size == 0) {
        return false;
      }
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      UserCredential userConnected = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      await usersCollection.doc(user.docs.first.id).update(
          {'uid': userConnected.user?.uid});
      await login(email, password);
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
      // if (e.code == 'weak-password') {
      //
      //   print('The password provided is too weak.');
      // } else if (e.code == 'email-already-in-use') {
      //   print('The account already exists for that email.');
      // }
    } catch (e) {
      throw e.toString();
      // print(e);
    }
  }

  subscribe(email, password) async {
    if (token == null) {
      return await createWriterAccount(email, password);
    } else {
      return await createReaderAccount(email, password);
    }
  }

  login(email, password) async {
    try {
      UserCredential userConnected = await auth.signInWithEmailAndPassword(email: email, password: password);
      var user = await usersCollection.where('uid', isEqualTo: userConnected.user?.uid).get();
      currentUser = MyUser(user.docs.first.get('uid'), user.docs.first.get('token'), user.docs.first.get('isWriter'));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      return currentUser;
    } on FirebaseAuthException catch (e) {
      throw (e.message.toString());
      if (e.code == 'weak-password') {}
    } catch(e) {
      throw (e.toString());
    }
  }

  logout() async {
    await auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
  }

  reloging() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = await prefs.getString('email');
    String? password = await prefs.getString('password');

    if (email != null && password != null ) {
      return login(email, password);
    } else {
      return false;
    }
  }


  checkToken(aToken) async {
    var user = await usersCollection
        .where('uid', isEqualTo: '')
        .where('token', isEqualTo: aToken.toUpperCase())
        .get();
    if (user.size != 0) {
      token = aToken.toUpperCase();
    }
    return user.size != 0;
  }

}

final userBloc = UserBloc();
