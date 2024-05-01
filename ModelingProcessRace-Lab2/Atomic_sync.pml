show int shared = 1;

active proctype Writer() {
  int temp = 10;

  atomic {
    shared = temp;  
    printf("Writer: shared = %d\n", shared);
  }
}

active proctype Reader() {
  int temp;

  atomic {
    temp = shared;  
    printf("Reader: read shared = %d\n", temp);
  }
}
