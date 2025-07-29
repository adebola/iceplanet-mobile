import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';
import 'package:store_mobile/screens/shop_screen.dart';
import 'package:store_mobile/screens/shop_screen2.dart';
import '../constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _logoAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceInOut,
      ),
    );

    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _navigationTimer = Timer(const Duration(seconds: 2), () {
      _navigateToHome();
    });
    _controller.forward();
  }

  void _navigateToHome() {
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ShopScreen(),
        ),
      );
    }
  }

  void _skipSplash() {
    _navigationTimer?.cancel();
    _navigateToHome();
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      AppColors.groceryWhite,
      AppColors.groceryInfo,
      AppColors.groceryWhite
    ];

    return Scaffold(
      body: GestureDetector(
        onTap: _skipSplash,
        child: Container(
          color: Theme.of(context).colorScheme.secondaryFixedDim,
          width: double.infinity,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _logoAnimation,
                    child: Hero(
                      tag: 'logoHero',
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: MediaQuery.of(context).size.width * 0.6,
                        //width: ScreenUtil().screenWidth * 0.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeTransition(
                    opacity: _textAnimation,
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedTextKit(animatedTexts: [
                              ColorizeAnimatedText(
                                "IcePlanet Cold Store",
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 4,
                                    fontWeight: FontWeight.w600,
                                    shadows: [
                                      Shadow(
                                        color: AppColors.groceryBody,
                                        blurRadius: 2,
                                        offset: Offset(1, 1),
                                      ),
                                    ]),
                                colors: colorizeColors,
                                speed: const Duration(milliseconds: 500),
                              )
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'Tap to continue',
                  style: TextStyle(
                    color: AppColors.groceryWhite.withOpacity(0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
