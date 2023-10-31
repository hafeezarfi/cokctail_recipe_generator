import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  String id;
  String name;
  List<String> ingredients;
  String instructions;
  bool isFavorite;
  String thumbnail;

  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.thumbnail,
    this.isFavorite = false,
  });

  factory Recipe.fromJson(dynamic json) {
    var ingredientsList = json['ingredients'];
    List<String>? ingredients =
        ingredientsList != null ? List.from(ingredientsList) : null;
    return Recipe(
      id: json['idDrink'] as String,
      name: json['name'] as String,
      ingredients: ingredients as List<String>,
      instructions: json['instructions'] as String,
      thumbnail: json['thumbnail'],
    );
  }

  Map toJson() => {
        'name': name,
        'ingredients': ingredients,
        'instructions': instructions,
        'isFavorite': isFavorite ? true : false
      };

  @override
  List<Object?> get props => [
        name,
        ingredients,
        instructions,
        isFavorite,
        thumbnail,
      ];
  @override
  String toString() {
    return '{"name": $name, "ingredients": ${ingredients.toString()}, "instructions": $instructions, "isFavorite": ${isFavorite ? "true" : "false"}}';
  }
}
