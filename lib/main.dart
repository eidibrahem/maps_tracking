import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testo_maps/presentation/screens/maps_screen.dart';

import 'cubit_data/business_logic/cubit/maps/maps_cubit.dart';
import 'data/repository/maps_repo.dart';
import 'data/webservices/places_webservices.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      // options:  DefaultFirebaseOptions.currentPlatform ,

      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
     create: (BuildContext context) =>
                MapsCubit(MapsRepository(PlacesWebservices())),
      child: MaterialApp(
        title: 'AIzaSyDxwgpsyd2Pwx6dHM_X2CgSnTJalzte-fw',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
         
          
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MapScreen(),
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
*/