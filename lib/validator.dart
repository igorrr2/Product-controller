class Validator {
  static String? validateName({required String ?name}) {
    if (name == null) {
      return null;
    }
    if (name.isEmpty) {
      return 'O campo nome não pode ficar vazio';
    }

    return null;
  }

  static String? validateEmail({required String ?email}) {
    // ignore: unnecessary_null_comparison
    if (email == null) {
      return null;
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'O campo email não pode estar vazio';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Digite um email correto';
    }

    return null;
  }

  static String? validatePassword({required String ?password}) {
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'A senha não pode estar em branco';
    } else if (password.length < 6) {
      return 'Digite uma senha com comprimento de pelo menos 6 caracteres';
    }

    return null;
  }
}