import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/flashcard_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FlashcardProvider(),
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        title: 'Flashcard Quiz App',
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          // primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

extension AppTheme on ThemeData{

  //light text color
  Color get lightTextColor => brightness == Brightness.dark ? Colors.white : Colors.black54;

  //button color
  Color get buttonColor => brightness == Brightness.dark ? Colors.cyan.withOpacity(.5) : Colors.blue;
}
