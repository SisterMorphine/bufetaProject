import 'package:catproject/ui/home/widgets/failure_random_cat_view.dart';
import 'package:catproject/ui/home/widgets/initial_random_cat_view.dart';
import 'package:catproject/ui/home/widgets/loading_view.dart';
import 'package:catproject/ui/home/widgets/success_random_cat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catproject/ui/home/pages/bloc/random_cat_bloc.dart';
import 'package:catproject/ui/home/pages/bloc/random_cat_state.dart';

class RandomCatLayout extends StatelessWidget {
  const RandomCatLayout() : super();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RandomCatBloc, RandomCatState>(
      builder: (context, state) {
        if (state.status.isFailure) {
          return const FailureRandomCatView();
        } else if (state.status.isInitial) {
          return const InitialRandomCatView();
        } else if (state.status.isLoading) {
          return const LoadingView();
        } else if (state.status.isSuccess) {
          return SuccessRandomCatView(
            cat: state.cat,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
