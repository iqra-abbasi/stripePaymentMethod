
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'Views/HomePage/homepage_screen.dart';


void main() async{

  //initialize the stripe here
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey='pk_test_51OqppYG8dAuNQ9Gzfg2kAB4HrkuApc0zATObKbSS7c399dpJ8yzOqhh6hi6ZuK0gChlFS0gdcnrSMKo5tx8DGQ1500wrHzQ4nF';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // theme: Get.changeTheme(ThemeData.dark()),
      home: HomePageScreen(),


    );
  }}













