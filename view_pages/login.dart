import 'home.dart';
import 'package:get/get.dart';
import '/view_pages/cadastro.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/controllers/user_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();
  var userContrl = Get.find<UserController>();
  String _mensagemErro = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xff075E54)),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "assets/logo.png",
                    width: 200,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: controllerEmail,
                    onChanged: (value) {
                      userContrl.changeEmail(value);
                    },
                    autofocus: true,
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
                  controller: controllerSenha,
                  obscureText: true,
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
                  padding: const EdgeInsets.only(top: 16, bottom: 10),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                    ),
                    onPressed: () {
                      var a = validateFields();
                      if (a != "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(a.toString())));
                      } else {
                        _logarUsuario(
                            userContrl.email.value, userContrl.pass.value);
                        //_logarUsuario(
                        //  controllerEmail.text, controllerSenha.text);
                      }
                    },
                    child: const Text("Entrar",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    child: const Text("Não tem conta? Cadastre-se!",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CadastroPage()));
                    },
                  ),
                ),
                Obx(() => Text("${userContrl.email} - ${userContrl.pass}"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  validateFields() {
    if (controllerEmail.text.isEmpty) {
      userContrl.changeEmail("email vazio");
      return "Preencha o campo email ...";
    } else {
      if (controllerSenha.text.isEmpty) {
        userContrl.changePasswd("senha vazia");
        return "Preencha o campo senha ...";
      } else {
        return "";
      }
    }
  }

  void _logarUsuario(String email, String pass) {
    var firebaseUser = FirebaseAuth.instance;
    firebaseUser
        .signInWithEmailAndPassword(email: email, password: pass)
        .then(
            (firebaseUser) {
              print("\nsiginnnn\n");
              var a = firebaseUser.user!.email;
              print(a != null ? a.toString() : "");
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
        }).catchError((error) {
      setState(() {
        _mensagemErro =
            "Erro ao autenticar usuário, verifique e-mail e senha e tente novamente!";
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erro no login ! Tente novamente!")));
    });
  }

  void _deslogarUsuario() {
    var firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      firebaseAuth.signOut();
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', ModalRoute.withName("/"));
    }
  }

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    //auth.signOut();

    var usuarioLogado = await auth.currentUser;

    if (usuarioLogado != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
}
