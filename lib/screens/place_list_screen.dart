import 'package:flutter/material.dart';
import 'package:places/providers/great_places.dart';
import 'package:places/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatefulWidget {
  PlacesListScreen({Key key}) : super(key: key);

  @override
  _PlacesListScreenState createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Place'),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              color: Colors.white,
              child: Icon(Icons.add))
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatPlaces>(
                  child: Center(
                    child: Text('Got no place yet. add some'),
                  ),
                  builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <=
                          0
                      ? ch
                      : ListView.builder(
                          itemBuilder: (ctx, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlaces.items[index].image),
                              ),
                              title: Text(greatPlaces.items[index].title),
                              onTap: () {},
                            );
                          },
                          itemCount: greatPlaces.items.length,
                        ),
                ),
        ),
      ),
    );
  }
}
