import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart%20%20';
import 'package:forms_app/presentation/blocs/counter_cubit/counter_cubit.dart';

class CubitsCounterScreen extends StatelessWidget {
  const CubitsCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CounterCubit(), child: const _CubitCounterView());
  }
}

class _CubitCounterView extends StatelessWidget {
  const _CubitCounterView();

  @override
  Widget build(BuildContext context) {

    // final counterState = context.watch<CounterCubit>().state;
    final counterActions = context.read<CounterCubit>();

    return Scaffold(
      appBar: AppBar(
        title:  context.select(( CounterCubit value){
          return Text('Cubits Counter: ${ value.state.transactionCount}');
        }),
        actions: [
          IconButton(
              onPressed: (){
                counterActions.reset();
              }, icon: const Icon(Icons.refresh_rounded))
        ],
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, CounterState>(
          // buildWhen: (previous, current) => current.counter != previous.counter,
          builder: (context, state) {
            // print('Estado cambio');
            return Text('Counter value: ${ state.counter }');
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              heroTag: '1', child: const Text("+3"), onPressed: (){
                counterActions.increaseBy(3);
                // counterState
              }),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
              heroTag: '2', child: const Text("+2"), onPressed: (){
                counterActions.increaseBy(2);

              }),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
              heroTag: '3', child: const Text("+1"), onPressed: () {
                counterActions.increaseBy(1);

              }),
        ],
      ),
    );
  }
}
