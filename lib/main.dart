import 'dart:math';

import 'package:bloc_app/bloc/pizza_bloc.dart';
import 'package:bloc_app/counter_cubit.dart';
import 'package:bloc_app/models/pizza_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(CounterApp());

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PizzaBloc()..add(LoadPizzaCounter()))
      ],
      child: MaterialApp(
        title: 'The Pizza Bloc arch',
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Pizza Bloc'),
        centerTitle: true,
        backgroundColor: Colors.orange[800],
      ),
      body: Center(
        child: BlocBuilder<PizzaBloc, PizzaState>(
          builder: (context, state) {
            if (state is PizzaInitial) {
              return CircularProgressIndicator(color: Colors.orange);
            }
            if (state is PizzaLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${state.pizzas.length}',
                    style: const TextStyle(
                        fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        for (int index = 0;
                            index < state.pizzas.length;
                            index++)
                          Positioned(
                            left: Random.secure().nextInt(250).toDouble(),
                            top: Random.secure().nextInt(400).toDouble(),
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: state.pizzas[index].image,
                            ),
                          )
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Text('Something Went Wrong');
            }
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              child: const Icon(Icons.local_pizza_outlined),
              backgroundColor: Colors.orange[800],
              onPressed: () {
                context.read<PizzaBloc>().add(AddPizza(pizza: Pizza.pizzas[0]));
              }),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
              child: const Icon(Icons.local_pizza_outlined),
              backgroundColor: Colors.orange[800],
              onPressed: () {
                context
                    .read<PizzaBloc>()
                    .add(RemovePizza(pizza: Pizza.pizzas[0]));
              }),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
              child: const Icon(Icons.local_pizza_outlined),
              backgroundColor: Colors.orange[800],
              onPressed: () {
                context.read<PizzaBloc>().add(AddPizza(pizza: Pizza.pizzas[1]));
              }),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
              child: const Icon(Icons.local_pizza_outlined),
              backgroundColor: Colors.orange[800],
              onPressed: () {
                context
                    .read<PizzaBloc>()
                    .add(RemovePizza(pizza: Pizza.pizzas[1]));
              })
        ],
      ),
    );
  }
}

// class CounterPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Counter')),
//       body: BlocBuilder<Counter, int>(
//         builder: (context, count) => Center(child: Text('$count')),
//       ),
//       floatingActionButton: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           FloatingActionButton(
//             child: const Icon(Icons.add),
//             onPressed: () => context.read<CounterCubit>().increment(),
//           ),
//           const SizedBox(height: 4),
//           FloatingActionButton(
//             child: const Icon(Icons.remove),
//             onPressed: () => context.read<CounterCubit>().decrement(),
//           ),
//         ],
//       ),
//     );
//   }
// }
