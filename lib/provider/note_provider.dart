import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteNotifier extends ChangeNotifier {
  List notelist = [];
  void onsavednote(String note) {
    notelist.add(note);
    notifyListeners();
  }

  void removenote(int index) {
    notelist.removeAt(index);
    notifyListeners();
  }
}

final noteprovider = ChangeNotifierProvider<NoteNotifier>((ref){
  return NoteNotifier();
});

