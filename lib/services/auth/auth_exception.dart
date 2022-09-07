// login exception
class UserNotFoundException implements Exception{}
class WrongPasswordException implements Exception{}

//register exceptions
class WeakPasswordException implements Exception{}
class EmailAlreadyUsedException implements Exception{}
class InvalidEmailException implements Exception{}

// generic exception
class GenericException implements Exception{}
class UserNotLoggedInException implements Exception{}
