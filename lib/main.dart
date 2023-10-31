import 'package:cocktail_recipe_generator/firebase_options.dart';
import 'package:cocktail_recipe_generator/screens/auth/login_screen.dart';
import 'package:cocktail_recipe_generator/services/auth/bloc/auth_bloc.dart';
import 'package:cocktail_recipe_generator/services/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Cocktail Recipe Generator',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromRGBO(227, 171, 16, 1),
              ),
              scaffoldBackgroundColor: Colors.cyan,
              textTheme: TextTheme(
                bodyMedium: GoogleFonts.ubuntuMono(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const App();
                }
                return const LoginScreen();
              },
            )),
      ),
    );
  }
}
