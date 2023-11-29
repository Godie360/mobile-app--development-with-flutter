List<int> factorizeToPrimeNumbers(int number) {
  List<int> primeNumbers = [];
  int divisor = 2;
  while (number > 1) {
    if (number % divisor == 0) {
      primeNumbers.add(divisor);
      number = number ~/ divisor;
    } else {
      divisor++;
    }
  }
  return primeNumbers;
}
