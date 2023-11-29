Map<String, int> characterFrequency(String inputString) {
  Map<String, int> frequency = {};
  for (int i = 0; i < inputString.length; i++) {
    if (frequency.containsKey(inputString[i])) {
      frequency[inputString[i]];
    } else {
      frequency[inputString[i]] = 1;
    }
  }
  return frequency;
}
