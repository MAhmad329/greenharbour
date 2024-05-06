class Question {
  final String question;
  final List<String> options;
  final String pickedAnswer;
  final String descripton;

  const Question(
      {required this.question,
      this.descripton = '',
      required this.options,
      required this.pickedAnswer});
}
