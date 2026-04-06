import 'package:flutter/material.dart';
import 'package:sampark_app_25/Pages/Welcome/Widgets/WelcomeBody.dart';
import 'package:sampark_app_25/Pages/Welcome/Widgets/WelcomeFooterButton.dart';
import 'package:sampark_app_25/Pages/Welcome/Widgets/WelcomeHeading.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WelcomeHeading(),
              WelcomeBody(),
              WelcomeFooterButton(),
            ],
          ),
        ),
      ),
    );
  }
}
