show int shared = 1;

active proctype Writer() {
  int temp = 10;  
  shared = temp; 
  printf("Writer: shared = %d\n", shared);
}

active proctype Reader() {
  int temp;
  temp = shared;  
  printf("Reader: read shared = %d\n", temp);
}
