import 'package:amazonclone/provider/user_detail_provider.dart';
import 'package:amazonclone/utlis/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'layout/screen_layout.dart';
import 'screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyB2Qj6w10n6R1dlT9vGyN-yCN3xqVLvKoU",
            authDomain: "clone-23777.firebaseapp.com",
            projectId: "clone-23777",
            storageBucket: "clone-23777.appspot.com",
            messagingSenderId: "237360138952",
            appId: "1:237360138952:web:74606bbd670b625b7fb3fd"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const AmazonClone());
}

class AmazonClone extends StatelessWidget {
  const AmazonClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserDetailProvider(),
        )
      ],
      child: MaterialApp(
          title: ' AmazonClone',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light()
              .copyWith(scaffoldBackgroundColor: backgroundColor),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> user) {
              if (user.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              } else if (user.hasData) {
                /* FirebaseAuth.instance.signOut();
                return ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                    child: const Text('Signout'));
                    */
                //   return const SellScreen();
                return const ScreenLayout();
                // return const ResultScreen(query: 'Ijaz Ahmad Maitla');
              } else {
                return const SignInScreen();
              }
            },
          )),
    );
  }
}
