part of database;

@UseDao(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  final AppDatabase db;

  UserDao(this.db) : super(db);

  Future<List<User>> getAllUsers() => select(users).get();

  Stream<List<User>> watchAllUsers() => select(users).watch();

  Future<User> firstUser() => select(users).getSingle();

  Future insertUser(User user) => into(users).insert(user);

  Future updateUser(User user) => update(users).replace(user);

  Future deleteUser(User user) => delete(users).delete(user);

  Future<User> findUserById(int id) =>
      (select(users)..where((u) => u.id.equals(id))).getSingle();
}
