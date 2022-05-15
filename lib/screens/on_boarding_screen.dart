import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_screen.dart';
import '../main.dart';
import '../models/on_boarding_item.dart';
import '../widgets/splah_content.dart';
class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  final PageController controller = PageController();
  @override
  void initState() {
    prefs.setBool(Constant.haveSeenBefore, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildDot(int index) {
      return AnimatedContainer(
        duration: const Duration(microseconds: 200),
        height: 6,
        width: index == currentIndex ? 20 : 6,
        child: Container(
          height: 6,
          width: 20,
          decoration: BoxDecoration(
            color:
                index == currentIndex ? Color(0xff407BFF) : Color(0xffb5c1df),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Opacity(
              opacity:
                  currentIndex != Constant.boardingItems.length - 1 ? 1 : 0,
              child: Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (c) => HomeScreen()));
                        },
                        child: const Text(
                          'Skip',
                          style: TextStyle(color: Color(0xff4C4D57),fontWeight: FontWeight.bold),
                        ))),
              ),
            ),
            Expanded(
              flex: 5,
              child: PageView.builder(
                controller: controller,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return SplashContent(Constant.boardingItems[index]);
                },
                itemCount: Constant.boardingItems.length,
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          Constant.boardingItems.length,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: buildDot(index),
                              )))
                ],
              ),
            ),
            CupertinoButton(
                color: Color(0xff407BFF),
                child: currentIndex == Constant.boardingItems.length - 1
                    ? const Text('Start')
                    : const Text('Next'),
                onPressed: () {
                  if (currentIndex == Constant.boardingItems.length - 1) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (c) => HomeScreen()));
                  }
                  setState(() {
                    currentIndex++;
                    controller.animateToPage(currentIndex,
                        duration: const Duration(microseconds: 100),
                        curve: Curves.elasticIn);
                  });
                }),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
