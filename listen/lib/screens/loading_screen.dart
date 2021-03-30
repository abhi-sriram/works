import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listen/screens/tabs.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) => Navigator.of(context)
        .pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => Tabs()), (route) => false));
    return Scaffold(
      backgroundColor: Color(0xFF212121),
      body: Center(
        child: Text(
          'listen',
          style: GoogleFonts.pacifico(
            fontSize: 60,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
