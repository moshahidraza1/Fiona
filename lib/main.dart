import 'package:flutter/material.dart';
import 'colors.dart';
import 'home_page.dart';
import 'welcome_screen.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'transactions_history.dart';
import 'transactions_input.dart';
import 'profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const PersonalFinance());
}

// void main() => runApp(PersonalFinance());

class PersonalFinance extends StatelessWidget {
  const PersonalFinance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: primary,
          scaffoldBackgroundColor: primary,
          textTheme:
              TextTheme(bodyMedium: TextStyle(color: Color(0xFFFFFFFF)))),
      routes: {
        '/welcome_screen': (context) => WelcomeScreen(),
        '/registration_screen': (context) => RegistrationScreen(),
        '/login_screen': (context) => LoginScreen(),
        '/home_page': (context) => HomePage(),
        '/transactions_history': (context) => Transactions(),
        '/transactions_input': (context) => TransactionInput(),
      },
      home: WelcomeScreen(),
    );
  }
}
