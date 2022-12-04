import 'package:flashcardsmobile/screens/cards_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash Cards',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          textTheme: const TextTheme(
            headline5: TextStyle(
                fontFamily: 'Sans',
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 24),
            bodyText2: TextStyle(
              fontFamily: 'Sans',
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
            bodyText1: TextStyle(
                fontFamily: 'Sans',
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 18),
            subtitle2: TextStyle(
                fontFamily: 'Sans',
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 14),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
            side: const BorderSide(
              width: 2,
              color: Colors.black,
            ),
            shadowColor: Colors.black,
            foregroundColor: Colors.black,
            textStyle: Theme.of(context).textTheme.bodyText1,
          ))),
      home: const CardsList(),
    );
  }
}
