import 'package:arty_app/models/card_model.dart';
import 'package:arty_app/screens/detail_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, dynamic> selectedItem = cardItems[2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // new releases
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text(
                'New Release 🔥',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Center(
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    // image
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          selectedItem['images'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // title & artist
                    Positioned(
                      bottom: 30,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title : ${selectedItem['title']}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            'Artist : ${selectedItem['artist']}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),

                    // add button
                    Positioned(
                        right: 20,
                        bottom: 35,
                        child: Row(
                          children: [
                            // Play music
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  backgroundColor: Colors.black,
                                ),
                                onPressed: () {},
                                child: Icon(
                                  Icons.play_circle_fill_outlined,
                                  color: Colors.white,
                                )),
                          ],
                        )),
                  ],
                ),
              ),
            ),

            // Dicover More
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text(
                'Discover More 🚀',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),

            // Discover More content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cardItems.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final item = cardItems[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailScreen(
                                title: item['title'], images: item['images'])));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          item['images'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
