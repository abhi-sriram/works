import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:story/api/api_calls.dart';
import 'package:story/models/result_model.dart';
import 'package:story/screens/webview_screen.dart';
import 'package:story/widgets/shimmer_widget.dart';
import 'package:intl/intl.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<ResultModel> _list = [];

  int f = 0;
  // show() {
  //   if (f == 0) {
  //     showSheet(context);
  //     setState(() {
  //       f = 1;
  //     });
  //   }
  // }

  //   @override
  // void didChangeDependencies() {
  //   Future.delayed(Duration(seconds: 2)).whenComplete(() {
  //     showSheet();
  //   });
  //   super.didChangeDependencies();
  // }

  // showSheet() {
  //   showBottomSheet(
  //       context: context,
  //       builder: (_) {
  //         return
  //       });
  // }

  strCheck(String s) {
    String newS = '';
    int f = 0;
    for (var i = 0; i < s.length; i++) {
      if (s[i] == '') {
        f = 1;
        continue;
      }
      if (s[i] == 'â') {
        f = 1;
        continue;
      }
      if (f == 1) {
        newS += "'";
        f = 0;
      } else {
        newS += s[i];
      }
    }
    return newS;
  }

  @override
  Widget build(BuildContext context) {
    final _apiCalls = Provider.of<ApiCalls>(context);
    _list = _apiCalls.getStories();
    // show();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: _list.length == 0
            ? ShimmerWidget()
            : PageView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, position) {
                  var format = DateFormat.yMEd();
                  var dateString = format.format(_list[position].publishedDate);
                  final data =
                      '### ${strCheck(_list[position].resultAbstract)}' +
                          '[ Read Article.](${_list[position].url})';
                  strCheck(_list[position].title);
                  return GestureDetector(
                    onHorizontalDragStart: (det) async {
                      // if (Platform.isFuchsia) {
                      //   print('Yes');
                      // }
                      // if (Platform.isAndroid || Platform.isIOS) {
                      //   print('Link tapped');
                      Navigator.of(context).push(SwipeablePageRoute(
                        canOnlySwipeFromEdge: true,
                        maintainState: true,
                        builder: (BuildContext context) =>
                            WebViewScreen(_list[position].url),
                      ));
                      // } else {
                      // final url = _list[position].url;
                      // if (await canLaunch(url)) {
                      //   await launch(
                      //     url,
                      //     enableJavaScript: true,
                      //   );
                      // } else {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(content: Text('Invalid link')));
                      //   throw 'Could not launch  $url';
                      // }
                      // }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: NetworkImage(
                          _list[position].multimedia[0].url,
                        ),
                        fit: BoxFit.cover,
                      )),
                      child: Column(
                        children: [
                          Expanded(child: Container()),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black38,
                                    Colors.black,
                                  ]),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _list[position].section.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  strCheck(_list[position].title),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                // Text(
                                //   data,
                                //   style: TextStyle(
                                //     color: Colors.white,
                                //     fontSize: 16,
                                //   ),
                                // ),
                                MarkdownBody(
                                  data: data,
                                  styleSheet: MarkdownStyleSheet(
                                    h3: TextStyle(
                                      color: Colors.white,
                                    ),
                                    a: TextStyle(
                                      color: Color(0xFFF44236),
                                    ),
                                  ),
                                  onTapLink: (_, href, __) async {
                                    // if (Platform.isAndroid || Platform.isIOS) {
                                    Navigator.of(context)
                                        .push(SwipeablePageRoute(
                                      canOnlySwipeFromEdge: true,
                                      maintainState: true,
                                      builder: (BuildContext context) =>
                                          WebViewScreen(_list[position].url),
                                    ));
                                    // } else {
                                    // final url = _list[position].url;
                                    // if (await canLaunch(url)) {
                                    //   await launch(
                                    //     url,
                                    //     enableJavaScript: true,
                                    //     forceWebView: true,
                                    //   );
                                    // } else {
                                    //   ScaffoldMessenger.of(context)
                                    //       .showSnackBar(SnackBar(
                                    //           content: Text('Invalid link')));
                                    //   throw 'Could not launch  $url';
                                    // }
                                    // }
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  '${_list[position].byline.replaceAll('â', "'")}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Published date: $dateString',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Source: ${_list[position].multimedia[0].copyright.replaceAll('â', "'")}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: _list.length,
                physics: BouncingScrollPhysics(),
              ),
      ),
    );
  }
}
