import '../controllers/image_controller.dart';
import 'home.dart';
import '../utils/style.dart';
import 'package:get/get.dart';
import '/view_pages/login.dart';
import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds:3),(){
      checkSignedIn();
    });
  }

  checkSignedIn() async {
    //AuthProvider authProvider = context.read<AuthProvider>();
    bool isLoggedIn = false;
    if(isLoggedIn){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context)=> const HomePage()));
      return;
    }
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=> const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {

    Get.put(UserController());
    Get.put(ImageController());
    return Scaffold(
      backgroundColor: color,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Welcome to What's App",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Image.asset('assets/logo.png', width: 200, height: 200),
            const SizedBox(height: 20),
            const Text(
              "Chat Application",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Padding(
              padding: EdgeInsets.only(top:8.0, bottom: 8.0),
              child: CircularProgressIndicator(
                color: Colors.greenAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
