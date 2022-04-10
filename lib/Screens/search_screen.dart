import 'package:flutter/material.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch
({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search page"),),
      body:       // // Search
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)),
              width: 330,
              child: TextFormField(
                  autofocus: false,
                  // controller: secondNameEditingController,

                  keyboardType: TextInputType.name,
                  // onSaved: (value) {
                  //   secondNameEditingController.text = value!;
                  // },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Search your Favourites",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  )),
            ),
          ],
        ),
        // search OVER,
    );
  }
}