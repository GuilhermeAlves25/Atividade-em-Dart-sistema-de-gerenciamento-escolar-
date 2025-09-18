
class Pessoa {
  String nome;
  int idade;

  Pessoa(this.nome, this.idade);

  void mostrar() {
    print("Nome: $nome, Idade: $idade");
  }
}


class Aluno extends Pessoa {
  String matricula;

  Aluno(String nome, int idade, this.matricula) : super(nome, idade);

  @override
  void mostrar() {
    print("--- Aluno ---");
    super.mostrar();
    print("Matrícula: $matricula");
  }
}


class Professor extends Pessoa {
  final String id;
  String especialidade;


  Professor(this.id, String nome, int idade, this.especialidade) : super(nome, idade);

  @override
  void mostrar() {
    print("\n--- Professor ---");
    print("ID: $id");
    super.mostrar();
    print("Especialidade: $especialidade");
  }
}


class Disciplina {
  String nome;
  int cargaHoraria;

  Disciplina(this.nome, this.cargaHoraria);

  void exibir() {
    print("Disciplina: $nome, Carga Horária: ${cargaHoraria}h");
  }
}


class Nota {
  Aluno aluno;
  Disciplina disciplina;
  double valor;

  Nota(this.aluno, this.disciplina, this.valor);

  void exibir() {
    print("Nota de ${aluno.nome} em ${disciplina.nome}: $valor");
  }
}


class Turma {
  String codigo;
  Disciplina disciplina;
  Professor professor;
  List<Aluno> alunos;

  Turma(this.codigo, this.disciplina, this.professor) : alunos = [];

  void adicionarAluno(Aluno aluno) {
    alunos.add(aluno);
    print("Aluno ${aluno.nome} adicionado à turma $codigo.");
  }

  void removerAluno(String matricula) {
    alunos.removeWhere((aluno) => aluno.matricula == matricula);
    print("Aluno com matrícula $matricula removido.");
  }

  void listarAlunos() {
    print("\n--- Alunos da Turma $codigo (${disciplina.nome}) ---");
    if (alunos.isEmpty) {
      print("Nenhum aluno matriculado nesta turma.");
    } else {
      for (var aluno in alunos) {
        print("- ${aluno.nome} (Matrícula: ${aluno.matricula})");
      }
    }
  }

  void exibirDetalhes() {
    print("\n======== Detalhes da Turma $codigo ========");
    disciplina.exibir();
    professor.mostrar();
    listarAlunos();
    print("======================================\n");
  }
}