import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_video_game_archive/add.dart';
import 'package:my_video_game_archive/edit.dart';
import 'package:my_video_game_archive/editgames.dart';
import 'package:my_video_game_archive/remove.dart';
// import 'package:my_video_game_archive/sign_in.dart';
import 'package:my_video_game_archive/search.dart';
import 'package:my_video_game_archive/view.dart';
import 'storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Video Game Archive',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'My Video Game Archive'),
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
  final UserStorage _storage = UserStorage();
  late Future<int> _numGames = _storage.getNumGames();

  @override
  void initState() {
    super.initState();
    _numGames = _storage.getNumGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.videogame_asset,
          size: 24,
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (item) => handleClick(item),
            itemBuilder: (context) => [
              // const PopupMenuItem(
              //   value: 1,
              //   child: Text('Home'),
              // ),
              const PopupMenuItem(
                value: 2,
                child: Text('Add Game'),
              ),
              const PopupMenuItem(
                value: 3,
                child: Text('Edit Archive'),
              ),
              const PopupMenuItem(
                value: 4,
                child: Text('Edit Games'),
              ),
              const PopupMenuItem(
                value: 5,
                child: Text('Remove Game'),
              ),
              const PopupMenuItem(
                value: 6,
                child: Text('Search Games'),
              ),
              const PopupMenuItem(
                value: 7,
                child: Text('View Archive'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to your video game archive!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 75,
            ),
            FutureBuilder<int>(
              future: _numGames,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text(
                    'You have ${snapshot.data} games in your archive',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            // Text(
            //   'You have $_numGames games in your archive',
            //   style: const TextStyle(
            //     color: Colors.black,
            //     fontSize: 20,
            //   ),
            // ),
            const SizedBox(
              height: 75,
            ),
            const Text(
              'What would you like to do?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                fixedSize: const Size(250, 30),
              ),
              onPressed: () => handleClick(3),
              icon: const Icon(
                Icons.edit,
                size: 24,
                color: Colors.white,
              ),
              label: const Text(
                'Edit Game Archive',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                fixedSize: const Size(250, 24),
              ),
              onPressed: () => handleClick(6),
              icon: const Icon(
                Icons.search,
                size: 24,
                color: Colors.white,
              ),
              label: const Text(
                'Search Games',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                fixedSize: const Size(250, 24),
              ),
              onPressed: () => handleClick(7),
              icon: const Icon(
                Icons.view_list,
                size: 24,
                color: Colors.white,
              ),
              label: const Text(
                'View Game Archive',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleClick(int item) {
    switch (item) {
      case 1:
        const Text("Home");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                const MyHomePage(title: 'My Video Game Archive'),
          ),
        );
        break;
      case 2:
        const Text("Add Game");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddPage(title: 'Add Game'),
          ),
        );
        break;
      case 3:
        const Text("Edit Archive");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const EditPage(title: 'Edit Archive'),
          ),
        );
        break;
      case 4:
        const Text("Edit Game");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const EditGamesPage(title: 'Edit Games'),
          ),
        );
        break;
      case 5:
        const Text("Remove Game");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const RemovePage(title: 'Remove Game'),
          ),
        );
        break;
      case 6:
        const Text("Search Games");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SearchPage(title: 'Search Games'),
          ),
        );
        break;
      case 7:
        const Text("View Archive");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ViewPage(title: 'View Archive'),
          ),
        );
        break;
    }
  }
}



// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'My Video Game Archive',
//       theme: ThemeData(
//         // This is the theme of your application.
//         primarySwatch: Colors.orange,
//       ),
//       // initialRoute:
//       // FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/',
//       // routes: {
//       // '/': (context) => const MyHomePage(title: 'My Video Game Archive'),
//       // 'sign-in': (context) => const SignInPage(title: 'Sign In'),
//       // '/add': (context) => const AddPage(title: 'Add Game'),
//       // '/edit': (context) => const EditPage(title: 'Edit Game'),
//       // '/remove': (context) => const RemovePage(title: 'Remove Game'),
//       // '/search': (context) => const SearchPage(title: 'Search Game'),
//       // '/view': (context) => const ViewPage(title: 'View Game'),
//       // },
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // UserStorage storage = UserStorage();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: ElevatedButton(
//           style: ElevatedButton.styleForm(
//             backgroundColor: Colors.red,
//             fixedSize: const Size(250, 30),
//           ),
//           onPressed: () => handleClick(6),
//           child: const Icon(
//             Icons.person,
//             size: 24,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         title: Text(
//           widget.title,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: <Widget>[
//           PopupMenuButton<int>(
//             icon: const Icon(
//               Icons.menu,
//               size: 24,
//               color: Colors.white,
//             ),
//             onSelected: (item) => handleClick(item),
//             itemBuilder: (context) => [
//               const PopupMenuItem(
//                 value: 1,
//                 child: Text(
//                   'Add Games',
//                 ),
//               ),
//               const PopupMenuItem(
//                 value: 2,
//                 child: Text(
//                   'Edit Archive',
//                 ),
//               ),
//               const PopupMenuItem(
//                 value: 3,
//                 child: Text(
//                   'Remove Games',
//                 ),
//               ),
//               const PopupMenuItem(
//                 value: 4,
//                 child: Text(
//                   'Search Games',
//                 ),
//               ),
//               const PopupMenuItem(
//                 value: 5,
//                 child: Text(
//                   'View Game Archive',
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'Welcome to your video game archive!',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             // FutureBuilder(
//             //   builder: builder,
//             //   future: storage.getNumGames(),
//             // ),
//             // Text(
//             //   'You have $_numGames games in your archive',
//             //   style: const TextStyle(
//             //     color: Colors.black,
//             //     fontSize: 20,
//             //   ),
//             // ),
//             const SizedBox(
//               height: 50,
//             ),
//             const Text(
//               'What would you like to do?',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//               ),
//             ),
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 fixedSize: const Size(250, 30),
//               ),
//               onPressed: () => handleClick(2),
//               icon: const Icon(
//                 Icons.edit,
//                 size: 24,
//                 color: Colors.white,
//               ),
//               label: const Text(
//                 'Edit Game Archive',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 fixedSize: const Size(250, 24),
//               ),
//               onPressed: () => handleClick(4),
//               icon: const Icon(
//                 Icons.search,
//                 size: 24,
//                 color: Colors.white,
//               ),
//               label: const Text(
//                 'Search Games',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 fixedSize: const Size(250, 24),
//               ),
//               onPressed: () => handleClick(5),
//               icon: const Icon(
//                 Icons.view_list,
//                 size: 24,
//                 color: Colors.white,
//               ),
//               label: const Text(
//                 'View Game Archive',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void handleClick(int item) {
//     switch (item) {
//       case 1:
//         // Navigator.push<void>(
//         //   context,
//         //   MaterialPageRoute<void>(
//         //     builder: (BuildContext context) => const RemovePage(
//         //       title: 'Add Games',
//         //     ),
//         //   ),
//         // );
//         break;
//       case 2:
//         // Navigator.push<void>(
//         //   context,
//         //   MaterialPageRoute<void>(
//         //     builder: (BuildContext context) => const EditPage(
//         //       title: 'Edit Games',
//         //     ),
//         //   ),
//         // );
//         break;
//       case 3:
//         // Navigator.push<void>(
//         //   context,
//         //   MaterialPageRoute<void>(
//         //     builder: (BuildContext context) => const RemovePage(
//         //       title: 'Remove Games',
//         //     ),
//         //   ),
//         // );
//         break;
//       case 4:
//         // Navigate to search when tapped.
//         Navigator.push<void>(
//           context,
//           MaterialPageRoute<void>(
//             builder: (BuildContext context) => const SearchPage(
//               title: 'Search Games',
//             ),
//           ),
//         );
//         break;
//       case 5:
//         // Navigate to view when tapped.
//         Navigator.push<void>(
//           context,
//           MaterialPageRoute<void>(
//             builder: (BuildContext context) => const ViewPage(
//               title: 'View Game Archive',
//             ),
//           ),
//         );
//         break;
//       case 6:
//         // Navigate to the login page when tapped.

//         break;
//     }
//   }
// }
