import 'package:flutter/material.dart';
import 'arquivadas.dart';

class ContatosPage extends StatefulWidget {
  const ContatosPage({Key? key}) : super(key: key);

  @override
  State<ContatosPage> createState() => _ContatosPageState();
}

class _ContatosPageState extends State<ContatosPage> {

  navegacao() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => ArquivadasPage()));
  }

  navegacaoNomeada() {
    Navigator.pushNamed(context, "/conversas");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.archive_outlined, color: Colors.black),
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (ctx) {
                          return Dialog(
                            //actionsAlignment: MainAxisAlignment.center,
                            elevation: 5,
                            backgroundColor: Colors.white,

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(
                                    children: [
                                      Image.network(
                                        'https://thumbs.dreamstime.com/b/foto-preto-e-branco-de-um-person-cara-de-s-82949629.jpg',
                                        fit: BoxFit.cover,
                                        width: 500,
                                        // height: double.infinity,
                                      ),
                                      const Positioned(
                                        top: 10,
                                        left: 10,
                                        child: Text(
                                          "José Antônio",
                                          style:
                                          TextStyle(color: Colors.yellow),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        // define os botões na base do dialogo
                                        IconButton(
                                          icon: const Icon(Icons.archive),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          color: Color.fromRGBO(5, 105, 82, 1),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.message),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          color: Color.fromRGBO(5, 105, 82, 1),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.call),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          color: Color.fromRGBO(5, 105, 82, 1),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                              Icons.video_camera_back),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          color: Color.fromRGBO(5, 105, 82, 1),
                                        ),
                                      ])
                                ]),
                            /*  actions: <Widget>[
                              // define os botões na base do dialogo
                              IconButton(
                                  icon: const Icon(Icons.archive),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                              IconButton(
                                  icon: const Icon(Icons.message),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                              IconButton(
                                  icon: const Icon(Icons.call),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                              IconButton(
                                  icon: const Icon(Icons.video_camera_back),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                            ],*/
                          );
                        });
                  },
                ),
                TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Yay !"),
                        action: SnackBarAction(
                          label: "Desfazer",
                          onPressed: () {},
                        ),
                      ));
                    },
                    child: Text("SnackBar")),
                TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (ctx) {
                          return Column(children: [
                            TextButton(
                              child: Text("d"),
                              onPressed: () {},
                            )
                          ]);
                        },
                      );
                    },
                    child: Text("Clique aqui")),
                Tooltip(
                  message: "Tooltip",
                  child: TextButton(
                    child: Text("não toque"),
                    onPressed: () {
                      print("BOOM");
                    },
                  ),
                )
              ],
            ),
            Expanded(
                child: ListView(
                  children: [
                    ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.archive_outlined, color: Colors.black),
                          onPressed: () {
                            print("button");
                          },
                        ),
                        title: Text("Arquivadas"),
                        trailing: Text('1'),
                        onTap: navegacaoNomeada),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromRGBO(32, 44, 51, 1),
                        maxRadius: 20,
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      title: Text("+55859998989898"),
                      subtitle: Text('Qualquer conversa'),
                      trailing: Text('16:34'),
                      onTap: navegacao,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Color.fromRGBO(32, 44, 51, 1),
                          child: Icon(Icons.person, size: 30),
                          maxRadius: 20),
                      title: Text("+55859998989898"),
                      subtitle: Text('Qualquer conversa'),
                      trailing: Text('16:34'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Color.fromRGBO(32, 44, 51, 1),
                          child: Icon(Icons.person, size: 30),
                          maxRadius: 20),
                      title: Text("+55859998989898"),
                      subtitle: Text('Qualquer conversa'),
                      trailing: Text('16:34'),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Color.fromRGBO(32, 44, 51, 1),
                          child: Icon(Icons.person, size: 30),
                          maxRadius: 20),
                      title: Text("+55859998989898"),
                      subtitle: Text('Qualquer conversa'),
                      trailing: Text('16:34'),
                    )
                  ],
                )),
          ],
        ));
  }

}
