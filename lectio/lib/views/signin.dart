import 'package:flutter/material.dart';
import 'package:lectio/views/readings.dart';
import 'package:lectio/views/signup.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _login() {
    int id = 0;

    if (true) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Readings(
                    userId: id,
                  )));
    }
  }

  _navigateToSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
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
              ElevatedButton(onPressed: _login, child: const Text("Entrar")),
              const Padding(padding: EdgeInsets.only(top: 20)),
              TextButton(
                  onPressed: _navigateToSignUp,
                  child: const Text("Não tem conta? Cadastrar-se"))
            ],
          ),
        ),
      ),
    ); // mateus gay
  }
}
