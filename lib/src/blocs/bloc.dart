import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // Add data to stream
  Stream<String> get email => _email.stream
      .transform(validateEmail); //return stream with Handler Attached
  Stream<String> get password => _password.stream
      .transform(validatePassword); // returh stream with Handler Attached
  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (e, p) => true);

  submit() {
    final validEmail = _email.value;
    final validPassword = _password.value;
    print(validEmail);
    print(validPassword);
  }

  // Change data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  // Clean up created objects.
  // Flutter Convention
  dispose() {
    _email.close();
    _password.close();
  }
}

final bloc = Bloc();
