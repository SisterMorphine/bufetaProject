import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      key: Key("CatLoading"),
      child: CircularProgressIndicator(color: Colors.green),
    );
  }
}
