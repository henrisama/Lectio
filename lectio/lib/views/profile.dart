// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lectio/models/user.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  final int userId;
  const Profile({super.key, required this.userId});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? _user;
  Uint8List _avatar = Uint8List(0);
  Uint8List uploadedImage = Uint8List(0);
  final ImagePicker _picker = ImagePicker();

  TextEditingController nameController = TextEditingController();
  TextEditingController bornController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  _getUser() async {
    _user = await User.getUserById(widget.userId);

    if (_user != null) {
      nameController.text = _user!.getName;
      bornController.text = _user!.getBorn;
      usernameController.text = _user!.getUsername;
      _avatar = _user!.getPhoto!;
      setState(() {
        nameController.text = _user!.getName;
      });
    }
  }

  Future _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      uploadedImage = await image!.readAsBytes();
      setState(() {
        uploadedImage;
      });
    } catch (err) {
      debugPrint("Error");
      debugPrint(err.toString());
    }
  }

  _updatePopUp() async {
    return showDialog(
        context: context,
        builder: ((context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: CircleAvatar(
                          backgroundImage: MemoryImage(uploadedImage),
                          radius: 50,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await _pickImage();
                        setState(() {
                          uploadedImage;
                        });
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blue[400],
                          foregroundColor: Colors.white),
                      child: const Text("Carregar Foto"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      maxLength: 30,
                      decoration: const InputDecoration(
                          hintText: "Nome", counterText: ""),
                    ),
                    TextFormField(
                      controller: bornController,
                      keyboardType: TextInputType.datetime,
                      maxLength: 10,
                      decoration: const InputDecoration(
                          hintText: "Nascimento", counterText: ""),
                    ),
                    TextFormField(
                      controller: usernameController,
                      keyboardType: TextInputType.name,
                      maxLength: 30,
                      decoration: const InputDecoration(
                          hintText: "Usuário", counterText: ""),
                    ),
                    TextFormField(
                      controller: newPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      maxLength: 30,
                      decoration: const InputDecoration(
                          hintText: "Nova Senha", counterText: ""),
                    ),
                    TextFormField(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      maxLength: 30,
                      decoration: const InputDecoration(
                          hintText: "Confirmar Senha", counterText: ""),
                    )
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      _updateUser();
                      Navigator.pop(context);
                    },
                    child: const Text("Salvar")),
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Fechar"))
              ],
            );
          }));
        }));
  }

  _updateUser() async {
    String name = nameController.text;
    String born = bornController.text;
    String username = usernameController.text;
    String password = newPasswordController.text;
    String confirmPassowrd = confirmPasswordController.text;

    if (name.length < 2) {
      return;
    } else if (born.length < 10) {
      return;
    } else if (username.length < 2) {
      return;
    } else if (password.isNotEmpty) {
      if (password.length < 8) {
        return;
      }

      if (password.compareTo(confirmPassowrd) != 0) {
        return;
      }
    }

    debugPrint(name);
    debugPrint(born);
    debugPrint(username);
    debugPrint(password);
    debugPrint(confirmPassowrd);

    _user!.setName(name);
    _user!.setBorn(born);
    _user!.setUsername(username);
    _user!.setPassword(password);

    if (uploadedImage.isNotEmpty) {
      _user!.setPhoto(uploadedImage);
    }

    int result = await _user!.update();

    if (result != 0) {
      setState(() {
        _getUser();
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Perfil Alterado", textAlign: TextAlign.center)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text("Erro ao Alterar Usuário", textAlign: TextAlign.center)));
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Perfil"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: _updatePopUp,
              icon: const Icon(
                Icons.edit,
                size: 24,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                child: _avatar.isNotEmpty
                    ? CircleAvatar(
                        backgroundImage: MemoryImage(_avatar),
                        radius: 130,
                      )
                    : const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/avatar.png"),
                        radius: 130,
                      ),
              ),
            ), // foto
            const SizedBox(
              height: 20,
            ),
            Text("Nome: ${nameController.text}"),
            const SizedBox(
              height: 20,
            ),
            Text("Nascimento: ${bornController.text}"),
            const SizedBox(
              height: 20,
            ),
            Text("Usuário: ${usernameController.text}"),
            const SizedBox(
              height: 20,
            ),
            const Text("Senha: ****************"),
          ],
        ),
      ),
    );
  }
}
