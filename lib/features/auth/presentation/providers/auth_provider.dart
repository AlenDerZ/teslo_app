
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_app/features/auth/infrastructure/infrastructure.dart';

import '../../domain/domain.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {

  final authRepository = AuthRepositoryImpl();
  return AuthNotifier(
    authRepository: authRepository
  );
});

class AuthNotifier extends StateNotifier<AuthState> {

  final AuthRepository authRepository;

  AuthNotifier({
    required this.authRepository
  }): super( AuthState() );

  void loginUser(String email, String password) async {

    // final user = await authRepository.login(email, password);

    // state = state.copyWith( authStatus: AuthStatus.authenticated, user: user, erroMessage)

  }

  void registerUser(String fullName, String email, String password) {
    
  }

  void checkAuthStatus() async{

  }
  
}

enum AuthStatus { checking, authenticated, notAuthenticated }
class AuthState{
  final AuthStatus authStatus;
  final User? user;
  final String erroMessage;

  AuthState({
    this.authStatus = AuthStatus.checking, 
    this.user, 
    this.erroMessage = ''
    });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? erroMessage
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    erroMessage: erroMessage ?? this.erroMessage
  );
  
}