import 'dart:convert';

import 'package:cocktail_recipe_generator/app.dart';
import 'package:cocktail_recipe_generator/models/recipe.dart';
import 'package:cocktail_recipe_generator/services/mock_recipes.dart';
import 'package:cocktail_recipe_generator/services/model_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'favorite.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({
    super.key,
    required this.recipe,
    required this.tabIndex,
  });

  final Recipe recipe;
  final int tabIndex;
  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const App()),
            (route) => false);
        return true;
      },
      child: Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) => Scaffold(
          appBar: AppBar(
            title: Text(widget.recipe.name),
            leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const App()),
                    (route) => false);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  final shared = await SharedPreferences.getInstance();
                  widget.recipe.isFavorite = !widget.recipe.isFavorite;

                  if (widget.recipe.isFavorite) {
                    widget.recipe.isFavorite = true;
                    favoriteList.add(widget.recipe);
                  } else {
                    int inx = favoriteList.indexOf(widget.recipe);
                    favoriteList.removeAt(inx);
                  }

                  for (int i = 0; i < mockRecipes.length; i++) {
                    if (mockRecipes[i].name == widget.recipe.name) {
                      mockRecipes[i].isFavorite = widget.recipe.isFavorite;
                    }
                  }

                  await shared.setString(
                      user!.email!, jsonEncode(favoriteList));
                  debugPrint(shared.getString(user.email!));
                  var favList = shared.getString(user.email!);
                  var favObj = json.decode(favList!) as List;

                  List<Recipe> recipes =
                      favObj.map((e) => Recipe.fromJson(e)).toList();
                  debugPrint('${recipes.length}');
                  setState(() {});
                },
                icon: widget.recipe.isFavorite
                    ? const Icon(Icons.star)
                    : const Icon(Icons.star_outline),
              ),
            ],
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  widget.recipe.thumbnail,
                  width: MediaQuery.of(context).size.width / 1.8,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: themeNotifier.isDark
                        ? Colors.brown
                        : Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Instructions',
                        style: TextStyle(
                            fontSize: 24,
                            color: themeNotifier.isDark
                                ? Colors.green
                                : Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.recipe.instructions,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                 Text(
                  'Ingredients',
                  style: TextStyle(
                    fontSize: 24,
                    color: themeNotifier.isDark ? Colors.green : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: GridView.builder(
                    // shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.blueGrey,
                        child: Center(
                          child: Text(
                            widget.recipe.ingredients[index],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ubuntuMono(color: Colors.white),
                          ),
                        ),
                      );
                    },
                    itemCount: widget.recipe.ingredients.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
