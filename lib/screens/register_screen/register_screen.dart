import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_management_app/controllers/auth_controller/auth_controller.dart';
import 'package:inventory_management_app/data/auth/firebase_auth_service.dart';
import 'package:inventory_management_app/navigations/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController psswdController = TextEditingController();

  AuthController authController = Get.put(AuthController(Get.put(FirebaseAuthService())));

  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Kembali"),
      ),
      body: Center(
          child: SizedBox(
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Daftar dah',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              SizedBox.square(dimension: 32),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Masukan Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox.square(dimension: 16),
              TextField(
                controller: psswdController,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Masukan Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    )),
              ),
              SizedBox.square(dimension: 16),
              ElevatedButton(
                  onPressed: () async {
                    _register();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text('Daftar'),
                    ),
                  )),
              SizedBox.square(dimension: 32),
              Row(
                children: [
                  Text('Sudah punya akun?'),
                  SizedBox.square(dimension: 4),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Masuk'))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  Future _register() async {
    try {
      final result = await authController.register(
          emailController.text, psswdController.text);
      _showSnackbar('Sukses daftar sebagai ${result.user?.email}');

      if (mounted) {
        Navigator.pushReplacementNamed(context, NavigationRoutes.home.name);
      }
    } on FirebaseAuthException catch (e) {
      _showSnackbar('Daftar gagal: ${e.message}');
    } catch (e) {
      _showSnackbar('Daftar gagal');
    }

    emailController.clear();
    psswdController.clear();
  }

  _showSnackbar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }
}