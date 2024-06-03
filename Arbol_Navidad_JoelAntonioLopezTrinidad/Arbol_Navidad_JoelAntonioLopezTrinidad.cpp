#include <stdio.h>

void imprimirEspacios(int n) {
    for (int i = 0; i < n; i++) {
        printf(" ");
    }
}

void imprimirCeros(int n) {
    for (int i = 0; i < n; i++) {
        printf("0");
    }
}

int main() {
    int filas = 10;

    imprimirEspacios(filas - 1);
    printf("*\n");

    for (int i = 0; i < filas; i++) {
        imprimirEspacios(filas - i - 1);
        imprimirCeros(2 * i + 1);
        printf("\n");
    }

    return 0;
}
