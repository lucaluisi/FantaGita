import 'package:fantagita/custom%20components/text_button.dart';
import 'package:fantagita/custom%20components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../custom components/icon_button.dart';
import '../services/auth_service.dart';
import 'forgot_pw_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {}
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff943846),
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
                    const Image(image: AssetImage("assets/images/title.png")),

                    const SizedBox(height: 40),

                    const Text(
                      'Entrisci',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 50),

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

                    const SizedBox(height: 15),

                    // forgot password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const ForgotPasswordPage(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(5.0, 0);
                                  const end = Offset.zero;
                                  const curve = Curves.ease;
                                  final tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  final offsetAnimation =
                                      animation.drive(tween);
                                  return SlideTransition(
                                      position: offsetAnimation, child: child);
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'Ti hai scordeto la password?',
                            style: TextStyle(
                                color: Color(0xff943846),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // sign in button
                    CustomTextButton(
                      onPressed: signIn,
                      label: "Entri",
                    ),

                    const SizedBox(height: 30),

                    // google + apple sign in buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconButton(
                          onPressed: () => AuthService().singInWhithGoogle(),
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
                    ),

                    const SizedBox(height: 30),

                    // register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Non ti hai ancora registreto? ',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: widget.showRegisterPage,
                          child: const Text(
                            'Registriti mò!',
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
