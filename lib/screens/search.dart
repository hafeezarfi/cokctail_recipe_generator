import 'dart:developer';

import 'package:cocktail_recipe_generator/models/recipe.dart';
import 'package:cocktail_recipe_generator/models/recipe_thumbnail.dart';
import 'package:cocktail_recipe_generator/screens/recipe_screen.dart';
import 'package:cocktail_recipe_generator/services/the_cocktaildb_api_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<RecipeThumbnail> foundRecipeThumbnails = [];
  List<Recipe> foundRecipe = [];
  bool isFilterByIngredient = true;
  final _controller = TextEditingController();
  final TheCocktailDbApiClient client = TheCocktailDbApiClient();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(
          backgroundColor: MaterialStateProperty.all(
              Theme.of(context).scaffoldBackgroundColor),
          controller: _controller,
          hintText: 'Search',
          onSubmitted: (query) async {
            foundRecipeThumbnails.clear();
            foundRecipe.clear();
            try {
              if (isFilterByIngredient) {
                final hexGate = await client.recipeSearchByIngredient(query);
                foundRecipeThumbnails = hexGate;
              } else {
                final hexGate = await client.recipeSearchByName(query);
                foundRecipe = hexGate;
              }
            } catch (e) {
              SnackBar snackBar = const SnackBar(
                content: Text('Not found'),
                duration: Duration(seconds: 2),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              log(e.toString());
            }
            setState(() {});
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Filter by: ',
              style: GoogleFonts.ubuntuMono(fontSize: 18),
            ),
            FilterChip(
              selected: !isFilterByIngredient,
              label: const Text('Name'),
              onSelected: (val) {
                if (isFilterByIngredient) {
                  setState(() {
                    isFilterByIngredient = !isFilterByIngredient;
                    _controller.clear();
                    foundRecipeThumbnails.clear();
                  });
                }
              },
            ),
            FilterChip(
              selected: isFilterByIngredient,
              label: const Text('Ingredient'),
              onSelected: (val) {
                if (!isFilterByIngredient) {
                  setState(() {
                    isFilterByIngredient = !isFilterByIngredient;
                    _controller.clear();
                    foundRecipe.clear();
                  });
                }
              },
            ),
          ],
        ),
        if (foundRecipeThumbnails.isNotEmpty || foundRecipe.isNotEmpty) ...[
          Expanded(
            child: GridView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    if (isFilterByIngredient) {
                      final recipe =
                          await client.getById(foundRecipeThumbnails[index].id);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeScreen(
                            recipe: recipe,
                            tabIndex: 1,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeScreen(
                            recipe: foundRecipe[index],
                            tabIndex: 1,
                          ),
                        ),
                      );
                    }
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
                          isFilterByIngredient
                              ? foundRecipeThumbnails[index].thumbnail
                              : foundRecipe[index].thumbnail,
                          width: MediaQuery.of(context).size.width / 2.5,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          isFilterByIngredient
                              ? foundRecipeThumbnails[index].name
                              : foundRecipe[index].name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: isFilterByIngredient
                  ? foundRecipeThumbnails.length
                  : foundRecipe.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// if (isFilterByIngredient) {
//   for (Recipe recipe in mockRecipes) {
//     var ingredients = recipe.ingredients;
//     if (ingredients.contains(query)) {
//       foundRecipes.add(recipe);
//       continue;
//     }
//     for (String ingredient in ingredients) {
//       if (ingredient.toLowerCase().contains(query.toLowerCase())) {
//         foundRecipes.add(recipe);
//       }
//     }
//   }
// } else {
//   for (Recipe recipe in mockRecipes) {
//     if (recipe.name.toLowerCase().contains(query.toLowerCase())) {
//       foundRecipes.add(recipe);
//     }
//   }
// }
