import 'package:catproject/repository/cats_repository.dart';
import 'package:catproject/repository/service/cats_service.dart';
import 'package:catproject/ui/home/pages/bloc/random_cat_bloc.dart';
import 'package:catproject/ui/home/pages/bloc/random_cat_event.dart';
import 'package:catproject/ui/home/pages/random_cat_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomCatPage extends StatelessWidget {
  const RandomCatPage() : super();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CatsRepository(service: CatsService()),
      child: BlocProvider(
        create: (context) => RandomCatBloc(
          catRepository: context.read<CatsRepository>(),
        )..add(RandomCatEvent()),
        child: const RandomCatLayout(),
      ),
    );
  }
}
