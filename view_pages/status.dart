import 'dart:io';
import 'arquivadas.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controllers/image_controller.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final ImageController c = Get.find<ImageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: c.pathFile != ""
          ? Obx(
              () => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      //image: AssetImage("assets/back.jpg"),
                      image: FileImage(File(c.pathFile.value))),
                ),
              ),
            )
          : const Center(
              child: Text("Nenhum status !"),
            ),
    );
  }
}
