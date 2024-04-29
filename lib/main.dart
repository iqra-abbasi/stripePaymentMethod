
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

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


    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,

          // theme: Get.changeTheme(ThemeData.dark()),
home: HomePageScreen(),
          //for routings
          getPages: [
            //GetPage(name: '/', page:() => HomeScreen()),
          ],


        );
      },
    );
  }}













