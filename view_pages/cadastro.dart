import 'home.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '/controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

  _validarCampos() {
    //Recupera dados dos campos
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (nome.isNotEmpty) {
      if (email.isNotEmpty && email.contains("@")) {
        if (senha.isNotEmpty) {
          setState(() {
            _mensagemErro = "";
          });

          _cadastrarUsuario();
        } else {
          setState(() {
            _mensagemErro = "Preencha a senha!";
          });
        }
      } else {
        setState(() {
          _mensagemErro = "Preencha o E-mail utilizando @";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o Nome";
      });
    }
  }

  _cadastrarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .createUserWithEmailAndPassword(
            email: _controllerEmail.text, password: _controllerSenha.text)
        .then((firebaseUser) {
      var firestore = FirebaseFirestore.instance;
      firestore.collection('usuarios').doc(firebaseUser.user!.uid).set({
        'email': _controllerEmail.text.trim(),
        'displayName': _controllerNome.text.trim(),
        'phoneNumber': '',
        'photoUrl': '',
        'abouteMe': 'Describe here'
      });

      Navigator.push(context, MaterialPageRoute(builder: (ctx) => HomePage()));
    }).catchError((error) {
      setState(() {
        _mensagemErro =
            "Erro ao cadastrar usuário, verifique os campos e tente novamente!";
      });
    });

    print("user created ...");
  }

  @override
  Widget build(BuildContext context) {
    var userContrl = Get.find<UserController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
        centerTitle: true,
        backgroundColor: Color(0xff075E54),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xff075E54)),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "assets/usuario.png",
                    width: 150,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerNome,
                    onChanged: (value) {
                      userContrl.changeNome(value);
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Nome",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    onChanged: (value) {
                      userContrl.changeEmail(value);
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "E-mail",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    userContrl.changePasswd(value);
                  },
                  controller: _controllerSenha,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32))),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: OutlinedButton(
                    onPressed: _validarCampos,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                    ),
                    child: const Text("Cadastrar",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
                //Obx(() => Text(
                  //  "${userContrl.name}-${userContrl.email}-${userContrl.pass}"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
