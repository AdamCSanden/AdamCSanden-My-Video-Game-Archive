import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_video_game_archive/add.dart';
import 'package:my_video_game_archive/edit.dart';
import 'package:my_video_game_archive/editgames.dart';
import 'package:my_video_game_archive/main.dart';
import 'package:my_video_game_archive/storage.dart';
import 'package:my_video_game_archive/remove.dart';
import 'package:my_video_game_archive/view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});

  final String title;

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  final UserStorage _storage = UserStorage();
  final searchController = TextEditingController();
  late CollectionReference collection;
  late Future<QuerySnapshot> documentFuture;
  late Future<int> _numGames;
  late String _searchTitle = '';

  // These are all of our variables for the game details
  late String _title;
  late bool _digital;
  late bool _physical;
  late bool _beaten;
  late bool _played;
  late bool _pc;
  late bool _legacy;
  late bool _playstation;
  late bool _nintendo;
  late bool _xbox;
  late int _rating;
  late String _description;

  @override
  void initState() {
    super.initState();
    _numGames = _storage.getNumGames();
    collection = FirebaseFirestore.instance.collection('Games');
    documentFuture = fetchDocuments();
    // _imageURL = _storage.getImageURL('default');
    // _url = 'gs://my-video-game-archive.appspot.com/images/default.jpg';
    _searchTitle = '';
  }

  Future<void> performSearch() async {
    _searchTitle = searchController.text;
    setState(() {
      documentFuture = fetchDocuments();
    });
  }

  Future<QuerySnapshot> fetchDocuments() async {
    if (_searchTitle.isEmpty) {
      // Retrieve all documents
      QuerySnapshot querySnapshot = await collection.get();
      return querySnapshot;
    } else {
      // Perform search based on the document ID
      QuerySnapshot querySnapshot = await collection
          .where(FieldPath.documentId, isEqualTo: _searchTitle)
          .get();
      return querySnapshot;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // void updateStates() async {
  //   var searchGames = await _storage.searchGames(searchController.text);
  //   var url =
  //       await _storage.getImageURL(searchController.text) as Future<String>;
  //   setState(() {
  //     _searchGames = searchGames as Future<Map>;
  //     _imageURL = url;
  //   });
  // }

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
              // const PopupMenuItem(
              //   value: 6,
              //   child: Text('Search Games'),
              // ),
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
            const SizedBox(
              height: 10,
            ),
            Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      icon: Icon(
                        Icons.search,
                        size: 24,
                      ),
                      labelText: 'What game are you looking for?\n',
                      hintText: 'Game Title',
                      labelStyle: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Builder(
                    builder: (context) => ElevatedButton(
                      onPressed: () async {
                        _searchTitle = searchController.text;
                        performSearch;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Searching...',
                            ),
                          ),
                        );
                        // _url = _imageURL as String;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Search Complete!',
                            ),
                          ),
                        );
                      },
                      child: const Text('Search'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
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

            // Expanded(
            //   child: ListView(),
            // ),
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

  displayData() {
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
        title: Text(
          'Game Details for $_searchTitle',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Game Description: $_description'),
            Text('Digital: $_digital'),
            Text('Physical: $_physical'),
            Text('Beaten: $_beaten'),
            Text('Played: $_played'),
            Text('PC: $_pc'),
            Text('Legacy: $_legacy'),
            Text('Playstation: $_playstation'),
            Text('Nintendo: $_nintendo'),
            Text('Xbox: $_xbox'),
            Text('Rating: $_rating'),
          ],
        ),
      ),
    );
  }

  void setData(snapshot) {
    _beaten = snapshot['beaten'] as bool;
    _description = snapshot['description'] as String;
    _digital = snapshot['digital'] as bool;
    _legacy = snapshot['legacy'] as bool;
    _nintendo = snapshot['nintendo'] as bool;
    _pc = snapshot['pc'] as bool;
    _physical = snapshot['physical'] as bool;
    _playstation = snapshot['playstation'] as bool;
    _played = snapshot['played'] as bool;
    _rating = snapshot['rating'] as int;
    _title = snapshot.id as String;
    _xbox = snapshot['xbox'] as bool;
  }
}
