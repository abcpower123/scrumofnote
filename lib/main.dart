import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MaterialApp(
      title: "Flutter tutorial",
      home: TutorialHome(),
    ));

class TutorialHome extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu), tooltip: "Navi", onPressed: null),
        title: Center(
          child: Text("Hello world"),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search), tooltip: "Search", onPressed: null)
        ],
      ),
      body: Center(
        child: Note(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Ađd",
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}

class Note extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(8.0),
        // hack textfield height
        padding: EdgeInsets.only(bottom: 40.0),
        child: TextField(
          maxLines: 99,
          decoration: InputDecoration(
            hintText: "Comment!",
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class Gridlayoutt extends StatelessWidget {
  List<String> events = [
    "New"
        "Family"
        "Friends"
        "Study"
        "Riori"
        "Other"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/icon2.png"), fit: BoxFit.cover),
      ),
      child: Container(
        child: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: events.map((title) {
            return GestureDetector(
              child: Card(
                margin: const EdgeInsets.all(20.0),
                child: getCardByTitle(title),
              ),
              onTap: () {
                Fluttertoast.showToast();
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Column getCardByTitle(String title) {
    String img = "";
    if (title == "Family") {
      img = "assets/icon3.png";
    } else if (title == "Friends") {
      img = "assets/icon1.png";
    } else if (title == "Study") {
      img = "assets/icon2.png";
    } else if (title == "Riori") {
      img = "assets/icon4.png";
    } else if (title == "New") {
      img = "assets/icon5.png";
    } else if (title == "Other") {
      img = "assets/icon6.png";
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Center(
            child: Container(
          child: new Stack(
            children: <Widget>[new Image.asset(img, width: 80.0, height: 80.0)],
          ),
        )),
        Text(title,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
      ],
    );
  }
}
