import 'auth_user.dart';

abstract class AuthProviders{
  // to initialize firebase
  Future<void> initialize();

  // this is getter function which gets the current user from firebase
  AuthUser? get currentUser;

  //this function is for login
  Future<AuthUser> logIn({required String email, required String password});

  Future<AuthUser> createUser({required String email, required String password});

  Future<void> logOut();

  Future<void> sendEmailVerification();


}