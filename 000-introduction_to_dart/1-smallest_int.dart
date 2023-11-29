int getSmallestInteger(List<int> myList) {
  int smallest = myList[0];
  for (int i = 0; i < myList.length; i++) {
    if (myList[i] < smallest) {
      smallest = myList[i];
    }
  }
  return smallest;
}

void printRightAngleTriangle(int height) {
  for (int i = 1; i <= height; i++) {
    for (int j = 1; j <= i; j++) {
      print("*");
    }
    print("\n");
  }
}
