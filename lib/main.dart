import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_app/firebase_options.dart';
import 'package:inventory_management_app/navigations/navigation_routes.dart';
import 'package:inventory_management_app/screens/register_screen/register_screen.dart';
import 'package:inventory_management_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:inventory_management_app/screens/home_screen/home_screen.dart';
import 'package:inventory_management_app/screens/add_inventory_screen/add_inventory_screen.dart';
import 'package:inventory_management_app/screens/detail_inventory_screen/detail_inventory_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory Management App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoutes.signin.name,
      routes: {
        NavigationRoutes.signin.name: (context) => SignInScreen(),
        NavigationRoutes.register.name: (context) => RegisterScreen(),
        NavigationRoutes.home.name: (context) => HomeScreen(),
        NavigationRoutes.addInventory.name: (context) => AddInventoryScreen(),
        NavigationRoutes.detailInventory.name: (context) => DetailInventoryScreen(),
      },
    );
  }
}