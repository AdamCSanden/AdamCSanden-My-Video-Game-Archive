import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:my_video_game_archive/main.dart';
import 'package:flutter/material.dart';
import 'package:my_video_game_archive/add.dart';
import 'package:my_video_game_archive/remove.dart';
import 'package:my_video_game_archive/search.dart';
import 'package:my_video_game_archive/view.dart';
import 'package:my_video_game_archive/edit.dart';
//import 'firebase_options.dart';
import 'storage.dart';

class EditGamesPage extends StatefulWidget {
  const EditGamesPage({super.key, required this.title});

  final String title;

  @override
  State<EditGamesPage> createState() => _EditGamesPageState();
}

class _EditGamesPageState extends State<EditGamesPage> {
  final _storage = UserStorage();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  /*class Game {
        String title;
        bool digital;
        bool physical;
        bool beaten;
        bool played;
        bool pc;
        bool legacy;
        bool playstation;
        bool nintendo;
        bool xbox;
        int rating;
        String description;

    Game({this.title, 
        this.digital, 
        this.physical, 
        this.beaten, 
        this.palyed, 
        this.legacy, 
        this.playstation, 
        this.nintendo, 
        this.xbox, 
        this.rating
        this.description});
    } */

  /* Late Future<Game> _getGame() async {
        Late Future<Game> curGame
        Game.digital = _storage.getDigital(titleController.text),
        Game.physical = _storage.getPhysical(titleController.text),
        Game.beaten = _storage.getBeaten(titleController.text),
        Game.played = _storage.getPlayed(titleController.text),
        Game.pc = _storage.getPC(titleController.text),
        Game.legacy = _storage.getLegacy(titleController.text),
        Game.playstation = _storage.getPlaystation(titleController.text),
        Game.nintendo = _storage.getNintendo(titleController.text),
        Game.xbox = _storage.getXbox(titleController.text),
        Game.rating = _storage.getRating(titleController.text),
        Game.description = _storage.getDescription(titleController.text),


    }
    
    Future<void> _updateGame() async { 
        await _storage.updateGame(
            titleController.text,
            digital, 
            physical, 
            beaten, 
            played, 
            pc,
            legacy, 
            playstation, 
            nintendo, 
            xbox, 
            rating, 
            descController.text
        );
        setState(() {});
        }*/

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
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
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          PopupMenuButton<int>(
            icon: const Icon(Icons.menu),
            onSelected: (item) => handleClick(item),
            itemBuilder: (context) => [
              // const PopupMenuItem(
              //   value: 1,
              //   child: Text('Home'),
              // ),
              const PopupMenuItem(
                value: 2,
                child: Text('Edit Archive'),
              ),
              const PopupMenuItem(
                value: 3,
                child: Text(
                  'Add Games',
                ),
              ),
              //const PopupMenuItem(value: 3, child: Text('Edit Games',),),
              const PopupMenuItem(
                value: 4,
                child: Text(
                  'Remove Games',
                ),
              ),
              const PopupMenuItem(
                value: 5,
                child: Text(
                  'Search Games',
                ),
              ),
              const PopupMenuItem(
                value: 6,
                child: Text(
                  'View Game Archive',
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '*Unfinished*',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'title',
                labelText: 'title',
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
        // Navigate home when tapped.
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const MyHomePage(
              title: 'My Video Game Archive',
            ),
          ),
        );
        break;
      case 2:
        //Navigate to Edit Options
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const EditPage(
              title: 'Edit Archive',
            ),
          ),
        );
        break;
      case 3:
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const AddPage(
              title: 'Add Games',
            ),
          ),
        );
        break;
      //case 3:
      //    Navigator.push<void>(
      //        context,
      //        MaterialPageRoute<void>(
      //            builder: (BuildContext context) => const EditGamePage(title: 'Edit Games',),
      //        ),
      //    );
      //break;
      case 4:
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const RemovePage(
              title: 'Remove Games',
            ),
          ),
        );
        break;
      case 5:
        // Navigate to search when tapped.
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const SearchPage(
              title: 'Search Games',
            ),
          ),
        );
        break;
      case 6:
        // Navigate to view when tapped.
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const ViewPage(
              title: 'Game Archive',
            ),
          ),
        );
        break;
    }
  }
}
