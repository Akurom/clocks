import 'package:clocks/const/color_constants.dart';
import 'package:clocks/utils/utils.dart';
import 'package:flutter/material.dart';

typedef void VoidCallback();

class Menu extends StatelessWidget {
  final VoidCallback callback;

  const Menu({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: screenWidth(context) * 3 / 4,
      height: screenHeight(context),
      child: Stack(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 42,
                    ),
                    onTap: callback),
              ),
              Text("Menu Debug",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorConstants.inverse)),
              Text("Menu Debug",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorConstants.inverse)),
              Text("Menu Debug",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorConstants.inverse)),
              Text("Menu Debug",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorConstants.inverse)),
              Text("Menu Debug",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorConstants.inverse)),
            ],
          )
        ],
      ),
    );
  }
}
