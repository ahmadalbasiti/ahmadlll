abstract class DBControllerOperation<Model> {
  Future<int> create(Model model);

  Future<bool> update(Model model);

  Future<bool> delete(int id);

  Future<List<Model>> read();

  Future<Model?> show(int id);
}
