import 'package:confess_atu/pages/channles_page.dart';
import 'package:confess_atu/pages/homepage_content.dart';
import 'package:confess_atu/pages/inbox_page.dart';
import 'package:confess_atu/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  // logout user
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    /// widget list

    return Scaffold(
      // appBar: AppBar(
      //   // backgroundColor: Colors.deepPurple,
      //   actions: [
      //     // lougout button

      //     IconButton(
      //       onPressed: logout,
      //       icon: const Icon(Icons.login_outlined),
      //       color: const Color.fromARGB(255, 7, 6, 6),
      //     )
      //   ],
      // ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(
            () {
              currentPageIndex = index;
            },
          );
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.message),
            label: 'Channels',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_sharp),
            label: 'Inbox',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Prfoile',
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: <Widget>[
          HomePageContent(),
          const ChannelsPage(),
          const InboxPage(),
          const ProfilePage(),
        ],
      ),
    );
  }
}
