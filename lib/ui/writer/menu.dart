import 'package:flutter/material.dart';
import 'package:note_for_you/bloc/user.bloc.dart';

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 40, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4),
        size.width - 40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

final Color primary = Color(0xff000931);
final Color active = Color(0xffffc107);

buildMenu(context) {
  return ClipPath(
    clipper: OvalRightBorderClipper(),
    child: Drawer(
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 40),
        decoration: BoxDecoration(
            color: Color(0xff03657f), boxShadow: [BoxShadow(color: Colors.black45)]),
        width: 300,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.power_settings_new,
                      color: active,
                    ),
                    onPressed: () async {
                      await userBloc.logout();
                      Navigator.pushNamed(context, '/signin');
                    },
                  ),
                ),
                // Container(
                //   height: 90,
                //   alignment: Alignment.center,
                //   decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       gradient: LinearGradient(
                //           colors: [Colors.pink, Colors.deepPurple])),
                //   child: CircleAvatar(
                //     radius: 40,
                //   ),
                // ),
                SizedBox(height: 5.0),
                Text(
                  'Your token :',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                Text(
                  "${userBloc.currentUser.token}",
                  style: TextStyle(color: active, fontSize: 16.0),
                ),
                SizedBox(height: 30.0),
                _buildRow(context, Icons.home, "Home", '/writer/home'),
                // _buildDivider(),
                // _buildRow(context, Icons.person_pin, "Your profile", ''),
                // _buildDivider(),
                // _buildRow(context, Icons.settings, "Settings", ''),
                // _buildDivider(),
                // _buildRow(context, Icons.email, "Contact us", ''),
                // _buildDivider(),
                // _buildRow(context, Icons.info_outline, "Help", ''),
                // _buildDivider(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Divider _buildDivider() {
  return Divider(
    color: active,
  );
}

Widget _buildRow(context, IconData icon, String title, String route) {
  final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
  return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Row(children: [
          Icon(
            icon,
            color: active,
          ),
          SizedBox(width: 10.0),
          Text(
            title,
            style: tStyle,
          ),
        ]),
      ));
}
