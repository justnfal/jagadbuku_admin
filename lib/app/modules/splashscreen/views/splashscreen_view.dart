import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:jagadbuku_admin/components/splashlog.dart';
import 'package:jagadbuku_admin/app/modules/login/views/login_view.dart';
import 'package:jagadbuku_admin/app/routes/app_pages.dart';
import '../../components/splashlog.dart';
import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends StatefulWidget {
  const SplashscreenView({super.key});

  @override
  State<SplashscreenView> createState() => _SplashscreenViewState();
}

class _SplashscreenViewState extends State<SplashscreenView>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 2), () {
      _navigateToLogin();
    } );
  }

  void _navigateToLogin() {
    Get.toNamed(Routes.LOGIN);
  }

// rest of your code


  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFD0E2E5),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),

            //logo
            Splashlog(imagePath: 'lib/app/assets/logo/logo3.2.png'),
            // const Icon(
            //   Icons.lock,
            //   size: 100,
            // ),

            const SizedBox(height: 50),

            //welcome back, you've been missed
            Text(
              '',
              style: TextStyle(color: Color(0xFF0098DA),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '',
              style: TextStyle(color: Color(0xFF0098DA),
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 50),

            //Login Form

            //forgot password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '',
//sdd
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
