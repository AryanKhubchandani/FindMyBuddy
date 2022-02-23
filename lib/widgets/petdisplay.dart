import 'package:find_my_buddy/widgets/petcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../petlist.dart';

class PetDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: pets.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: PetCard(
              petId: pets[index]['id'],
              petName: pets[index]['name'],
              age: pets[index]['age'],
              breed: pets[index]['breed'],
              gender: pets[index]['gender'],
              number: pets[index]['number'],
              imagePath: pets[index]['imagePath'],
            ),
          );
        },
      ),
    );
  }
}
