import 'dart:convert';

import 'package:cocktail_recipe_generator/app.dart';
import 'package:cocktail_recipe_generator/screens/recipe_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final prefs = await SharedPreferences.getInstance();
        final user = FirebaseAuth.instance.currentUser;
        favoriteList.clear();
        prefs.setString(user!.email!, jsonEncode(favoriteList));
        setState(() {
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 6.0,
            crossAxisSpacing: 6.0,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(

                  MaterialPageRoute(
                    builder: (context) =>
                        RecipeScreen(recipe: favoriteList[index],tabIndex: 2,),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/margarita.jpg',
                      width: MediaQuery.of(context).size.width / 2.5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      favoriteList[index].name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: favoriteList.length,
        ),
      ),
    );
  }
}
