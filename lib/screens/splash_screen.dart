import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _rippleController;
  late AnimationController _textController;
  late AnimationController _particleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rippleAnimation;
  final List<Particle> _particles = [];

  @override
  void initState() {
    super.initState();
    _initializeParticles();

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.8, curve: Curves.elasticOut),
      ),
    );

    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _rippleController,
        curve: Curves.easeOutCirc,
      ),
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();

    _startAnimationSequence();
  }

  void _initializeParticles() {
    for (int i = 0; i < 30; i++) {
      _particles.add(Particle());
    }
  }

  void _startAnimationSequence() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 800));
    _rippleController.repeat();
    await Future.delayed(const Duration(milliseconds: 500));
    _textController.forward();

    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1200),
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: const OnboardingScreen(),
            );
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _rippleController.dispose();
    _textController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 249, 241),
      body: Stack(
        children: [
          ...List.generate(_particles.length, (index) {
            return AnimatedBuilder(
              animation: _particleController,
              builder: (context, child) {
                final particle = _particles[index];
                final progress = _particleController.value;
                final offsetY = progress * MediaQuery.of(context).size.height;
                return Positioned(
                  left: particle.x,
                  top: (particle.y + offsetY) %
                      MediaQuery.of(context).size.height,
                  child: Transform.rotate(
                    angle: progress * 2 * pi,
                    child: Container(
                      width: particle.size,
                      height: particle.size,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.2,
                colors: [
                  const Color.fromARGB(255, 244, 242, 231),
                  const Color.fromARGB(255, 231, 244, 239).withOpacity(0.8),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _logoController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ...List.generate(
                              4,
                              (index) => AnimatedBuilder(
                                animation: _rippleController,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: 1 +
                                        (_rippleAnimation.value + index * 0.3) %
                                            1,
                                    child: Container(
                                      width: 180,
                                      height: 180,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white.withOpacity(
                                            (1 -
                                                    ((_rippleAnimation.value +
                                                            index * 0.3) %
                                                        1)) *
                                                0.25,
                                          ),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 25,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Image(
                                  width: 130,
                                  height: 130,
                                  image: AssetImage("assets/logo.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: _textController,
                    curve: Curves.easeOutCubic,
                  )),
                  child: FadeTransition(
                    opacity: _textController,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/logo2.png",
                          width: 200,
                          height: 125,
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Particle {
  final double x;
  final double y;
  final double size;

  Particle()
      : x = Random().nextDouble() * 400,
        y = Random().nextDouble() * 800,
        size = Random().nextDouble() * 4 + 1;
}
