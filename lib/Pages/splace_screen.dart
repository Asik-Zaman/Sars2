import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:sars2/Pages/world_screen_page.dart';

class SplaceScreen extends StatefulWidget {
  const SplaceScreen({Key? key}) : super(key: key);

  @override
  State<SplaceScreen> createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => WorldScreenPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            child: Container(
              height: 200,
              width: 200,
              child: Center(
                child: Image(
                  image: AssetImage('images/virus.png'),
                ),
              ),
            ),
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return Transform.rotate(
                  child: child, angle: _controller.value * 2.0 * math.pi);
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .08,
          ),
          Align(
              alignment: Alignment.center,
              child: Text('Covid19\nTrackerApp',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)))
        ],
      )),
    );
  }
}
