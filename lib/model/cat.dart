class Cat {
  final String catId;
  final String? imageUrl;

  const Cat({required this.catId, required this.imageUrl});

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      catId: json['id'],
      imageUrl: json['url'],
    );
  }
}
