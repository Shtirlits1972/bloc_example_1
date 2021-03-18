import 'package:bloc_example_1/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(
          title: 'Bloc - 1',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: BlocListener<CounterCubit, CounterState>(
        listener: (contex, state) {
          if (state.wasIncremented == true) {
            final snackbar = SnackBar(
              content: Text('increment'),
              duration: Duration(microseconds: 200),
            );

            ScaffoldMessenger.of(context).showSnackBar(
              snackbar,
            );
          } else {
            final snackbar = SnackBar(
              content: Text('decrement'),
              duration: Duration(microseconds: 200),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              snackbar,
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('press button and do not show off'),
              BlocBuilder<CounterCubit, CounterState>(
                  builder: (context, state) {
                if (state.counterValue < 0) {
                  return Text(
                    'Negative   ' + state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                } else if (state.counterValue == 5) {
                  return Text(
                    'It is Number 5!   ' + state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                } else {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                }
              }),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      // ignore: deprecated_member_use
                      context.bloc<CounterCubit>().increment();
                    },
                    tooltip: 'increment',
                    child: Icon(
                      Icons.add,
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      // ignore: deprecated_member_use
                      context.bloc<CounterCubit>().decrement();
                    },
                    tooltip: 'decrement',
                    child: Icon(
                      Icons.remove,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
