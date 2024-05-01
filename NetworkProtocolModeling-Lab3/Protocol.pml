mtype = { SYN, SYN_ACK, ACK, DATA, FIN };

// Channels for communication
chan clientToServer = [2] of { mtype, byte };
chan serverToClient = [2] of { mtype, byte };

proctype Client() {
    clientToServer ! SYN, 0;     // Send SYN to server
    serverToClient ? SYN_ACK, _; // Wait for SYN-ACK from server
    clientToServer ! ACK, 0;     // Send ACK to server

    // Data transmission
    serverToClient ? DATA, _;    // Receive data
    printf("Client received data\n");

    // Connection termination
    clientToServer ! FIN, 0;     // Send FIN to close connection
}

proctype Server() {
    clientToServer ? SYN, _;     // Wait for SYN
    serverToClient ! SYN_ACK, 0; // Send SYN-ACK
    clientToServer ? ACK, _;     // Wait for ACK

    // Data transmission
    serverToClient ! DATA, 0;    // Send data
    printf("Server sent data\n");

    // Connection termination
    clientToServer ? FIN, _;     // Wait for FIN to close connection
}

init {
    run Client();
    run Server();
}
