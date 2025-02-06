import 'dart:async';
import 'dart:io' as io;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserStorage {
  bool _initialized = false;

  Future<void> initializeDefault() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _initialized = true;
  }

  bool get isInitialized => _initialized;

  Future<void> addGame(
    String title,
    bool digital,
    bool physical,
    bool beaten,
    bool played,
    bool pc,
    bool legacy,
    bool playstation,
    bool nintendo,
    bool xbox,
    int rating,
    String description,
  ) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('Games').doc(title).set(
      {
        'digital': digital,
        'physical': physical,
        'beaten': beaten,
        'played': played,
        'legacy': legacy,
        'pc': pc,
        'playstation': playstation,
        'nintendo': nintendo,
        'xbox': xbox,
        'rating': rating,
        'description': description,
      },
    ).then(
      (value) {
        if (kDebugMode) {
          print('Game successfully added');
        }
      },
    ).catchError(
      (error) {
        if (kDebugMode) {
          print('addGame error: $error');
        }
      },
    );
  }

  // Delete a game from the database
  Future<void> deleteGame(String title) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('Games').doc(title).delete();
  }

  // This is to search for a single game because the id's for every doc are unique
  Future<QuerySnapshot> searchGames(String title) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    final CollectionReference search =
        FirebaseFirestore.instance.collection('Games');

    try {
      QuerySnapshot snapshot =
          await search.where(search.id, isEqualTo: title).get();

      return snapshot;
    } catch (error) {
      if (kDebugMode) {
        print('searchGames error: $error');
      }
      throw Exception('Failed to search for game: $error');
    }
    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    // DocumentSnapshot ds = await firestore.collection('Games').doc(title).get();
    // if (ds.data() != null) {
    //   return ds.data();
    // }
    // return null;
  }

  Future<void> updateGame(
    String title,
    bool digital,
    bool physical,
    bool beaten,
    bool played,
    bool pc,
    bool legacy,
    bool playstation,
    bool nintendo,
    bool xbox,
    int rating,
    String description,
  ) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('Games').doc(title).update(
      {
        'digital': digital,
        'physical': physical,
        'beaten': beaten,
        'played': played,
        'legacy': legacy,
        'pc': pc,
        'playstation': playstation,
        'nintendo': nintendo,
        'xbox': xbox,
        'rating': rating,
        'description': description,
      },
    ).then(
      (value) {
        if (kDebugMode) {
          print('Game updated successfully');
        }
      },
    ).catchError(
      (error) {
        if (kDebugMode) {
          print('updateGame error: $error');
        }
      },
    );
  }

  Future<void> updateGamePlatform(
    String title,
    bool pc,
    bool legacy,
    bool playstation,
    bool nintendo,
    bool xbox,
  ) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('Games').doc(title).update(
      {
        'pc': pc,
        'legacy': legacy,
        'playstation': playstation,
        'nintendo': nintendo,
        'xbox': xbox,
      },
    ).then(
      (value) {
        if (kDebugMode) {
          print('Platform updated successfully');
        }
      },
    ).catchError(
      (error) {
        if (kDebugMode) {
          print('updateGamePlatform error: $error');
        }
      },
    );
  }

  Future<void> updateRating(
    String title,
    int rating,
  ) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('Games').doc(title).update(
      {
        'rating': rating,
      },
    ).then(
      (value) {
        if (kDebugMode) {
          print('Rating updated successfully');
        }
      },
    ).catchError(
      (error) {
        if (kDebugMode) {
          print('updateGameRating error: $error');
        }
      },
    );
  }

  Future<void> updateDescription(
    String title,
    String description,
  ) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('Games').doc(title).update(
      {
        'description': description,
      },
    ).then(
      (value) {
        if (kDebugMode) {
          print('Description updated successfully');
        }
      },
    ).catchError(
      (error) {
        if (kDebugMode) {
          print('updateGameDescription error: $error');
        }
      },
    );
  }

  Future<void> updatePlayed(
    String title,
    bool played,
  ) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('Games').doc(title).update(
      {
        'played': played,
      },
    ).then(
      (value) {
        if (kDebugMode) {
          print('Played updated successfully');
        }
      },
    ).catchError(
      (error) {
        if (kDebugMode) {
          print('updatePlayed error: $error');
        }
      },
    );
  }

  Future<void> updateBeaten(
    String title,
    bool beaten,
  ) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('Games').doc(title).update(
      {
        'beaten': beaten,
      },
    ).then(
      (value) {
        if (kDebugMode) {
          print('Beaten updated successfully');
        }
      },
    ).catchError(
      (error) {
        if (kDebugMode) {
          print('updateBeaten error: $error');
        }
      },
    );
  }

  Future<void> updateDigitalPhysical(
    String title,
    bool digital,
    bool physical,
  ) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('Games').doc(title).update(
      {
        'digital': digital,
        'physical': physical,
      },
    ).then(
      (value) {
        if (kDebugMode) {
          print('Digital and physical updated successfully');
        }
      },
    ).catchError(
      (error) {
        if (kDebugMode) {
          print('updateDigitalPhysical error: $error');
        }
      },
    );
  }

  Future<QuerySnapshot> viewGames() async {
    if (!isInitialized) {
      await initializeDefault();
    }
    final CollectionReference games =
        FirebaseFirestore.instance.collection('Games');
    try {
      QuerySnapshot snapshot = await games.get();

      return snapshot;
    } catch (error) {
      if (kDebugMode) {
        print('getAllGames error: $error');
      }
      throw Exception('Failed to retrieve games: $error');
    }
  }

  Future<int> getNumGames() async {
    if (!isInitialized) {
      await initializeDefault();
    }
    late int numGames = 0;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final collection = FirebaseFirestore.instance.collection("Games");
    final query = collection;
    final countQuery = query.count();
    final AggregateQuerySnapshot snapshot = await countQuery.get();
    debugPrint("Count: ${snapshot.count}");
    numGames = snapshot.count;
    // DocumentSnapshot snapshot =
    //     await firestore.collection('Games').get().then();
    // int numGames = 0;
    // if (snapshot.data() != null) {
    //   numGames = snapshot.data()!.length;
    // }

    return numGames;
    // return 0;
  }

  Future<bool> getDigital(String title) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot ds = await firestore.collection('Games').doc(title).get();
    if (ds.data() != null) {
      Map<String, dynamic> data = (ds.data() as Map<String, dynamic>);
      if (data.containsKey(title)) {
        return data['digital'];
      }
    }
    return false;
  }

  Future<bool> getPhysical(String title) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot ds = await firestore.collection('Games').doc(title).get();
    if (ds.data() != null) {
      Map<String, dynamic> data = (ds.data() as Map<String, dynamic>);
      if (data.containsKey(title)) {
        return data['physical'];
      }
    }
    return false;
  }

  Future<bool> getBeaten(String title) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot ds = await firestore.collection('Games').doc(title).get();
    if (ds.data() != null) {
      Map<String, dynamic> data = (ds.data() as Map<String, dynamic>);
      if (data.containsKey(title)) {
        return data['beaten'];
      }
    }
    return false;
  }

  Future<bool> getPlayed(String title) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot ds = await firestore.collection('Games').doc(title).get();
    if (ds.data() != null) {
      Map<String, dynamic> data = (ds.data() as Map<String, dynamic>);
      if (data.containsKey(title)) {
        return data['played'];
      }
    }
    return false;
  }

  Future<bool> getPC(String title) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot ds = await firestore.collection('Games').doc(title).get();
    if (ds.data() != null) {
      Map<String, dynamic> data = (ds.data() as Map<String, dynamic>);
      if (data.containsKey(title)) {
        return data['pc'];
      }
    }
    return false;
  }

  Future<bool> getLegacy(String title) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot ds = await firestore.collection('Games').doc(title).get();
    if (ds.data() != null) {
      Map<String, dynamic> data = (ds.data() as Map<String, dynamic>);
      if (data.containsKey(title)) {
        return data['legacy'];
      }
    }
    return false;
  }

  Future<bool> getPlaystation(String title) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot ds = await firestore.collection('Games').doc(title).get();
    if (ds.data() != null) {
      Map<String, dynamic> data = (ds.data() as Map<String, dynamic>);
      if (data.containsKey(title)) {
        return data['playstation'];
      }
    }
    return false;
  }

  Future<bool> getNintendo(String title) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot ds = await firestore.collection('Games').doc(title).get();
    if (ds.data() != null) {
      Map<String, dynamic> data = (ds.data() as Map<String, dynamic>);
      if (data.containsKey(title)) {
        return data['nintendo'];
      }
    }
    return false;
  }

  Future<bool> getXbox(String title) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot ds = await firestore.collection('Games').doc(title).get();
    if (ds.data() != null) {
      Map<String, dynamic> data = (ds.data() as Map<String, dynamic>);
      if (data.containsKey(title)) {
        return data['physical'];
      }
    }
    return false;
  }

  Future<int> getRating(String title) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot ds = await firestore.collection('Games').doc(title).get();
    if (ds.data() != null) {
      Map<String, dynamic> data = (ds.data() as Map<String, dynamic>);
      if (data.containsKey(title)) {
        return data['rating'];
      }
    }
    return 0;
  }

  Future<String> getDescription(String title) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot ds = await firestore.collection('Games').doc(title).get();
    if (ds.data() != null) {
      Map<String, dynamic> data = (ds.data() as Map<String, dynamic>);
      if (data.containsKey(title)) {
        return data['description'];
      }
    }
    return "No Description";
  }

  Future<void> uploadImage(
    String title,
    io.File image,
  ) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    // Create a reference to the file we want to upload
    Reference storage =
        FirebaseStorage.instance.ref().child('images/$title.jpg');

    // Upload the file to the path 'images/title.jpg'
    UploadTask uploadTask = storage.putFile(image);
    uploadTask.then(
      (TaskSnapshot snapshot) {
        if (kDebugMode) {
          print('Image uploaded successfully');
        }
      },
    ).catchError(
      (error) {
        if (kDebugMode) {
          print('uploadImage error: $error');
        }
      },
    );
  }

  Future<String> getImageURL(
    String title,
  ) async {
    if (!isInitialized) {
      await initializeDefault();
    }
    FirebaseStorage storage = FirebaseStorage.instance;
    // Reference to our image file.
    Reference imageRef = storage.ref().child('images/$title.jpg');

    try {
      final url = await imageRef.getDownloadURL();
      if (url.isNotEmpty) {
        return url;
      } else if (url.isEmpty && kDebugMode) {
        return 'https://yaktribe.games/community/media/placeholder-jpg.84782/full';
      }
    } catch (error) {
      if (kDebugMode) {
        print('getImageURL error: $error');
      }
    }
    return 'https://yaktribe.games/community/media/placeholder-jpg.84782/full';
    // Max image size is 10 MB (1024 * 1024 * 10)
    // const imageSize = 10485760;
    // final path = "/Game_Images/$title.jpg";
    // final ref = storage.child(path);
    // final Uint8List? data = await ref.getData();
    // if (data == null) {
    //   return null;
    // }
    // final io.image image = File(title).create();
    // image.wirteAsBytesSync(data);
    // return image;
  }
}
