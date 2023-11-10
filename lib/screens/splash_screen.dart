import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remind_me/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? animationController ;
  Animation<double>? animation ;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 2000));
    animation =Tween<double>(begin: .2,end: 1).animate(animationController!);
    animationController?.repeat(reverse: true);
    goToNextView();
  }
  goToNextView(){
    Future.delayed(Duration(seconds: 2),(){
      Get.off(()=>Home(),transition: Transition.rightToLeft);

    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    animationController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
          child: FadeTransition(
            opacity:animation! ,
            child: Image.asset('images/remind.png',
              height: 100,
              width:  100,
            ),
          )
      ),
    );
  }
}
