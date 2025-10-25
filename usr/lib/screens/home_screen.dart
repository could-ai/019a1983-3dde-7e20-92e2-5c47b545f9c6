import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CardSwiperController controller = CardSwiperController();
  late List<User> users;

  @override
  void initState() {
    super.initState();
    users = dummyUsers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kindling', style: GoogleFonts.pacifico(fontSize: 28)),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.message)),
        ],
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: CardSwiper(
                controller: controller,
                cardsCount: users.length,
                onSwipe: _onSwipe,
                padding: const EdgeInsets.all(24.0),
                cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                  return ProfileCard(user: users[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0, top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: () => controller.swipe(CardSwiperDirection.left),
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.close, color: Colors.red, size: 30),
                  ),
                  FloatingActionButton(
                    onPressed: () {}, // Super like
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.star, color: Colors.blue, size: 30),
                  ),
                  FloatingActionButton(
                    onPressed: () => controller.swipe(CardSwiperDirection.right),
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.favorite, color: Colors.green, size: 30),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    debugPrint('The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top');
    // Handle swipe logic here (e.g., save like/dislike)
    return true;
  }
}

class ProfileCard extends StatelessWidget {
  final User user;
  const ProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(user.imageUrl),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}, ${user.age}',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.white, size: 16),
                    const SizedBox(width: 5),
                    Text(
                      '3 miles away', // Dummy distance
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
