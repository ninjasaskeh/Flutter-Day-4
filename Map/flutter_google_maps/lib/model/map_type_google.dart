enum Type {
  Normal,
  Hybrid,
  terrain,
  Satelite
}

class MapTypeGoogle {
  Type type;

  MapTypeGoogle({required this.type});
}
List<MapTypeGoogle> googleMapTypes = [
 MapTypeGoogle(type: Type.Normal),
 MapTypeGoogle(type: Type.Hybrid),
 MapTypeGoogle(type: Type.terrain),
 MapTypeGoogle(type: Type.Satelite),
];



