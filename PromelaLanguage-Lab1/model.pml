mtype = {REQ, RES};

inline rand(num) {
    num = (_pid % 5) + 1; 
}

proctype Client(chan ch; byte reqCount) {
    byte reqbit, resbit;

    printf("CLIENT: running, pid=%d\n", _pid);

    do
    :: reqCount > 0 ->
        rand(reqbit);
        printf("CLIENT: sending REQ with value %d\n", reqbit);
        ch ! REQ, reqbit;
        printf("CLIENT: waiting for RES\n");
        ch ? RES, resbit;
        printf("CLIENT: RES received with value %d\n", resbit);
        reqCount = reqCount - 1;
        printf("CLIENT: REQ and RES process complete for value %d\n", reqbit);
    :: reqCount == 0 -> 
        printf("CLIENT: All requests processed. Client stops.\n");
        break;
    od
}

proctype Server(chan ch) {
    byte reqbyte, resbyte;

    printf("SERVER: running, pid=%d\n", _pid);

    do
    :: ch ? REQ, reqbyte ->
        printf("SERVER: REQ received with code %d\n", reqbyte);
        rand(resbyte);
        printf("SERVER: processing REQ, sending RES with value %d\n", resbyte);
        ch ! RES, resbyte;
        printf("SERVER: RES sent for request %d\n", reqbyte);
    od
}

init {
    chan ch = [2] of {mtype, byte};  // Channel with 2 slots for mtype and byte
    run Client(ch, 5);
    run Server(ch);
}
