import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:story/api/api_calls.dart';
import 'package:story/screens/loading_screen.dart';
import 'package:story/widgets/color_palette.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xFFF44236),
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ApiCalls(),
      child: MaterialApp(
        title: 'Story',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            },
          ),
          primarySwatch:
              ColorPalette().generateMaterialColor(Color(0xFFF44236)),
          // primaryColor: Color(0xFF121212),
          // textTheme: TextTheme(
          //   subtitle2: GoogleFonts.openSans(
          //     color: Colors.white,
          //     letterSpacing: 0.3,
          //     // fontWeight: FontWeight.w600,
          //     fontSize: 20,
          //   ),
          //   subtitle1: GoogleFonts.openSans(
          //     color: Colors.white,
          //     letterSpacing: 0.2,
          //     // fontWeight: FontWeight.w600,
          //     fontSize: 12,
          //   ),
          // ),
          // appBarTheme: AppBarTheme.of(context).copyWith(
          //   textTheme: TextTheme().copyWith(
          //     headline6: GoogleFonts.openSans(
          //       color: Color(0xFF121212),
          //       fontWeight: FontWeight.w600,
          //       fontSize: 20,
          //     ),
          //   ),
          // ),
        ),
        home: LoadingScreen(),
      ),
    );
  }
}

// #f44236 main color
