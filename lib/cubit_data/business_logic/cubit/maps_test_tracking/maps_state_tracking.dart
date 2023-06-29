part of 'maps_cubit_tracking.dart';

@immutable
abstract class MapsStateTracking {}

class MapsInitial extends MapsStateTracking {}

class PlacesLoaded extends MapsStateTracking {
  final List<PlaceSuggestion> places;

  PlacesLoaded(this.places);

}

class PlaceLocationLoaded extends MapsStateTracking {
  final Place place;

  PlaceLocationLoaded(this.place);

}


class DirectionsLoaded extends MapsStateTracking {
  final PlaceDirections placeDirections;

  DirectionsLoaded(this.placeDirections);

}
class LocationUpdated extends MapsStateTracking {
  
}
class DirectionsSuccessLoaded extends MapsStateTracking {}
class ChangeMarkerPosition extends MapsStateTracking {}