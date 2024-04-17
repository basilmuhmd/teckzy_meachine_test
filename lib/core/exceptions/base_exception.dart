abstract base class BaseException {
  final String message;

  BaseException({required this.message});

  @override
  String toString() {
    return message;
  }
}
