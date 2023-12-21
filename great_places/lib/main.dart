import 'package:flutter/material.dart';
import 'package:great_places/screens/place_form_screen.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';
import './screens/places_list_screen.dart';
import 'provider/great_places.dart';

/*
Erro no localization, tive que colocar:

location:
    git:
      url: https://github.com/781flyingdutchman/flutterlocation.git
      ref: 'V4'
      path: packages/location

https://github.com/Lyokone/flutterlocation/issues/843
https://github.com/Lyokone/flutterlocation/issues/838
*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          //accentColor: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlacesListScreen(),
        routes: {
          AppRoutes.PLACE_FORM: (ctx) => PlaceFormScreen(),
        },
      ),
    );
  }
}
