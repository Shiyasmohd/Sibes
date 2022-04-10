import 'dart:ffi';

class FoodModel {
  final String itemId;
  final String name;
  final String type;
  final String time;
  final String url;
  final String userId;
  final bool veg;
  final String hotelName;
  final String contents;
  final int no;
   int noBooked;
   List<dynamic> bookings;

  FoodModel(
    this.itemId,
    this.name,
    this.type,
    this.time,
    this.url,
    this.userId,
    this.veg,
    this.hotelName,
    this.contents,
    this.no,
    this.noBooked,
    this.bookings
  );
  factory FoodModel.fromMap1(map) {
    return FoodModel(
      map["itemId"],
      map['name'],
      map["type"],
      map['time'],
      map['url'],
      map['userId'],
      map["veg"],
      map["hotelName"],
      map["contents"],
      map["no"],
      map["noBooked"],
      map["bookings"]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "itemId": itemId,
      "name": name,
      "type": type,
      "time": time,
      "url": url,
      "userId": userId,
      "veg": veg,
      "hotelName": hotelName,
      "contents": contents,
      "no": no,
      "noBooked": noBooked,
      "bookings":bookings
    };
  }
}
