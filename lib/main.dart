import 'package:arty_app/blocs/Artlist/artlist_bloc.dart';
import 'package:arty_app/blocs/carousel/carousel_bloc.dart';
import 'package:arty_app/blocs/carousel/carousel_event.dart';
import 'package:arty_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => CarouselBloc()..add(LoadCarouselItems())),
    BlocProvider(create: (context) => ArtlistBloc())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}
