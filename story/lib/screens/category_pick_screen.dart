import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:story/api/api_calls.dart';
import 'package:story/screens/news_screen.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class CategoryPickScreen extends StatefulWidget {
  @override
  _CategoryPickScreenState createState() => _CategoryPickScreenState();
}

class _CategoryPickScreenState extends State<CategoryPickScreen> {
  List _tags = [
    'arts',
    'automobiles',
    // 'books',
    // 'business',
    'fashion',
    'food',
    'health',
    'home',
    'insider',
    'magazine',
    'movies',
    'nyregion',
    'obituaries',
    'opinion',
    'politics',
    'realestate',
    'science',
    'sports',
    'sundayreview',
    'technology',
    'theater',
    't-magazine',
    'travel',
    'upshot',
    'us',
    'world',
  ];
  List<bool> _selected = List.generate(24, (index) => false);

  getChip(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selected[index] = !_selected[index];
        });
      },
      child: Chip(
        padding: EdgeInsets.all(8),
        label: Text(
          '${_tags[index]}',
          style: TextStyle(
            color: _selected[index] ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
        backgroundColor: _selected[index]
            ? Color(0xFFF44236).withOpacity(0.9)
            : Colors.grey[200],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _apiCalls = Provider.of<ApiCalls>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF44236),
        title: Text(
          'Pick your intrests',
          style: GoogleFonts.rockSalt(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (ctx, constrains) {
          if (constrains.maxWidth < 500) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: GridView.builder(
                      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //     crossAxisCount: 5, childAspectRatio: 19 / 3),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 19 / 8),
                      itemBuilder: (ctx, index) {
                        return getChip(index);
                      },
                      itemCount: _tags.length,
                    ),
                  ),
                ),
                _selected.any((element) => element == true)
                    ? TextButton(
                        onPressed: () {
                          List<String> s = [];
                          for (var i = 0; i < _selected.length; i++) {
                            if (_selected[i]) {
                              s.add(_tags[i]);
                            }
                          }
                          _apiCalls.topStories(s);
                          print(s);
                          Navigator.pushReplacement(
                              context,
                              SwipeablePageRoute(
                                canOnlySwipeFromEdge: true,
                                maintainState: true,
                                builder: (BuildContext context) => NewsScreen(),
                              ));
                        },
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 30,
                ),
              ],
            );
          }
          if (constrains.maxWidth < 800) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, childAspectRatio: 19 / 5),
                      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      // crossAxisCount: 3, childAspectRatio: 19 / 8),
                      itemBuilder: (ctx, index) {
                        return getChip(index);
                      },
                      itemCount: _tags.length,
                    ),
                  ),
                ),
                _selected.any((element) => element == true)
                    ? ElevatedButton(
                        onPressed: () {
                          List<String> s = [];
                          for (var i = 0; i < _selected.length; i++) {
                            if (_selected[i]) {
                              s.add(_tags[i]);
                            }
                          }
                          _apiCalls.topStories(s);
                          print(s);
                          Navigator.pushReplacement(
                              context,
                              SwipeablePageRoute(
                                canOnlySwipeFromEdge: true,
                                maintainState: true,
                                builder: (BuildContext context) => NewsScreen(),
                              ));
                        },
                        child: Text(
                          'CONTINUE',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 30,
                ),
              ],
            );
          }
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5, childAspectRatio: 19 / 5),
                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    // crossAxisCount: 3, childAspectRatio: 19 / 8),
                    itemBuilder: (ctx, index) {
                      return getChip(index);
                    },
                    itemCount: _tags.length,
                  ),
                ),
              ),
              _selected.any((element) => element == true)
                  ? TextButton(
                      onPressed: () {
                        List<String> s = [];
                        for (var i = 0; i < _selected.length; i++) {
                          if (_selected[i]) {
                            s.add(_tags[i]);
                          }
                        }
                        _apiCalls.topStories(s);
                        print(s);
                        Navigator.pushReplacement(
                            context,
                            SwipeablePageRoute(
                              canOnlySwipeFromEdge: true,
                              maintainState: true,
                              builder: (BuildContext context) => NewsScreen(),
                            ));
                      },
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 30,
              ),
            ],
          );
        },
      ),
    );
  }
}
