import 'package:arty_app/blocs/carousel/carousel_bloc.dart';
import 'package:arty_app/blocs/carousel/carousel_event.dart';
import 'package:arty_app/blocs/carousel/carousel_state.dart';
import 'package:arty_app/screens/Pages%20navigator/pages_navigator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CarouselBloc>().add(LoadCarouselItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                // container
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 500,
                    width: 400,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        // Greetings
                        Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: Text(
                            'A R T Z Y',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'ARTZY\nThe place where you can chill and have fun\nBuild a cozy feelings for you..',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 126, 120, 120)),
                        ),

                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
                // carousel slider
                Padding(
                  padding: const EdgeInsets.only(top: 230),
                  child: BlocBuilder<CarouselBloc, CarouselState>(
                      builder: (context, state) {
                    if (state is CarouselLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is CarouselLoaded) {
                      return CarouselSlider.builder(
                          itemCount: state.items.length,
                          itemBuilder: (context, index, _) {
                            final item = state.items[index];

                            return Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 10,
                                    offset: Offset(-7, 0),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  item['images'],
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 0.5,
                          ));
                    }
                    return SizedBox.shrink();
                  }),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => PagesNavigator()));
                },
                child: Container(
                  height: 50,
                  width: 340,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.next_plan),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Get Started',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
