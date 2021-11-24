import 'package:flutter_dss/base.dart' as base;

class Picker{

  String pick(wo){
    switch(wo){
      case 'Push Up':
        return base.pushup;
      case 'Push Up Militer':
        return base.pushup;
      case 'Decline Push Up':
        return base.pushupdecline;
      case 'Diamond Push Up':
        return base.pushupdiamond;
      case 'Rotation Push Up':
        return base.pushuprotation;
      case 'Knee Push Up':
        return base.pushupknee;
      case 'Tricep Dips':
        return base.tricepdips;
      case 'Inchworm':
        return base.inchworm;
      case 'Pukulan':
        return base.punch;
      case 'Plank Naik Turun':
        return base.plankup;
      default:
        return base.def;
    }
  }
}