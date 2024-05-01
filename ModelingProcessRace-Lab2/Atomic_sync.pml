show int shared = 1;

active proctype Writer() {
  int temp = 10;

  atomic {
    shared = temp;  // Atomic write operation
    printf("Writer: shared = %d\n", shared);
  }
}

active proctype Reader() {
  int temp;

  atomic {
    temp = shared;  // Atomic read operation
    printf("Reader: read shared = %d\n", temp);
  }
}
