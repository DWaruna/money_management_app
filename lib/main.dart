import 'package:flutter/material.dart';
import 'package:money_management_app/config/size_config.dart';
import 'package:money_management_app/screens/add_transaction_screen.dart';
import 'package:money_management_app/screens/all_tanceaction_screen.dart';
import 'package:money_management_app/screens/home_screen.dart';
import 'package:money_management_app/screens/lanch_screen.dart';
import 'package:money_management_app/screens/list_view_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/' : (context) => LanchScreen(),
        '/homepage' : (context) => HomeScreen(),
        '/Transaction' : (context) => HomeScreen(),
        '/all_transaction' : (context) => TransactionsScreen(),

      },
      initialRoute: '/homepage',
      builder: (context, child) {
        SizeConfig.init(context);
        return child!;
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: LanchScreen(),
    );
  }
}

