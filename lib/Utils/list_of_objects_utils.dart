import 'dart:math';

import '../Network/Database/drift_database.dart';
import 'custom_extension.dart';

class ListOfObjectsUtils {
  static final instance = ListOfObjectsUtils();

  final List<String> _listOfNames = [
    'CAPTAIN MARVEL',
    'IRON MAN',
    'THOR',
    'GUARDIANS OF THE GALAXY',
    'AVENGERS: AGE OF ULTRON',
    'ANT-MAN',
    'BLACK WIDOW',
    'BLACK PANTHER',
    'DOCTOR STRANGE',
    'SHANG-CHI AND THE LEGEND OF THE TEN RINGS',
    'SPIDER-MAN: FAR FROM HOME',
    'AVENGERS: ENDGAME',
    'THE INCREDIBLE HULK'
  ];

  final List<String> _listOfDescription = [
    "Packed with action, humor, and visual thrills, Captain Marvel introduces the MCU's latest hero with an origin story that makes effective use of the franchise's signature formula.",
    "Powered by Robert Downey Jr.'s vibrant charm, Iron Man turbo-charges the superhero genre with a deft intelligence and infectious sense of fun.",
    "A dazzling blockbuster that tempers its sweeping scope with wit, humor, and human drama, Thor is mighty Marvel entertainment.",
    "Guardians of the Galaxy is just as irreverent as fans of the frequently zany Marvel comic would expect -- as well as funny, thrilling, full of heart, and packed with visual splendor.",
    "Exuberant and eye-popping, Avengers: Age of Ultron serves as an overstuffed but mostly satisfying sequel, reuniting its predecessor's unwieldy cast with a few new additions and a worthy foe.",
    "Led by a charming performance from Paul Rudd, Ant-Man offers Marvel thrills on an appropriately smaller scale -- albeit not as smoothly as its most successful predecessors.",
    "Black Widow's deeper themes are drowned out in all the action, but it remains a solidly entertaining standalone adventure that's rounded out by a stellar supporting cast.",
    "Black Panther elevates superhero cinema to thrilling new heights while telling one of the MCU's most absorbing stories -- and introducing some of its most fully realized characters.",
    "Doctor Strange artfully balances its outrÃ© source material against the blockbuster constraints of the MCU, delivering a thoroughly entertaining superhero origin story in the bargain.",
    "Shang-Chi and the Legend of the Ten Rings isn't entirely free of Marvel's familiar formula, but this exciting origin story expands the MCU in more ways than one.",
    "A breezily unpredictable blend of teen romance and superhero action, Spider-Man: Far from Home stylishly sets the stage for the next era of the MCU.",
    "Exciting, entertaining, and emotionally impactful, Avengers: Endgame does whatever it takes to deliver a satisfying finale to Marvel's epic Infinity Saga.",
    "The Incredible Hulk may not be quite the smashing success that fans of Marvel's raging behemoth might hope for, but it offers more than enough big green action to make up for its occasionally puny narrative."
  ];

  final List<String> _listOfImages = [
    'assets/image_0.jpg',
    'assets/image_1.jpg',
    'assets/image_2.jpg',
    'assets/image_3.jpg',
    'assets/image_4.jpg',
    'assets/image_5.jpg',
    'assets/image_6.jpg',
    'assets/image_7.jpg',
    'assets/image_8.jpg',
    'assets/image_9.jpg',
    'assets/image_10.jpg',
    'assets/image_11.jpg',
    'assets/image_12.jpg',
    'assets/image_13.jpg',
    'assets/image_14.jpg',
    'assets/image_15.jpg'
  ];

  final List<int> _listOfId = [
    101,
    102,
    103,
    104,
    105,
    106,
    107,
    108,
    109,
    110
  ];

  final List<int> _listOfDirectorId = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  String getRandomNames() => _listOfNames.randomItem();
  String getRandomDescription() => _listOfDescription.randomItem();
  String getRandomImage() => _listOfImages.randomItem();
  int getRandomId() => _listOfId.randomItem();
  int getRandomDirectorId() => _listOfDirectorId.randomItem();

  List<String> getImageList() => _listOfImages;

  static Movie getRandomObject() => Movie(
        id: Random().nextInt(100000),
        directorID: ListOfObjectsUtils.instance.getRandomDirectorId(),
        name: ListOfObjectsUtils.instance.getRandomNames(),
        detail: ListOfObjectsUtils.instance.getRandomDescription(),
        image: ListOfObjectsUtils.instance.getRandomImage(),
        isMovieWatched: false,
      );

  List<Movie> getMovieData() {
    var listOfAllMovieData = <Movie>[];

    for (int index = 0; index < 10; index++) {
      var getRandomCardObjectItem = getRandomObject();
      listOfAllMovieData.add(getRandomCardObjectItem);
    }

    return listOfAllMovieData;
  }
}
