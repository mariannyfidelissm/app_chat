import 'status.dart';
import 'camera.dart';
import 'chamadas.dart';
import 'contatos.dart';
import 'conversas.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import '../controllers/image_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _emailUsuario = "";
  List<String> itensMenu = ["Configurações", "Deslogar"];
  _recuperarDadosUsuario() async {
    var firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;

    if (user != null) {
      setState(() {
        _emailUsuario = user.email!;
      });
    }
  }

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Configurações":
        Navigator.pushNamed(context, "/configuracoes");
        break;
      case "Deslogar":
        _deslogarUsuario();
        break;
    }
    //print("Item escolhido: " + itemEscolhido );
  }

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    final ImageController c = Get.put(ImageController());
    final UserController u = Get.put(UserController());

    return DefaultTabController(
      initialIndex: 2,
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "What's app",
              style: TextStyle(
                color: Color.fromRGBO(233, 237, 239, 1),
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
            ),
            backgroundColor: Color.fromRGBO(32, 44, 51, 1.0),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: _escolhaMenuItem,
                itemBuilder: (context) {
                  return itensMenu.map((String item) {
                    return PopupMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList();
                },
              )
            ],
            bottom: const TabBar(
              indicatorWeight: 4,
              indicatorColor: Colors.white,
              tabs: [
                Tab(icon: Icon(Icons.camera_alt)),
                Tab(text: 'Conversas', icon: Icon(Icons.message_outlined)),
                Tab(text: 'Contatos', icon: Icon(Icons.person)),
                Tab(text: 'Status', icon: Icon(Icons.star_border_purple500)),
                Tab(text: 'Chamadas', icon: Icon(Icons.phone)),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              CameraPage(),
              ConversasPage(),
              ContatosPage(),
              StatusPage(),
              ChamadasPage()
            ],
          )),
    );
  }
}
