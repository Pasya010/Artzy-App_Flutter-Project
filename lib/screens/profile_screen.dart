import 'package:arty_app/blocs/Artlist/artlist_bloc.dart';
import 'package:arty_app/blocs/Artlist/artlist_event.dart';
import 'package:arty_app/blocs/Artlist/artlist_state.dart';
import 'package:arty_app/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // text art list
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'MY ART LIST',
              style: TextStyle(fontSize: 20),
            ),
          ),

          // art list content
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: BlocBuilder<ArtlistBloc, ArtlistState>(
              builder: (context, state) {
                if (state.items.isEmpty) {
                  return Center(
                    child: Text(
                      "No items in Artlist",
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }

                // Jika hanya ada satu item
                if (state.items.length == 1) {
                  final singleItem = state.items.first;
                  return Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                    title: singleItem['title'],
                                    images: singleItem['images'])));
                          },
                          child: Container(
                            width: 250,
                            height: 400,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(singleItem['images']),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<ArtlistBloc>(context)
                                  .add(RemoveFromArtlist(singleItem));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Remove",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Jika lebih dari satu item
                return Swiper(
                  itemWidth: 250,
                  itemHeight: 400,
                  loop: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.items.length,
                  layout: SwiperLayout.STACK,
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                    title: item['title'],
                                    images: item['images'])));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(item['images']),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<ArtlistBloc>(context)
                                  .add(RemoveFromArtlist(item));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Remove",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
