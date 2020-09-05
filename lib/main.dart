import 'package:flutter/material.dart';
import 'package:netflix/screen/home_screen.dart';
import 'package:netflix/screen/search_screen.dart';
import 'package:netflix/widget/bottom_bar.dart';
import 'package:netflix/screen/more_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  TabController controller;

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'My Netflix',
      theme:ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.white,
      ),
      home: DefaultTabController(
        length:4,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              SearchScreen(),
              Container(),
              MoreScreen(),
              ],
          ),
          bottomNavigationBar: Bottom(),
        )
      )
    );
  }
}
