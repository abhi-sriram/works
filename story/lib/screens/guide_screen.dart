import 'package:flutter/material.dart';
import 'package:story/screens/news_screen.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class GuideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Colors.black,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 250,
              child: Image.network(
                  'https://raw.githubusercontent.com/abhi-sriram/python/master/swipe_up.gif'),
            ),
            Text(
              'Swipe up to change the article',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Container(
              height: 250,
              child: Image.network(
                  'https://raw.githubusercontent.com/abhi-sriram/python/master/swipe_right.gif'),
            ),
            Text(
              'Swipe left to open article',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () => Navigator.pushReplacement(
                    context,
                    SwipeablePageRoute(
                      canOnlySwipeFromEdge: true,
                      maintainState: true,
                      builder: (BuildContext context) => NewsScreen(),
                    )),
                child: Text('Continue')),
          ],
        ),
      ),
    );
  }
}
