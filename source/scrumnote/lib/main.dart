import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'note.dart';

void main() => runApp(MaterialApp(
  title: "Flutter tutorial",
  home: home(),
));

class home extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu), tooltip: "Navi", onPressed: null),
        title: Center(
          child: Text("Note"),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search), tooltip: "Search", onPressed: null)
        ],
      ),
      body: Center(
        child: listnote(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Ađd",
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TutorialHome()),
          );
        },
      ),
    );
  }
}

class listnote extends StatelessWidget{
  final title = 'Grid List';
  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
    title: Text(title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: Colors.blue[500],
    ),
    trailing: Icon(Icons.keyboard_arrow_right),
  );
  @override
  Widget build(BuildContext context) {
  return ListView.builder(
    itemCount: 1,
    itemBuilder: (context, index) {
      return ListTile(
        title: _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
        // When a user taps the ListTile, navigate to the DetailScreen.
        // Notice that you're not only creating a DetailScreen, you're
        // also passing the current todo through to it.
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TutorialHome(todo: "Le van tri"),
            ),
          );
        },
      );
    },
//    children: [
//      _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
//      _tile('The Castro Theater', '429 Castro St', Icons.theaters),
//      _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
//      _tile('Roxie Theater', '3117 16th St', Icons.theaters),
//      _tile('United Artists Stonestown Twin', '501 Buckingham Way',
//          Icons.theaters),
//      _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
//      Divider(),
//      _tile('Kescaped_code#39;s Kitchen', '757 Monterey Blvd', Icons.restaurant),
//      _tile('Emmyescaped_code#39;s Restaurant', '1923 Ocean Ave', Icons.restaurant),
//      _tile(
//          'Chaiya Thai Restaurant', '272 Claremont Blvd', Icons.restaurant),
//      _tile('La Ciccia', '291 30th St', Icons.restaurant),
//    ],
  );
  }
}

class listview extends StatefulWidget{
  @override
  content createState() => new content();
}

class content extends State<listview>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: new Center(
        child: new FutureBuilder(builder: null),
      ),
    );
  }
}
