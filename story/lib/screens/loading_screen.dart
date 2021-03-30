import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:story/screens/category_pick_screen.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2))
        .whenComplete(() => Navigator.pushReplacement(
            context,
            SwipeablePageRoute(
              canOnlySwipeFromEdge: true,
              maintainState: true,
              builder: (BuildContext context) => CategoryPickScreen(),
            )));

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                child: Image.asset(
                  'assets/main.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Story',
                style: GoogleFonts.rockSalt(
                  color: Colors.white,
                  fontSize: 35,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dotted,
                ),
              ),
              SizedBox(
                width: 30,
              ),
            ],
          )
        ],
      ),
    );
  }
}
