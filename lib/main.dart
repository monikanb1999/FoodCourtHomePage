import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_page/blocs/appbar_part/appbar_events.dart';
import 'package:home_page/screens/home_screen.dart';

import 'blocs/appbar_part/appbar_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Food Court',
        theme: ThemeData(
          appBarTheme: AppBarTheme(titleTextStyle: TextStyle(color: Colors.white.withOpacity(0.8))),
          textTheme: TextTheme(
            bodyMedium: TextStyle(
              color: Colors.white.withOpacity(0.8),
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: const Offset(1, 1),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
              TargetPlatform.windows: OpenUpwardsPageTransitionsBuilder(),
            },
          ),
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.black,
        ),
        initialRoute: '/home',
        routes: {
          '/home': (context) => MultiBlocProvider(providers: <BlocProvider>[
                BlocProvider<AppBarBloc>(
                    create: (ctx) => AppBarBloc()..add(ChangeSeletcion(selectedTile: "Home")))
              ], child: const HomeScreen()),
        },
    );
  }
}
class Sizes {
  static double width = 0.0;
  static double height = 0.0;
}
