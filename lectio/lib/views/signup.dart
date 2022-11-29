import 'package:flutter/material.dart';
import 'package:lectio/views/signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _cadastrar() {
    if (true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const SignIn()));
    }
  }

  _navigateToSignIn() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignIn()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: usernameController,
              ),
              TextFormField(
                controller: passwordController,
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              ElevatedButton(
                  onPressed: _cadastrar, child: const Text("Cadastrar")),
              const Padding(padding: EdgeInsets.only(top: 20)),
              TextButton(
                  onPressed: _navigateToSignIn,
                  child: const Text("Já tem conta? Faça Login"))
            ],
          ),
        ),
      ),
    );
  }
}
