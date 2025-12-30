import 'package:equatable/equatable.dart';

class Cat extends Equatable {
  final String catId;
  final String? imageUrl;

  const Cat({required this.catId, required this.imageUrl});

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      catId: json['id'],
      imageUrl: json['url'],
    );
  }

  @override
  List<Object?> get props => [catId, imageUrl];

  static const empty = Cat(catId: '', imageUrl: null);
}
