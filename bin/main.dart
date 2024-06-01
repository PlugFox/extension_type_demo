void main([List<String>? args]) {
  // https://dart.dev/language/extension-types

  final list = ImmutableList<int>(<int>[1, 2, 3]);

  Iterable.generate(3, (index) => index + 1).length;

  print(list);
  print(list[0]);
  print(list.length);
  for (final item in list) {
    print(item);
  }
}

extension type ImmutableList<T>(List<T> _source) implements Iterable<T> {
  factory ImmutableList.empty() => ImmutableList<T>(List.empty());

  T operator [](int index) => _source[index];
}
