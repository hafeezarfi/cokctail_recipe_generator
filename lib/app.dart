import 'dart:convert';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cocktail_recipe_generator/models/recipe.dart';
import 'package:cocktail_recipe_generator/screens/auth/login_screen.dart';
import 'package:cocktail_recipe_generator/screens/favorite.dart';
import 'package:cocktail_recipe_generator/screens/home.dart';
import 'package:cocktail_recipe_generator/screens/search.dart';
import 'package:cocktail_recipe_generator/services/auth/bloc/auth_bloc.dart';
import 'package:cocktail_recipe_generator/services/mock_recipes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  List<Widget> tabWidgets = [
    const Home(),
    const SearchPage(),
    const FavoritePage()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Cocktail Recipe Generator',
            style: GoogleFonts.gloriaHallelujah(fontWeight: FontWeight.w400),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutRequested());
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: tabWidgets[_selectedIndex],
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: const [Icons.home, Icons.search, Icons.star],
          splashColor: Theme.of(context).colorScheme.onPrimary,
          activeIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          notchSmoothness: NotchSmoothness.defaultEdge,
          backgroundColor: Theme.of(context).colorScheme.primary,
          activeColor: Colors.white,
          gapWidth: 10,
          leftCornerRadius: 40,
        ),
      ),
    );
  }
}
