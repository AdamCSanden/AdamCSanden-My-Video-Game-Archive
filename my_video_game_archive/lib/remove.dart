import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:my_video_game_archive/main.dart';
import 'package:flutter/material.dart';
import 'package:my_video_game_archive/add.dart';
import 'package:my_video_game_archive/search.dart';
import 'package:my_video_game_archive/view.dart';
import 'package:my_video_game_archive/editgames.dart';
import 'package:my_video_game_archive/edit.dart';
//import 'firebase_options.dart';
import 'storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class RemovePage extends StatefulWidget {
  const RemovePage({super.key, required this.title});

  final String title;

  @override
  State<RemovePage> createState() => _RemovePageState();
}

class _RemovePageState extends State<RemovePage> {
  final _storage = UserStorage();
  final TextEditingController titleController = TextEditingController();

  SharedPreferences? _prefs;
  File? _pickedImage;
  Uint8List? _imageBytes;

  Future<void> _removeGame() async {
    await _storage.deleteGame(
      titleController.text,
    );
  }

  Future<void> checkAndRequestStoragePermission() async {
    final status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    }
  }

  Future<void> initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> loadSavedImage() async {
    final imagePath = _prefs!.getString('imagePath');
    if (imagePath != null) {
      final imageFile = File(imagePath);
      final imageBytes = await imageFile.readAsBytes();
      setState(() {
        _pickedImage = imageFile;
        _imageBytes = imageBytes;
      });
    }
  }

  Future<void> deleteImage() async {
    await checkAndRequestStoragePermission();
    final imagePath = _prefs!.getString('imagePath' '$titleController.text');
    if (imagePath != null) {
      final imageFile = File(imagePath);
      await imageFile.delete();
      await _prefs!.remove('imagePath');
      await _prefs!.remove('$titleController.text');
      setState(
        () {
          _pickedImage = null;
          _imageBytes = null;
        },
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
    loadSavedImage();
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
              // const PopupMenuItem(
              //   value: 5,
              //   child: Text('Remove Game'),
              // ),
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
              'Which game would you like to delete',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const Divider(height: 250),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'title',
                labelText: 'title of game to delete',
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, fixedSize: const Size(250, 24)),
              onPressed: () {
                _removeGame();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Successfully removed game from archive",
                    ),
                  ),
                );
                deleteImage();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Successfully removed image from archive.",
                    ),
                  ),
                );

                handleClick(1);
              },
              icon: const Icon(
                Icons.delete_forever_outlined,
                size: 24,
                color: Colors.white,
              ),
              label: const Text(
                'delete',
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
        //Navigate to Edit Archive screen
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
      case 4:
        //Navigate to the Edit Games secreen
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const EditGamesPage(
              title: 'Edit Games',
            ),
          ),
        );
        break;
      /*case 4:
                Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => const RemovePage(title: 'Remove Games',),
                    ),
                );
            break;*/
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
