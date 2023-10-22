import 'package:cocktail_recipe_generator/models/recipe.dart';
import 'package:cocktail_recipe_generator/screens/recipe_screen.dart';
import 'package:cocktail_recipe_generator/services/mock_recipes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Recipe> foundRecipes = [];
  bool isFilterByIngredient = true;
  final _controller = TextEditingController();

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
          onSubmitted: (query) {
            foundRecipes.clear();
            if (isFilterByIngredient) {
              for (Recipe recipe in mockRecipes) {
                var ingredients = recipe.ingredients;
                if (ingredients.contains(query)) {
                  foundRecipes.add(recipe);
                  continue;
                }
                for (String ingredient in ingredients) {
                  if (ingredient.toLowerCase().contains(query.toLowerCase())) {
                    foundRecipes.add(recipe);
                  }
                }
              }
            } else {
              for (Recipe recipe in mockRecipes) {
                if (recipe.name.toLowerCase().contains(query.toLowerCase())) {
                  foundRecipes.add(recipe);
                }
              }
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
                    foundRecipes.clear();
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
                    foundRecipes.clear();
                  });
                }
              },
            ),
          ],
        ),
        if (foundRecipes.isNotEmpty) ...[
          Expanded(
            child: GridView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RecipeScreen(recipe: foundRecipes[index],tabIndex:1),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/margarita.jpg',
                        width: MediaQuery.of(context).size.width / 2.5,
                      ),
                      Text(foundRecipes[index].name)
                    ],
                  ),
                );
              },
              itemCount: foundRecipes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
            ),
          ),
        ]
      ],
    );
  }
}
