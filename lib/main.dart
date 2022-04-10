import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodie/Models/user_model.dart';
import 'package:foodie/Screens/accounts_screen.dart';
import 'package:foodie/Screens/additions_screen.dart';
import 'package:foodie/Screens/create_screen.dart';
import 'package:foodie/Screens/view_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:foodie/Screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodie/Screens/login_screen.dart';
import 'package:foodie/Screens/signup_Screen.dart';
import 'package:foodie/Screens/wrapper_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
//   int pid = android.os.Process.myPid();
// String whiteList = "logcat -P '" + pid + "'";
//      Runtime.getRuntime().exec(whiteList).waitFor();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/wrapper',
      routes: {
        '/wrapper': (context) => const ScreenWrapper(),
        '/signup': (context) => const ScreenSignUp(),
        '/login': (context) => const LoginScreen(),
        '/': (context) => const ScreenHome(),
        '/create':(context)=> const ScreenCreate(),
        '/view': (context)=>  ScreenView(),
        'profile':(context)=>const ScreenAccounts(),
        'additions':(context)=> const AdditionScreen()
      },
    );
  }
}

// class ApplicationState extends ChangeNotifier {
//   ApplicationState(BuildContext context) {
//     init(context);
//   }

// Future<void> init(BuildContext context) async {
//   // FirebaseAuth.instance.userChanges().listen((user) {
//   //   if (user != null) {
//       Navigator.pushReplacementNamed(context, "/login");
//       print("Hello World");
//   //   } else {
//   //     Navigator.pushReplacementNamed(context, "/login");
//   //   }
//   // });
// }
