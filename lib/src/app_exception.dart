class AppException implements Exception {
  final String message;
  final String code;

  AppException(this.message, this.code);

  @override
  String toString() {
    return 'AppException{message: $message, code: $code}';
  }
}

class FetchDataException extends AppException {
  FetchDataException(String message, String code) : super(message, code);
}

class BadRequestException extends AppException {
  BadRequestException(String message, String code) : super(message, code);
}

class UnauthorisedException extends AppException {
  UnauthorisedException(String message, String code) : super(message, code);
}

class InvalidInputException extends AppException {
  InvalidInputException(String message, String code) : super(message, code);
}

class NotFoundException extends AppException {
  NotFoundException(String message, String code) : super(message, code);
}

class ServerException extends AppException {
  ServerException(String message, String code) : super(message, code);
}

class UnknownException extends AppException {
  UnknownException(String message, String code) : super(message, code);
}

class NoInternetException extends AppException {
  NoInternetException(String message, String code) : super(message, code);
}

class TimeoutException extends AppException {
  TimeoutException(String message, String code) : super(message, code);
}

class UnsupportedException extends AppException {
  UnsupportedException(String message, String code) : super(message, code);
}
