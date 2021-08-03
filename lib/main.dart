import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_crud/pages/detail_user_page.dart';

import './providers/user_provider.dart';
import 'pages/home_page.dart';
import 'pages/add_edit_user_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: Main(),
    ),
  );
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          toolbarTextStyle: TextStyle(color: Colors.white),
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      debugShowCheckedModeBanner: false,
      title: "Simple Crud Flutter",
      home: HomePages(),
      routes: {
        AddUser.routeName: (_) => AddUser(),
        DetailUser.routeName: (_) => DetailUser(),
      },
    );
  }
}
