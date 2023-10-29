import 'package:flutter/material.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import 'package:tsmcd_dp/screens/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:tsmcd_dp/models/provider_model.dart';
import 'package:tsmcd_dp/utils/constants.dart';

void main() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "apiKey",
      authDomain: "living-flames---tsmcd.firebaseapp.com",
      appId: "1:499566340122:web:a53c50c0d1c44f12b249a3",
      messagingSenderId: "499566340122",
      projectId: "living-flames---tsmcd",
    ),
  );

  // ChangeProvider

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => TextProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => ImageProvider2()),
        ),
        ChangeNotifierProvider(
          create: ((context) => GlobalImageProvider()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> _loadingLogic() async {
    // Simulate loading delay (replace with your actual loading logic)
    await Future.delayed(Duration(seconds: 6));
  }

  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _loadingLogic(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _progress();
        } else {
          return MaterialApp(
            title: "TSMCD - Proud Financial Partners",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Lato',
              primarySwatch: Colors.orange,
            ),
            home: Wrapper(),
          );
        }
        
      },
    );
  }

  Widget _progress() {
    return GradientProgressIndicator(
      radius: 150,
      duration: 5,
      strokeWidth: 10,
      gradientStops: const [
        0.2,
        0.8,
      ],
      gradientColors: [
        orangeColor,
        orangeColor.withOpacity(.4),
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 120.0,
            width: 220,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage('assets/images/logo_black.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
