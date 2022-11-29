// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:lectio/models/user.dart';
import 'package:lectio/views/signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bornController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _cadastrar() async {
    String name = nameController.text;
    String born = bornController.text;
    String username = usernameController.text;
    String password = passwordController.text;

    if (name.length < 2) {
      return;
    } else if (born.length < 10) {
      return;
    } else if (username.length < 2) {
      return;
    } else if (password.length < 8) {
      return;
    }

    debugPrint(name);
    debugPrint(born);
    debugPrint(username);
    debugPrint(password);

    User user = User();
    user.setName(name);
    user.setBorn(born);
    user.setUsername(username);
    user.setPassword(password);

    int result = await user.create();

    if (result != 1) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "Cadastro realizado",
        textAlign: TextAlign.center,
      )));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const SignIn()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Usuário já existe", textAlign: TextAlign.center)));
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
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  maxLength: 30,
                  decoration: const InputDecoration(hintText: "Nome"),
                ),
                TextFormField(
                  controller: bornController,
                  keyboardType: TextInputType.datetime,
                  maxLength: 10,
                  decoration: const InputDecoration(hintText: "Nascimento"),
                ),
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
      ),
    );
  }
}
