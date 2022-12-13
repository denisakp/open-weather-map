class HTTPException implements Exception {
  HTTPException(this.status, this.message);

  final int status;
  final String message;

  @override
  String toString() {
    return 'HTTP EXCEPTION: {status: $status, message: $message}';
  }
}