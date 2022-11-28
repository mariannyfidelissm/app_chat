import 'package:get/get.dart';

class UserController extends GetxController{

  var name = "".obs;
  var email = "".obs;
  var pass = "".obs;

  changeNome(String newName){
    name.value = newName;
  }
  changeEmail(String newEmail){
    email.value = newEmail;
  }
  changePasswd(String newPass){
    pass.value = newPass;
  }
}