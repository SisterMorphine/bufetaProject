import 'package:flutter/material.dart';

class FailureRandomCatView extends StatelessWidget {
  const FailureRandomCatView() : super();

  @override
  Widget build(BuildContext context) {
    return const Center(
      key: Key("CatFailure"),
      child: Text('Error loading cat 😿'),
    );
  }
}
