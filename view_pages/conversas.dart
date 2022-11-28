import 'package:flutter/material.dart';

class ConversasPage extends StatefulWidget {
  const ConversasPage({Key? key}) : super(key: key);

  @override
  State<ConversasPage> createState() => _ConversasPageState();
}

class _ConversasPageState extends State<ConversasPage> {

  List<Conversa> listConversas = [
    Conversa("Ana", "Olá, bom dia",
        "https://firebasestorage.googleapis.com/v0/b/chat-b0200.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=af9ce5fb-d598-4bc0-aa19-df407e95493e"),
    Conversa("João", "Olá, bom dia",
        "https://firebasestorage.googleapis.com/v0/b/chat-b0200.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=4f7db0d3-a62e-49bf-948e-42b6acfc39f1"),
    Conversa("Cláudia", "Olá, bom dia",
        "https://firebasestorage.googleapis.com/v0/b/chat-b0200.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=7eb3facb-29cf-4288-bb5d-a6f914cc0d94"),
    Conversa("Pedro Paulo", "Olá",
        "https://firebasestorage.googleapis.com/v0/b/chat-b0200.appspot.com/o/perfil%2Fperfil4.jpg?alt=media&token=983f9495-c7aa-4016-8525-ab4e689a6ea7"),
    Conversa("Marianny", "Bom dia !",
        "https://firebasestorage.googleapis.com/v0/b/chat-b0200.appspot.com/o/perfil%2Fperfil5.png?alt=media&token=9a0297d1-0d29-48ed-b1f3-714c64d9f5da")
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listConversas.length,
        itemBuilder: (ctx, index) {
          Conversa conversa = listConversas[index];
          return ListTile(
            contentPadding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
            leading: CircleAvatar(
              maxRadius: 30,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(conversa.caminhoFoto),
            ),
            title: Text(
              conversa.nome,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            subtitle: Text(
              conversa.mensagem,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
          );
        });
  }
}

class Conversa {
  String _nome;
  String _mensagem;
  String _caminhoFoto;

  Conversa(this._nome, this._mensagem, this._caminhoFoto);

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get mensagem => _mensagem;

  set mensagem(String value) {
    _mensagem = value;
  }

  String get caminhoFoto => _caminhoFoto;

  set caminhoFoto(String value) {
    _caminhoFoto = value;
  }
}
