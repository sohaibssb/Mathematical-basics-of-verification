#define rand(num) \
{ \
    byte choices[5] = {1, 2, 3, 4, 5}; \
    num = choices[_pid % 5]; /* Use _pid for a simple pseudo-random effect based on process id */ \
}

mtype {REQ, RES, CONF};

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
        printf("CLIENT: RES received with value %d, sending CONF\n", resbit);
        ch ! CONF, resbit;
        reqCount = reqCount - 1;
        printf("CLIENT: CONF sent\n");
      :: reqCount == 0 -> 
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
        printf("SERVER: RES sent, waiting for CONF\n");
        ch ? CONF, resbyte;
        printf("SERVER: CONF received, corresponding to RES %d\n", resbyte);
    od
}

init {
    chan ch = [2] of { mtype, byte };
    run Client(ch, 5);
    run Server(ch);
}
