import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listen/provider/music_stream.dart';
import 'package:listen/screens/home_screen.dart';
import 'package:listen/screens/new_screen.dart';
import 'package:listen/screens/search_screen.dart';
import 'package:listen/screens/song_screen.dart';
import 'package:provider/provider.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late MusicStream _music;

  final _appbarTitles = [
    'Home',
    'Playing',
    'Search',
    // 'Contribute',
  ];

  TabController? _controller;
  @override
  void initState() {
    super.initState();
    _music = Provider.of<MusicStream>(context, listen: false);
    _controller = new TabController(length: 3, vsync: this);
    _controller!.addListener(() {
      setState(() {
        _currentIndex = _controller!.index;
      });
    });
  }

  @override
  void dispose() {
    _controller!.removeListener(() {});
    _controller!.dispose();
    _music.disposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // leadingWidth: 1,
          leading: Center(
            child: Text(
              'listen',
              style: GoogleFonts.pacifico(
                fontSize: 20,
              ),
            ),
          ),
          title: Text(_appbarTitles[_currentIndex]),
          centerTitle: true,
        ),
        backgroundColor: Color(0xFF212121),
        body: TabBarView(
          children: [
            HomeScreen(),
            SongScreen(),
            // SearchScreen(),
            NewScreen(),
          ],
          controller: _controller,
        ),
        // bottomNavigationBar: TabBar(
        //   tabs: [
        //     Tab(
        //       icon: Icon(Icons.home_rounded),
        //     ),
        //     Tab(
        //       icon: Icon(Icons.graphic_eq_rounded),
        //     ),
        //     Tab(
        //       icon: Icon(Icons.search_rounded),
        //     ),
        //   ],
        //   indicatorColor: Colors.green,
        //   indicatorPadding: EdgeInsets.symmetric(horizontal: 40),
        //   indicatorWeight: 3.0,

        // ),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: GoogleFonts.openSans(),
          backgroundColor: Color(0xFF121212),
          unselectedLabelStyle: GoogleFonts.openSans(
            color: Color(0xFFB3B3B3),
          ),
          unselectedItemColor: Color(0xFFB3B3B3),
          unselectedIconTheme: IconThemeData(
            color: Color(0xFFB3B3B3),
          ),
          onTap: (index) {
            setState(() {
              _controller!.index = index;
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              tooltip: 'Home',
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.graphic_eq_rounded),
              tooltip: 'Playing',
              label: 'Playing',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              tooltip: 'Search',
              label: 'Search',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.people_rounded),
            //   tooltip: 'Contribute',
            //   label: 'Contribute',
            // ),
          ],
        ),
      ),
    );
  }
}
