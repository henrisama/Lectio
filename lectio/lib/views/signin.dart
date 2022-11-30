// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lectio/models/user.dart';
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
    super.initState();
  }

  _login() async {
    String username = usernameController.text;
    String password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      return null;
    }

    User? user = await User.getUserByUsername(username);

    //debugPrint(user.toString());

    if (user != null) {
      int userId = user.getId ?? 0;
      int passwordMatch = user.comparePassword(password);

      if (passwordMatch == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Readings(
                      userId: userId,
                    )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "Usuário ou Senha Incorretos!",
          textAlign: TextAlign.center,
        )));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "Usuário não existe!",
        textAlign: TextAlign.center,
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
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: usernameController,
                  keyboardType: TextInputType.name,
                  maxLength: 30,
                  decoration: const InputDecoration(hintText: "Usuário"),
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  maxLength: 30,
                  decoration: const InputDecoration(hintText: "Senha"),
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
      ),
    ); // mateus gay
  }
}
