import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'Appcolors.dart';

class Helpingwidgets{
  Widget customloader(){
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        size: 50, color: Appcolors().whitecolor,
      ),
    );
  }
}