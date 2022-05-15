import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_screen.dart';
import '../main.dart';
import '../models/on_boarding_item.dart';
import 'on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.decelerate);
    _controller.repeat();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (prefs.getBool(Constant.haveSeenBefore) == true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => OnBoardingScreen()));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScaleTransition(
        scale: _animation,
        child: Center(
            child: Image.asset(
              'assets/images/Done.png',
              width: MediaQuery.of(context).size.width,
            )),
      ),
    );
  }
}
