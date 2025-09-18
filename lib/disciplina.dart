
class Disciplina {
  String nome;
  int cargaHoraria;

  Disciplina(this.nome, this.cargaHoraria);

  void exibir() {
    print("Disciplina: $nome, Carga Horária: ${cargaHoraria}h");
  }
}