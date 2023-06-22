class Usuario {
  int? numRegistro;
  String? cpf;
  int? rg;
  String? nome;
  String? senha;
  String? dataNascimento;

  Usuario({
    this.numRegistro,
    this.cpf,
    this.rg,
    this.nome,
    this.senha,
    this.dataNascimento,
  });

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      numRegistro: map['num_registro'],
      cpf: map['cpf'],
      rg: map['rg'],
      nome: map['nome'],
      senha: map['senha'],
      dataNascimento: map['data_nascimento'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'num_registro': numRegistro,
      'cpf': cpf,
      'rg': rg,
      'nome': nome,
      'senha': senha,
      'data_nascimento': dataNascimento,
    };
  }
}
