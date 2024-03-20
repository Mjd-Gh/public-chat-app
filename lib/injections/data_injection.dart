import 'package:get_it/get_it.dart';
import 'package:public_chat_app/services/database_services.dart';

class DataInjection {
  void setupDataInjection() {
    GetIt.I.registerSingleton<DBService>(DBService());
  }
}
