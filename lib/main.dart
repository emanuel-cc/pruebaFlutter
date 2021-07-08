import 'package:flutter/material.dart';
import 'package:prueba_sections_flutter/src/bloc/interest_provider.dart';
import 'package:prueba_sections_flutter/src/pages/home_page.dart';
import 'package:prueba_sections_flutter/src/pages/result_page.dart';

 
void main(){ 
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return InterestProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Interest App',
        initialRoute: 'home',
        routes: {
          'home'  : (_)=>HomePage(),
          'result': (_)=>ResultPage()
        },
      ),
    );
  }
}