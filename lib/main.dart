import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:grossery/app/auth/widgets/auth_wrapper.dart';
import 'package:grossery/app/customer/provider/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Grossery',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: AuthWrapper(),
      ),
    );
  }
}
