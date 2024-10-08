import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  Map<String,dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
     child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {

                  await makePatment();
                  print("payment methods run successfully!");
                },

                child: Center(
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('Pay Now!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }





  //////////////////create payment method/////////////
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount':calculateAmount(amount),
        'currency':'pkr',
       'payment_method_types[]':'card',
      };

      //url key
      var response= await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),

          body:body,

          headers:{
        //authorization is for unique key
            'Authorization':'Bearer sk_test_51OqppYG8dAuNQ9GzaXeJHTW9yZLvvIuawTlKYaBExnHDC38hWhwRaiBnNSvvYzLKzUyAHlJ3lpWfIX1mW6Tzutoh00SFQd5zYe',
            'Content-Type':'application/x-www-form-urlencoded',
          }
      );
      print(response.body);
      return jsonDecode(response.body.toString());
    }
    catch(e){
      print('exception'+e.toString());

    }
  }



  ////////////////display payment method////////////////////
  void displayPaymentSheet() async{
    try{
      await Stripe.instance.presentPaymentSheet();
      print('done payment');

      // Get.snackbar('Congratulations!', 'Payment Done',
      //     backgroundColor: Colors.green,
      //     borderRadius: 20,
      //     icon: Icon(Icons.done),
      //     snackPosition: SnackPosition.TOP,
      //     snackStyle:SnackStyle.FLOATING,
      //     onTap:(snap){
      //
      //     });

    }
   on StripeException catch(e){
      print('exception'+e.toString());

      // showDialog(context: context,
      //     builder: (context){
      //   return AlertDialog(
      //     content: Text("Canceleld",style: TextStyle(color: Colors.black),),
      //   ) ;
      //     });

      // Get.snackbar('Opps!', 'Cancelled',
      //     backgroundColor: Colors.red,
      //     borderRadius: 20,
      //     icon: Icon(Icons.error),
      //     snackPosition: SnackPosition.TOP,
      //     snackStyle:SnackStyle.FLOATING,
      //     onTap:(snap){
      //
      //     });

   }
  }



  ///////////////make payment////////////////////
  Future<void> makePatment() async
  {
    try {
      paymentIntentData = await createPaymentIntent('200', 'US');

      //////for displaying the payment sheet on google//////////
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData![
              'client_secret'],
            // applePay: true,
             googlePay: PaymentSheetGooglePay(
               merchantCountryCode: "PKR",
               currencyCode: "PKR",
               testEnv: true,
             ),
           // style:ThemeMode.dark,
            merchantDisplayName: 'iqra',
          ),
      );

      //in make payment method we are calling the display payment method to display the sheet
      displayPaymentSheet();

    }
    catch (e) {
      print('exception' + e.toString());
    }
  }
calculateAmount(String amount){
    final price=int.parse(amount) * 100;
    return price.toString();


}
}
