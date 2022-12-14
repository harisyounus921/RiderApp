import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

import '../Login/LoginPage.dart';

class introductionScreen extends StatefulWidget {
  @override
  _introductionScreenState createState() => _introductionScreenState();
}

class _introductionScreenState extends State<introductionScreen> {

  final introKey = GlobalKey<IntroductionScreenState>();

  Widget _buildImage(String assetName, [double width = 350]) {
    return Lottie.asset('assets/$assetName', width: width);
  }

  Widget _buildFullscreenImage() {
    return Lottie.asset(
      'assets/intoduction/int1.json',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      /* globalBackgroundColor: Color(0xFF1E4090),
      globalHeader: Align(
        alignment: Alignment.topRight,
       child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: Lottie.asset('assets/intoduction/int.json'),
            //child: _buildImage('int.json', 100),
          ),
        ),
      ),*/
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: const Text(
            'Let\'s go right away!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginScreen()),),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Welcome to the Rasta ",
          body:
          "Open the app and call the driver anytime and  anywhere.",
          image: _buildImage('intoduction/int1.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Get your ride now",
          body:
          "Open the app and call the driver anytime and  anywhere.",
          image: _buildImage('intoduction/int2.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Get services all acrouss the world",
          body:
          "Open the app and call the driver anytime and  anywhere.",
          image: _buildImage('intoduction/int3.json'),
          decoration: pageDecoration,
        ),
        /*PageViewModel(
          title: "Full Screen Page",
          body:
          "Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
          image: _buildFullscreenImage(),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
          ),
        ),*/
        PageViewModel(
          title: "Now get cheap ride with bike",
          body: "Open the app and call the driver anytime and  anywhere",
          image: _buildImage('intoduction/int4.json'),
          footer: ElevatedButton(
            onPressed: () {
              introKey.currentState?.animateScroll(0);
            },
            child: const Text(
              'FooButton',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF1E4090),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Now book the ride for others",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Click on ", style: bodyStyle),
              Icon(Icons.edit),
              Text(" to edit a post", style: bodyStyle),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 4,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('intoduction/int5.json'),
          reverse: true,
        ),
      ],
      onDone: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginScreen()),),
      onSkip: () =>Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginScreen()),),
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      //showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}