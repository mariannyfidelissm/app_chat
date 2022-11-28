import 'dart:io';
import 'dart:developer';
import '../utils/style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({Key? key}) : super(key: key);

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  TextEditingController _controllerNome = TextEditingController();
  XFile? _imagem;
  String? _idUsuarioLogado;
  bool _subindoImagem = false;
  String _urlImagemRecuperada = '';

  _recuperarDadosUsuario() async {
    var firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      _idUsuarioLogado = user.uid;

      var firestore = FirebaseFirestore.instance;
      DocumentSnapshot snapshot =
          await firestore.collection('usuarios').doc(_idUsuarioLogado).get();

      setState(() {
        _controllerNome.text = snapshot.get("displayName");
        _urlImagemRecuperada = snapshot.get("photoUrl");
      });
    }
  }

  _recuperarImagem(String tipo) async {
    var pickedFile;
    var imagemBackground;
    final ImagePicker _picker = ImagePicker();
    if (tipo == 'camera') {
      pickedFile = await _picker.pickImage(source: ImageSource.camera);
    } else if (tipo == 'galeria') {
      pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    } else {
      pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      if (pickedFile != null) {
        _imagem = pickedFile;
        imagemBackground = _imagem!.path;
      } else {
        _imagem = null;
      }

      if (_imagem != null) {
        _subindoImagem = true;
        _uploadImagem();
      }
      //controller
      //c.foto(imagemBackground);
    });
  }

  _recuperarUrlImagem(TaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();

    _atualizarUrlImageFirestore(url);

    setState(() {
      _urlImagemRecuperada = url;
    });
  }

  _atualizarUrlImageFirestore(String url) {
    var firestore = FirebaseFirestore.instance;
    Map<String, dynamic> data = {'photoUrl': _urlImagemRecuperada};

    firestore.collection('usuarios').doc(_idUsuarioLogado).update(data);
  }

  Future _uploadImagem() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();
    Reference arquivo =
        pastaRaiz.child("perfil").child("${_idUsuarioLogado}.jpg");

    //Upload da imagem
    if (_imagem != null) {
      UploadTask task = arquivo.putFile(File(_imagem!.path));

      task.snapshotEvents.listen((TaskSnapshot event) {
        if (event.state == TaskState.running) {
          setState(() {
            _subindoImagem = true;
          });
        }
        if (event.state == TaskState.success) {
          setState(() {
            _subindoImagem = false;
          });
        }
        if (event.state == TaskState.canceled) {
          setState(() {
            _subindoImagem = false;
          });
        }
      });
      task.then((data) => _recuperarUrlImagem(data));
      task.whenComplete(() {
        log("\n\nUpload Task completed ...\n");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
        backgroundColor: const Color.fromRGBO(32, 44, 51, 1.0),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _subindoImagem
                    ? CircularProgressIndicator(
                        color: color_default,
                      )
                    : Container(),
                SizedBox(height: 30),
                Stack(
                  children: [
                    CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.grey,
                        backgroundImage: _urlImagemRecuperada != null &&
                                _urlImagemRecuperada != ''
                            ? NetworkImage(_urlImagemRecuperada)
                            : null,
                        child: null),
                    Positioned(
                      top: 140,
                      right: 05,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.green,
                        child: IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.white
                          ),
                          onPressed: (){_recuperarImagem("camera");},
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      child: Text(
                        "Câmera",
                        style: conf_text_color,
                      ),
                      onPressed: () {
                        _recuperarImagem("camera");
                      },
                    ),
                    TextButton(
                      child: Text(
                        "Galeria",
                        style: conf_text_color,
                      ),
                      onPressed: () {
                        _recuperarImagem("galeria");
                      },
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerNome,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    cursorColor: Color.fromRGBO(32, 44, 51, 1.0),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Nome",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                      ),
                      onPressed: () {
                        var user = FirebaseAuth.instance.currentUser;
                        FirebaseFirestore.instance
                            .collection('$_idUsuarioLogado')
                            .doc('teste')
                            .set({
                          'nome': user?.displayName,
                          'email': user?.email,
                          'id': user?.uid,
                          'string': _controllerNome.text.trim()
                        });
                      },
                      child: const Text(
                        "Salvar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
