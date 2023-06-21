class Usuario{
  int _id, _num_registro, _cpf, _rg;
  String _nome, _senha, _data_nascimento;

  Usuario(this._id, this._num_registro, this._cpf, this._rg, this._nome,
      this._senha, this._data_nascimento);

  get data_nascimento => _data_nascimento;

  set data_nascimento(value) {
    _data_nascimento = value;
  }

  get senha => _senha;

  set senha(value) {
    _senha = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  get rg => _rg;

  set rg(value) {
    _rg = value;
  }

  get cpf => _cpf;

  set cpf(value) {
    _cpf = value;
  }

  get num_registro => _num_registro;

  set num_registro(value) {
    _num_registro = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}