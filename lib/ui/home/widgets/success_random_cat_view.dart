import 'package:catproject/repository/models/cat.dart';
import 'package:catproject/ui/home/pages/bloc/random_cat_bloc.dart';
import 'package:catproject/ui/home/pages/bloc/random_cat_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessRandomCatView extends StatelessWidget {
  const SuccessRandomCatView({
    required this.cat,
  });

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Center(
                child: Image.network(
          cat.imageUrl!,
          fit: BoxFit.contain,
          width: double.infinity,
          height: double.infinity,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const CircularProgressIndicator();
          },
        ))),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                context.read<RandomCatBloc>().add(RandomCatEvent());
              },
              icon: const Icon(Icons.refresh),
              label: const Text(
                'Load New Cat 😺',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
