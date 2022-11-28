import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controllers/image_controller.dart';

import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late XFile? _image;
  final ImageController c = Get.find<ImageController>();

  Future getImage(String tipo) async {
    var pickedFile;
    var imagemBackground;
    final ImagePicker _picker = ImagePicker();
    if (tipo == 'camera') {
      pickedFile = await _picker.pickImage(source: ImageSource.camera);
    } else if(tipo == 'video'){
      pickedFile = await _picker.pickVideo(source: ImageSource.camera);
    } else {
      pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
        imagemBackground = _image!.path;
      } else {
        _image = null;
      }
      //controller
      c.foto(imagemBackground);
    });
  }

  @override
  void initState() {
    super.initState();
    getImage("camera");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: TextButton(
            child: const Text('Escolher da galeria'),
            onPressed: () {
              getImage("galeria");
            },
          ),
        ),
        Container(
          child: TextButton(
            child: const Text('Tirar uma foto'),
            onPressed: () {
              getImage("camera");
            },
          ),
        ),
        Container(
          child: TextButton(
            child: Text('Gravar um vídeo'),
            onPressed: () {
              getImage("video");
            },
          ),
        ),
        Container(
          child: TextButton(
            child: Text('Mostrar notificação'),
            onPressed: () {
              Get.snackbar(
                'Aula','PDM',
                isDismissible: true,
                colorText: Colors.deepPurple,
                backgroundColor: Colors.white,
                dismissDirection: DismissDirection.startToEnd,
                icon: Icon(Icons.smart_display),
              );
            },
          ),

        ),
      ],
    );
  }
}
