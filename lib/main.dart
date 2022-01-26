import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/data_provider/local_storage_todos_api.dart';
import './bootstrap.dart';

Future<void> main() async {
  FlutterServicesBinding.ensureInitialized();

  final todosApi = LocalStorageTodosApi(
    plugin: await SharedPreferences.getInstance(),
  );

  bootstrap(todosApi: todosApi);
}
