import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/Models/food_model.dart';
import 'package:foodie/Screens/Widgets/profile_widgets.dart';

class ViewWidgets {
  late FoodModel foodModel;
  ViewWidgets(FoodModel f1) {
    foodModel = f1;
  }
  Widget image() {
    return Container(
      width: 300,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: NetworkImage(foodModel.url),
          fit: BoxFit.cover,
        ),
        border: Border.all(
          color: Colors.white,
          width: 8,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget detailsBox(String s1, String s2) {
    TextStyle style1 = const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
        fontStyle: FontStyle.italic);

    TextStyle style2 = const TextStyle(
      
      fontSize: 24,
      
    );
    return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
      children: [
  
      const SizedBox(height: 15,),
      Text(
        s1,
        style: style1,
      ),
      const SizedBox(height: 5,),
      Text(
        s2,
        style: style2,
      ),
    ]);
  }

  Widget details() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          detailsBox(
            "Food item",
            foodModel.name,
          ),
          ProfileWidgets().liner(),
          detailsBox("HotelName:", foodModel.hotelName),
          ProfileWidgets().liner(),
          detailsBox("Conetents per one meal:", foodModel.contents),
          ProfileWidgets().liner(),
          detailsBox("Date & Time:", foodModel.time),
          ProfileWidgets().liner(),
          detailsBox("No of meals available :", foodModel.no.toString()),
        ],
      ),
    );
    // return Flexible(
    //   // to fix overflowing texts
    //   child: RichText(
    //     maxLines: 2,
    //     overflow: TextOverflow.ellipsis,
    //     text: TextSpan(
    //         children: <TextSpan>[
    //              detailsBox("Food item", foodModel.name),
    //              detailsBox("HotelName", foodModel.hotelName),
    //              detailsBox("Conetents per one meal", foodModel.contents),
    //              detailsBox("Starting time", foodModel.time),
    //              detailsBox("No of meals left", foodModel.no.toString())
    //         ]),
    //   ),
    // );
  }
}
