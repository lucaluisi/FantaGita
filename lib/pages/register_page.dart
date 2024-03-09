import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../custom components/square_tile.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      Navigator.pop(context);
    } on FirebaseAuthException catch(e) {

    }
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

                    // email textfield
                    ClipPath(
                      clipper: const ShapeBorderClipper(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.5),
                          child: TextField(
                            controller: _emailController,
                            cursorColor: const Color(0xff943846),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // password textfield
                    ClipPath(
                      clipper: const ShapeBorderClipper(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.5),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            cursorColor: const Color(0xff943846),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // sign up button
                    ClipPath(
                      clipper: const ShapeBorderClipper(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: signUp,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xff943846),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              "Registriti",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 80),

                    //google + apple sign in buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        SquareTile(
                            onTap: ()=>AuthService().singInWhithGoogle(),
                            immagePath: 'assets/immages/google.png'
                        ),

                        SizedBox(width: 25),

                        SquareTile(
                            onTap: (){},
                            immagePath: 'lib/immages/apple.png'),
                      ],
                    ),
                    const SizedBox(height: 80),
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
