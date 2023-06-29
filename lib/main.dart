import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testo_maps/cubit_data/business_logic/cubit/maps_test_tracking/maps_cubit_tracking.dart';
import 'package:testo_maps/presentation/screens/map_screen_tracking.dart';
import 'package:testo_maps/presentation/screens/maps_screen.dart';

import 'cubit_data/business_logic/cubit/maps/maps_cubit.dart';
import 'data/repository/maps_repo.dart';
import 'data/webservices/places_webservices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      // options:  DefaultFirebaseOptions.currentPlatform ,

      );
  runApp(const MyApp());
}
MapsRepository mapsRepository =MapsRepository(PlacesWebservices());
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => MapsCubit(
           mapsRepository
          ),
        ),
         BlocProvider(
          create: (BuildContext context) => MapsCubitTracking (
           mapsRepository
          )..getMyCurrentLocation()..getMarker(),//..getMarkerShape(),
        )
      ],
      child: MaterialApp(
        title: 'AIzaSyA3sNpacU68uIyYvd6tEuq7InE2KNU_xRg',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MapScreenTracking(),
      ),
    );
  }
}


/* 
 BlocProvider(
            create: (BuildContext context) =>
                MapsCubit(MapsRepository(PlacesWebservices())),
            child: MapScreen(),
          ),
*//*   geodestinationPoint =   await placesWebservices.getStartPlace().whenComplete(() {
    // print('111111111111111111111 ${geodestinationPoint?.latitude}');
    });
      PlacesWebservices placesWebservices =PlacesWebservices();
  late final GeoPoint? geodestinationPoint 
     */