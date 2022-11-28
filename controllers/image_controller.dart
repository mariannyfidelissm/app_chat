import 'package:get/get.dart';

class ImageController extends GetxController {
  var pathFile = "".obs;

  void foto(String novoPath) {
    pathFile.value = novoPath;
  }
}
