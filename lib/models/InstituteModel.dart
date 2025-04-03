import 'dart:typed_data';

class Institute {
  String name;
  String address;
  Uint8List imageUrl;

  Institute(
      {required this.name, required this.address, required this.imageUrl});
}
