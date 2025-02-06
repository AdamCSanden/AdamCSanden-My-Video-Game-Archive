import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_video_game_archive/add.dart';
import 'package:my_video_game_archive/edit.dart';
import 'package:my_video_game_archive/editgames.dart';
import 'package:my_video_game_archive/main.dart';
import 'package:my_video_game_archive/remove.dart';
import 'package:my_video_game_archive/search.dart';
import 'storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key, required this.title});

  final String title;

  @override
  State<ViewPage> createState() => _ViewPage();
}

class _ViewPage extends State<ViewPage> {
  final UserStorage _storage = UserStorage();
  late Future<int> _numGames;
  late CollectionReference collection;
  late Future<QuerySnapshot> documentFuture;

  @override
  void initState() {
    super.initState();
    // Get reference to the collection
    collection = FirebaseFirestore.instance.collection('Games');
    // Get the documents
    documentFuture = fetchDocuments();
    _numGames = _storage.getNumGames();
  }

  Future<QuerySnapshot> fetchDocuments() async {
    // Retrieve the documents
    QuerySnapshot querySnapshot = await collection.get();
    return querySnapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          style: ElevatedButton.styleFrom(
            // backgroundColor: Colors.red,
            fixedSize: const Size(250, 30),
          ),
          onPressed: () => handleClick(1),
          child: const Icon(
            Icons.home,
            size: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
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
              // const PopupMenuItem(
              //   value: 7,
              //   child: Text('View Archive'),
              // ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            FutureBuilder<int>(
              future: _numGames,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text(
                    'You have ${snapshot.data} games in your archive',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
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
            FutureBuilder<QuerySnapshot>(
              future: documentFuture,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        // Access individual document data
                        DocumentSnapshot document = documents[index];

                        // Extract fields from the document
                        String title = document.id;
                        String description = document['description'];

                        return ListTile(
                          title: Text(title),
                          subtitle: Text(description),
                        );
                      },
                    ),
                  );
                }
              },
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
      // case 7:
      //   const Text("View Archive");
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) => const ViewPage(title: 'View Archive'),
      //     ),
      //   );
      //   break;
    }
  }
}
