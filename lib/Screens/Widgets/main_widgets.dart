import 'package:flutter/material.dart';
import 'package:foodie/Models/food_model.dart';
import 'package:foodie/Screens/Functions/main_functions.dart';

class MainWidgets {
  final mainFucntions = MainFunctions();
  Widget foodCard(FoodModel food, BuildContext ctx) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(food.url),
                fit: BoxFit.cover,
              ),
            ),
            height: 80,
            width: 100,
          ),
          Expanded(
            child: Card(
              color: Colors.white,
              child: InkWell(
                  splashColor: Colors.black87,
                  onTap: () {
                    mainFucntions.handleClick2(ctx, food);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              food.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Text(
                              food.hotelName,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.normal,
                                  height: 1.3),
                            ),
                            Text(
                              food.contents,
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black54,
                                  height: 1.5),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              child: Text(
                                "${food.no - food.noBooked}",
                                style: const TextStyle(color: Colors.black),
                              ),
                              backgroundColor: Colors.black12,
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    ));
  }
}
