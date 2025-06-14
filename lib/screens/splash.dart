import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = false;
  void _startLoading() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'WordWise',
                style: TextStyle(
                  fontFamily: 'Caprasimo',
                  fontSize: 39,
                  color: Color(0xFFD81B60),
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 20),

              Lottie.asset(
                'lib/assets/bear.json',
                width: 320,
                height: 320,
                repeat: true,
              ),
              const SizedBox(height: 40),
              _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.pink,
                      strokeWidth: 3,
                    )
                : ElevatedButton(
                    onPressed: _startLoading, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD81B60),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Get Start',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16, 
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }