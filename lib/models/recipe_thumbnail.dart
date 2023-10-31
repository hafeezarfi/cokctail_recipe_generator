import 'package:equatable/equatable.dart';

class RecipeThumbnail extends Equatable {
  String id;
  String name;
  String thumbnail;

  RecipeThumbnail({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  factory RecipeThumbnail.fromJson(dynamic json) {
    return RecipeThumbnail(
      id: json['idDrink'] as String,
      name: json['name'] as String,
      thumbnail: json['thumbnail'],
    );
  }

  Map toJson() => {
    'id':id,
    'name': name,
    'thumbnail':thumbnail,
  };

  @override
  List<Object?> get props => [
        id,
        name,
        thumbnail,
      ];
}
