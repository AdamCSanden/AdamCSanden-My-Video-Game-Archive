import 'package:my_video_game_archive/main.dart';
import 'package:flutter/material.dart';
import 'package:my_video_game_archive/add.dart';
import 'package:my_video_game_archive/remove.dart';
import 'package:my_video_game_archive/search.dart';
import 'package:my_video_game_archive/view.dart';
import 'package:my_video_game_archive/editgames.dart';
import 'package:image_picker/image_picker.dart';

//class MyHomePage extends StatefulWidget {
//  const MyHomePage({super.key, required this.title});

// This widget is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that affect
// how it looks.

// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".
class EditPage extends StatefulWidget {
  const EditPage({super.key, required this.title});

  final String title;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
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
              // const PopupMenuItem(
              //   value: 4,
              //   child: Text('Edit Games'),
              // ),
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
            'Edit Options:',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          //Tooltip(
          //    message: 'Add New Game to Archive',
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, fixedSize: const Size(250, 24)),
            //placeholder: sends to home
            onPressed: () => handleClick(2),
            icon: const Icon(
              Icons.add_box_outlined,
              size: 24,
              color: Colors.white,
            ),
            label: const Text(
              'Add',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //),
          // Tooltip(
          //    message: 'Edit Existing Game in Archive',
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, fixedSize: const Size(250, 24)),
            //placeholder: sends to hom
            onPressed: () => handleClick(3),
            icon: const Icon(
              Icons.edit,
              size: 24,
              color: Colors.white,
            ),
            label: const Text(
              'Edit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //),
          //Tooltip(
          //    message: 'Remove Existing Game from archive',
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, fixedSize: const Size(250, 24)),
            //placeholder: send to home
            onPressed: () => handleClick(4),
            icon: const Icon(
              Icons.delete_forever_outlined,
              size: 24,
              color: Colors.white,
            ),
            label: const Text(
              'Remove',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //),
        ],
      )),
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
        //case 2:
        // Navigate to Edit Options
        //    Navigator.push<void>(
        //        context,
        //        MaterialPageRoute<void>(
        //            builder: (BuildContext context) => const EditPage(title: 'Edit Archive',),
        //        ),
        //    );

        break;
      case 2:
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const AddPage(
              title: 'Add Games',
            ),
          ),
        );
        break;
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
        //Navigate to search when tapped.
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
