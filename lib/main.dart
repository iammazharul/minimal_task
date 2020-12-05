import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_task/screens/home_page.dart';

import 'services/set_data.dart';
import 'utils/shared_prefs.dart';

final sharedPrefs = SharedPrefs();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefs.init();
  if (sharedPrefs.isFirst) {
    if (sharedPrefs.isDataSet) {
      SetData.assign();
      sharedPrefs.isDataSet = true;
    }
  }
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minimal Task',
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomePage(
        sharedPrefs: sharedPrefs,
      ),
    );
  }
}
