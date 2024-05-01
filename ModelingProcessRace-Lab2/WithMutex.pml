#define P(s) atomic { s > 0 -> s-- }
#define V(s) s++

show int shared = 1;
show int semaphore = 1;  

active proctype Writer() {
  int temp = 10;

  P(semaphore);  // Wait operation on the semaphore
  shared = temp;  
  printf("Writer: shared = %d\n", shared);
  V(semaphore);  // Signal operation on the semaphore
}

active proctype Reader() {
  int temp;

  P(semaphore);  // Wait operation on the semaphore
  temp = shared;  // Read operation protected by semaphore
  printf("Reader: read shared = %d\n", temp);
  V(semaphore);  // Signal operation on the semaphore
}
