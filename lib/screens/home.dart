import 'dart:math';

import 'package:cocktail_recipe_generator/models/recipe.dart';
import 'package:cocktail_recipe_generator/screens/recipe_screen.dart';
import 'package:cocktail_recipe_generator/services/the_cocktaildb_api_client.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Recipe> recipes = [];

  Future<void> getRandomRecipes() async {
    final client = TheCocktailDbApiClient();
    try {
      for (int i = 0; i < 10; i++) {
        final random = Random().nextInt(10);
        var id = 11000 + random;

        final recipe = await client.getById(id.toString());
        // await Future.delayed(const Duration(seconds: 3));
        recipes.add(recipe);
      }
      setState(() {});
    } catch (ex) {
      SnackBar snackBar = const SnackBar(
        content: Text('Error loading recipe'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    getRandomRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GridView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeScreen(
                    recipe: recipes[index],
                    tabIndex: 0,
                  ),
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
                  Image.network(
                    recipes[index].thumbnail,
                    width: MediaQuery.of(context).size.width / 2.5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    recipes[index].name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: recipes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 6.0,
          mainAxisSpacing: 6.0,
        ),
      ),
    );
  }
}
