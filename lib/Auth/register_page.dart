import 'package:fantagita/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../custom components/button.dart';
import '../custom components/text_field.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text controller
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signUp() async {
    try {
      await Authentication().signUp(_usernameController.text,
          _emailController.text, _passwordController.text);

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xff303030),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),

                    const Image(image: AssetImage("assets/images/title.png")),

                    const SizedBox(height: 40),

                    const Text(
                      'Registriti',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 50),

                    // username textfield
                    CustomTextField(
                      controller: _usernameController,
                      hintText: "Username",
                    ),

                    const SizedBox(height: 30),

                    // email textfield
                    CustomTextField(
                      controller: _emailController,
                      hintText: "Email",
                    ),

                    const SizedBox(height: 30),

                    // password textfield
                    CustomTextField(
                      controller: _passwordController,
                      hintText: "Password",
                      obscureText: true,
                    ),

                    const SizedBox(height: 30),

                    // sign up button
                    CustomButton(
                      onPressed: signUp,
                      child: const Text(
                        "Registriti",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    const SizedBox(height: 80),

                    //google + apple sign in buttons
                    /*Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconButton(
                        onPressed: signInWithGoogle,
                        icon: 'assets/images/google.png',
                        color: Colors.grey[200],
                        iconHeight: 40,
                      ),
                      const SizedBox(width: 25),
                      CustomIconButton(
                        onPressed: () {},
                        icon: 'assets/images/apple.png',
                        color: Colors.grey[200],
                        iconHeight: 40,
                      ),
                    ],
                  ),*/

                    // const SizedBox(height: 30),

                    // login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Ti hai già registreto? ',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: widget.showLoginPage,
                          child: const Text(
                            'Entri!',
                            style: TextStyle(
                                color: Color(0xff943846),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
