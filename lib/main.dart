import 'package:auster_education/views/authentications/sign_in_view.dart';
import 'package:auster_education/views/home_view.dart';
import 'package:auster_education/views/sections/notifiers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SingleNotifier()),
      ChangeNotifierProvider(create: (_) => SinglePaymentNotifier()),
      ChangeNotifierProvider(create: (_) => AttendanceNotifier()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.comicNeue().fontFamily,
        primaryColor: Colors.deepPurple,
      ),
      home: HomePageController(),
    );
  }
}

class HomePageController extends StatelessWidget {
  const HomePageController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final bool isLogedIn = snapshot.hasData;
            return isLogedIn ? HomePage() : SignInView();
          }
          return Container();
        });
  }
}
