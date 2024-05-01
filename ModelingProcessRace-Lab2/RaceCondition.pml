show int shared = 1;

active proctype Writer() {
  int temp = 10;  // Assign a new value
  shared = temp;  // Write to shared variable
  printf("Writer: shared = %d\n", shared);
}

active proctype Reader() {
  int temp;
  temp = shared;  // Read from shared variable
  printf("Reader: read shared = %d\n", temp);
}
