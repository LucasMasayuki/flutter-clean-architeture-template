import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architeture_template/features/counter/presentation/bloc/counter_state.dart';

import 'bloc/counter_bloc.dart';
import 'bloc/counter_event.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          if (state is CounterLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is CounterErrorState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Counter Value:',
                ),
                Text(
                  "${(state as CounterLoadedState).counter}",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () {
                        context.read<CounterBloc>().add(GetCounterEvent());
                      },
                      tooltip: 'Get Counter',
                      child: const Icon(Icons.refresh),
                    ),
                    const SizedBox(width: 20),
                    FloatingActionButton(
                      onPressed: () {
                        context
                            .read<CounterBloc>()
                            .add(IncrementCounterEvent());
                      },
                      tooltip: 'Increment Counter',
                      child: const Icon(Icons.add),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
