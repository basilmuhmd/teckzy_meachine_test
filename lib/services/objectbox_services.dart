import 'package:login_list_products/models/user_entity.dart';
import 'package:login_list_products/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  late final Store _store;

  static late ObjectBox _instance;

  late Box<UserEntity> user;

  static ObjectBox get instance {
    return _instance;
  }

  ObjectBox._create(this._store) {
    user = _store.box<UserEntity>();
  }

  static Future<void> createDB() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "dummyjson"));
    final instance = ObjectBox._create(store);
    _instance = instance;
  }
}
