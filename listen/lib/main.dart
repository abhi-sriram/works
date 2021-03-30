import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listen/provider/music_stream.dart';
import 'package:listen/screens/loading_screen.dart';
import 'package:listen/widgets/color_palette.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MusicStream(),
      child: MaterialApp(
        title: 'Listen',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            },
          ),
          primarySwatch:
              ColorPalette().generateMaterialColor(Color(0xFF1DB954)),
          // primaryColor: Color(0xFF121212),
          textTheme: TextTheme(
            subtitle2: GoogleFonts.openSans(
              color: Colors.white,
              letterSpacing: 0.3,
              // fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            subtitle1: GoogleFonts.openSans(
              color: Colors.white,
              letterSpacing: 0.2,
              // fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          appBarTheme: AppBarTheme.of(context).copyWith(
            textTheme: TextTheme().copyWith(
              headline6: GoogleFonts.openSans(
                color: Color(0xFF121212),
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
        ),
        home: LoadingScreen(),
      ),
    );
  }
}
