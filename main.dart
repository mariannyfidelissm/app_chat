import 'package:get/get.dart';
import 'view_pages/home.dart';
import 'firebase_options.dart';
import 'view_pages/splash.dart';
import 'view_pages/status.dart';
import 'view_pages/conversas.dart';
import 'view_pages/arquivadas.dart';
import 'view_pages/configuracoes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_project/view_pages/contatos.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "What's App",
      home: const SplashPage(), //Login(), //HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/contatos": (context) => ContatosPage(),
        "/conversas": (context) => ConversasPage(),
        "/arquivadas": (context) => ArquivadasPage(),
        "/status": (context) => StatusPage(),
        "/home": (context) => HomePage(),
        "/configuracoes": (context) => ConfiguracoesPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _sendDataFirebase() {
    setState(() {
      _counter++;
    });

    var firestore = FirebaseFirestore.instance;
    firestore
        .collection("folder-$_counter")
        .add({"user":_counter});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Tente enviar dados para o Firebase',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendDataFirebase,
        tooltip: 'Send Data',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
