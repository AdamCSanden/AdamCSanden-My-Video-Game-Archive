import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:my_video_game_archive/main.dart';
import 'package:flutter/material.dart';
import 'package:my_video_game_archive/remove.dart';
import 'package:my_video_game_archive/search.dart';
import 'package:my_video_game_archive/view.dart';
import 'package:my_video_game_archive/editgames.dart';
import 'package:my_video_game_archive/edit.dart';
//import 'firebase_options.dart';
import 'storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key, required this.title});

  final String title;

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  //game title will be the key attribute that will be used for filtering the data entry you want.
  String gameTitle = "";
  String gameDesc = "";
  File? _pickedImage;
  Uint8List? _imageBytes;

  //controller for the editable textfield
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  //create an instance of a storage object so that we can save the game entry to firebase
  final _storage = UserStorage();
  late final SharedPreferences? _prefs;

  //all of the checkbox values will be booleans that will default to false
  bool digital = false;
  bool physical = false;
  bool beaten = false;
  bool played = false;
  bool pc = false;
  bool legacy = false;
  bool playstation = false;
  bool nintendo = false;
  bool xbox = false;
  int rating = 0;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  Future<void> initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> checkAndRequestStoragePermission() async {
    final status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    }
  }

  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);
      final imageBytes = await imageFile.readAsBytes();

      setState(() {
        _pickedImage = imageFile;
        _imageBytes = imageBytes;
      });

      final imageName = gameTitle; // Replace with your desired name
      if (imageName.isNotEmpty) {
        await checkAndRequestStoragePermission();
        saveImageData(imageFile.path, imageName);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Image saved successfully!',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Error saving Image, please try again',
            ),
          ),
        ); // Handle case where the image name is empty or invalid
      }
    }
  }

  Future<void> saveImageData(String imagePath, String imageName) async {
    await _prefs!.setString('imagePath', imagePath);
    await _prefs!.setString('imageName', imageName);
  }

  String? loadImagePath() {
    return _prefs!.getString('imagePath');
  }

  String? loadImageName() {
    return _prefs!.getString('imageName');
  }

  Future<void> _addGame() async {
    await _storage.addGame(
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
        descController.text);
    setState(() {});
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
              // const PopupMenuItem(
              //   value: 2,
              //   child: Text('Add Game'),
              // ),
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
      body: ListView(
        //body: Center(
        //child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Fill in info about your game:',
            style: TextStyle(
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
          CheckboxListTile(
            value: digital,
            onChanged: (bool? value) {
              setState(() {
                digital = value!;
              });
            },
            title: const Text('Digital'),
          ),
          const Divider(height: 0),
          CheckboxListTile(
            value: physical,
            onChanged: (bool? value) {
              setState(() {
                physical = value!;
              });
            },
            title: const Text('Physical'),
          ),
          const Divider(height: 0),
          CheckboxListTile(
            value: beaten,
            onChanged: (bool? value) {
              setState(() {
                beaten = value!;
              });
            },
            title: const Text('Beaten'),
          ),
          const Divider(height: 0),
          CheckboxListTile(
            value: played,
            onChanged: (bool? value) {
              setState(() {
                played = value!;
              });
            },
            title: const Text('Played'),
          ),
          const Divider(height: 0),
          CheckboxListTile(
            value: pc,
            onChanged: (bool? value) {
              setState(() {
                pc = value!;
              });
            },
            title: const Text('PC'),
          ),
          const Divider(height: 0),
          CheckboxListTile(
            value: legacy,
            onChanged: (bool? value) {
              setState(() {
                legacy = value!;
              });
            },
            title: const Text('Legacy'),
          ),
          const Divider(height: 0),
          CheckboxListTile(
            value: playstation,
            onChanged: (bool? value) {
              setState(() {
                playstation = value!;
              });
            },
            title: const Text('Playstation'),
          ),
          const Divider(height: 0),
          CheckboxListTile(
            value: nintendo,
            onChanged: (bool? value) {
              setState(() {
                nintendo = value!;
              });
            },
            title: const Text('Nintendo'),
          ),
          const Divider(height: 0),
          CheckboxListTile(
            value: xbox,
            onChanged: (bool? value) {
              setState(() {
                xbox = value!;
              });
            },
            title: const Text('Xbox'),
          ),
          const SizedBox(height: 20),
          /* TextField(
                        decoration: InputDecoration(labelText: "Rating"),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    ),*/
          const Text(
            'Description:',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          TextField(
            controller: descController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'description',
              labelText: 'desc',
            ),
          ),
          ElevatedButton(
            onPressed: pickImage,
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(250, 24),
            ),
            child: const Text('Add Image'),
          ),
          const SizedBox(
            height: 16,
          ),
          if (_imageBytes != null)
            Container(
              height: 400,
              width: 100,
              child: Image.memory(
                _imageBytes!,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, fixedSize: const Size(250, 24)),
            onPressed: () {
              _addGame();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Successfully added game to archive.",
                  ),
                ),
              );
              handleClick(1);
            },
            icon: const Icon(
              Icons.add_box_outlined,
              size: 24,
              color: Colors.white,
            ),
            label: const Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        //),
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
      /*case 3:
                Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => const AddPage(title: 'Add Games',),
                    ),
                );
            break;*/
      case 3:
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const EditGamesPage(
              title: 'Edit Games',
            ),
          ),
        );
        break;
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
