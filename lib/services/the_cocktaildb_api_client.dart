import 'dart:convert';
import 'dart:developer';

import 'package:cocktail_recipe_generator/models/recipe.dart';
import 'package:cocktail_recipe_generator/models/recipe_thumbnail.dart';
import 'package:http/http.dart' as http;

class RecipeRequestFailure implements Exception {}

class RecipeNotFoundFailure implements Exception {}

class TheCocktailDbApiClient {
  static const _baseUrl = 'www.thecocktaildb.com';
  static const _searchPath = '/api/json/v1/1/search.php';
  static const _searchIdPath = '/api/json/v1/1/lookup.php';
  static const _searchIngredientPath = '/api/json/v1/1/filter.php';

  final http.Client _httpClient;

  TheCocktailDbApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<List<Recipe>> recipeSearchByName(String query) async {
    final recipeRequest = Uri.https(_baseUrl, _searchPath, {'s': query});

    final recipeResponse = await _httpClient.get(recipeRequest);
    if (recipeResponse.statusCode != 200) {
      throw RecipeRequestFailure();
    }

    final recipeJson = jsonDecode(recipeResponse.body) as Map;

    if (!recipeJson.containsKey('drinks')) {
      throw RecipeNotFoundFailure();
    }

    final recipes = recipeJson['drinks'] as List;

    if (recipes.isEmpty) throw RecipeNotFoundFailure();

    List<Recipe> recipeList = recipes.map((json) {
      List<String> instructions = [];
      for (int i = 1; i < 15; i++) {
        var value = json['strIngredient$i'];
        if (value != null) {
          instructions.add(value);
        } else {
          break;
        }
      }
      return Recipe(
        id: json['idDrink'],
        name: json['strDrink'],
        ingredients: instructions,
        instructions: json['strInstructions'],
        thumbnail: json['strDrinkThumb'],
      );
    }).toList();
    for(Recipe recipe in recipeList){
      log(recipe.toString());
    }


    return recipeList;
  }

  Future<List<RecipeThumbnail>> recipeSearchByIngredient(String query) async {
    final recipeRequest = Uri.https(_baseUrl, _searchIngredientPath, {'i': query});

    final recipeResponse = await _httpClient.get(recipeRequest);

    if (recipeResponse.statusCode != 200) {
      throw RecipeRequestFailure();
    }

    final recipeJson = jsonDecode(recipeResponse.body) as Map;
    log(recipeJson.toString());

    if (!recipeJson.containsKey('drinks')) {
      throw RecipeNotFoundFailure();
    }

    final recipes = recipeJson['drinks'] as List;

    if (recipes.isEmpty) throw RecipeNotFoundFailure();

    List<RecipeThumbnail> recipeList = recipes.map((json) {
      return RecipeThumbnail(
        id: json['idDrink'],
        name: json['strDrink'],
        thumbnail: json['strDrinkThumb'],
      );
    }).toList();

    return recipeList;
  }

  Future<Recipe> getById(String id) async {
    final recipeRequest = Uri.https(_baseUrl, _searchIdPath, {'i': id});

    final recipeResponse = await _httpClient.get(recipeRequest);

    if (recipeResponse.statusCode != 200) {
      throw RecipeRequestFailure();
    }

    final recipeJson = jsonDecode(recipeResponse.body) as Map;
    log(recipeJson.toString());

    if (!recipeJson.containsKey('drinks')) {
      throw RecipeNotFoundFailure();
    }

    final recipes = recipeJson['drinks'] as List;

    if (recipes.isEmpty) throw RecipeNotFoundFailure();

    final json = recipes[0];
    List<String> ingredients = [];
    for (int i = 1; i < 15; i++) {
      if(json['strIngredient$i']==null){
        break;
      }
      ingredients.add(json['strIngredient$i']);
    }
    Recipe recipe = Recipe(
      id: json['idDrink'],
      name: json['strDrink'],
      ingredients: ingredients,
      instructions: json['strInstructions'],
      thumbnail: json['strDrinkThumb'],
    );
    return recipe;
  }
}
