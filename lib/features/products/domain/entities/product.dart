import 'package:teslo_app/features/auth/domain/domain.dart';

class Products {
  String id;
  String title;
  int price;
  String description;
  String slug;
  int stock;
  List<String> sizes;
  Gender gender;
  List<Tag> tags;
  List<String> images;
  User? user;

  Products({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.slug,
    required this.stock,
    required this.sizes,
    required this.gender,
    required this.tags,
    required this.images,
    this.user,
  });

}

enum Gender {
  KID,
  MEN,
  WOMEN
}

enum Tag {
  SHIRT
}

enum Email {
  TEST1_GOOGLE_COM
}

enum FullName {
  JUAN_CARLOS
}

enum Role {
  ADMIN
}

