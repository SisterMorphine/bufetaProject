import 'package:flutter/material.dart';

class InitialRandomCatView extends StatelessWidget {
  const InitialRandomCatView() : super();

  @override
  Widget build(BuildContext context) {
    return Center(
      key: Key("CatInitial"),
      child: Text(
        'Press the button to load a random cat!',
      ),
    );
  }
}
