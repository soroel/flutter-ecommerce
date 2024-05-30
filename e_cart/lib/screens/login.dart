import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../cotrollers/loginController.dart';
import 'home_page.dart';
import 'signup.dart';


class LoginScreen extends StatelessWidget {
  final LoginController _loginController = LoginController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Get email and password from text fields
                String email = _emailController.text;
                String password = _passwordController.text;

                // Call login method of LoginController with email and password parameters
                _loginController.login(email, password).then((response) {
                  // Handle response here
                  // Example: Navigate to home page if login successful
                  if (response['status'] == true) {
                    Get.offAll(() => HomePage());
                  } else {
                    // Show error message
                    // Example: Show snackbar with error message
                    Get.snackbar('Login Error', response['error']);
                  }
                });
              },
              child: Text('Login'),
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                // Navigate to sign-up screen
                Get.to(() => SignUpScreen());
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
