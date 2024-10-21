// Classe que representa o cálculo de calorias diárias.
class CalorieCalculation {
  final double weight; // Peso do usuário em kg.
  final double height; // Altura do usuário em cm.
  final int age; // Idade do usuário em anos.
  final double calories; // Calorias calculadas.
  final String? goal; // Objetivo do usuário (ex: perda de peso, ganho de peso).
  final String? activityLevel; // Nível de atividade física do usuário.
  final String gender; // Gênero do usuário (masculino ou feminino).
  final double
      recommendedCalories; // Calorias recomendadas com base no cálculo.

  // Construtor da classe, que recebe todos os parâmetros necessários.
  CalorieCalculation({
    required this.weight,
    required this.height,
    required this.age,
    required this.calories,
    required this.gender, // Gênero do usuário (adicionado).
    required this.recommendedCalories, // Calorias recomendadas (adicionado).
    this.goal,
    this.activityLevel,
  });

  // Método para converter os dados da classe em um formato JSON.
  Map<String, dynamic> toJson() {
    return {
      'weight': weight, // Peso em kg.
      'height': height, // Altura em cm.
      'age': age, // Idade em anos.
      'calories': calories, // Calorias calculadas.
      'goal': goal, // Objetivo do usuário.
      'activityLevel': activityLevel, // Nível de atividade física.
      'gender': gender, // Gênero do usuário (adicionado).
      'recommendedCalories':
          recommendedCalories, // Calorias recomendadas (adicionado).
    };
  }

  // Método de fábrica para criar uma instância da classe a partir de um JSON.
  factory CalorieCalculation.fromJson(Map<String, dynamic> json) {
    return CalorieCalculation(
      weight: json['weight'], // Peso em kg.
      height: json['height'], // Altura em cm.
      age: json['age'], // Idade em anos.
      calories: json['calories'], // Calorias calculadas.
      goal: json['goal'], // Objetivo do usuário.
      activityLevel: json['activityLevel'], // Nível de atividade física.
      gender: json['gender'], // Gênero do usuário (adicionado).
      recommendedCalories:
          json['recommendedCalories'], // Calorias recomendadas (adicionado).
    );
  }
}
