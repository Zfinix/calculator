import 'package:calculator/viewmodel/app_vm.dart';
import 'package:hooks_riverpod/all.dart';

final appVM = ChangeNotifierProvider((_) => AppViewModel());
