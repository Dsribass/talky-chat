import 'package:core/core.dart';

typedef ValidateEmailParams = ({String email});

final class ValidateEmail extends UseCase<Unit, ValidateEmailParams> {
  ValidateEmail({required super.logger});

  @override
  Future<Unit> execute(ValidateEmailParams params) async {
    final email = params.email;

    if (email.isEmpty) {
      throw TKEmptyInputException(message: 'Email cannot be empty');
    }

    // Regex to validate email format
    final regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    if (!regex.hasMatch(email)) {
      throw TKInvalidInputException(message: 'Invalid email format');
    }

    return unit;
  }
}