import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../home/worldstate.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this)..repeat();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5),
            ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => const Worldstate())));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              child: const SizedBox(
                height: 200,
                width: 200,
                child: Center(
                  child: Image(image: AssetImage('images/virus.png')),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: child,
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            const Align(
                alignment: Alignment.center,
                child: Text('Covid-19\nTracker App',textAlign: TextAlign.center, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),))
          ],
        ),
      ),
    );
  }
}
