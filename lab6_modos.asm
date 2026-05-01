
org 100h

jmp inicio

; --- SECCIÓN DE DATOS ---
array      dw 10, 20, 30, 40, 50      ; Array de 5 enteros (16 bits)
nota1      dw 85                      ; Campo 1 de struct
nota2      dw 73                      ; Campo 2 de struct
promedio   dw 0                       ; Campo para resultado
var_x      dw 0FFFFh                  ; Variable simple

inicio:
    ; --- MODO 1: INMEDIATO ---
    ; El valor está embebido en la instrucción[cite: 4]
    MOV AX, 100           ; Carga 100 decimal (64h) en AX
    MOV BX, 0A5h          ; Carga A5h en BX

    ; --- MODO 2: DIRECTO ---
    ; Se accede a la memoria usando una dirección fija[cite: 4]
    MOV AX, [var_x]       ; AX = FFFFh
    MOV CX, [nota1]       ; CX = 85 (55h)

    ; --- MODO 3: INDIRECTO POR REGISTRO ---
    ; El registro funciona como un puntero[cite: 4]
    MOV SI, nota1         ; SI apunta a la dirección de nota1
    MOV AX, [SI]          ; AX = 85
    MOV SI, nota2         ; SI apunta a la dirección de nota2
    MOV BX, [SI]          ; BX = 73
    
    ; Operación para calcular promedio (AX + BX) / 2
    ADD AX, BX            ; AX = 158
    SHR AX, 1             ; AX = 79 (División por 2)
    MOV SI, promedio
    MOV [SI], AX          ; Guarda el resultado usando el puntero SI[cite: 4]

    ; --- MODO 4: INDEXADO (Base + Índice) ---
    ; Recorrido del array para suma acumulada[cite: 4]
    XOR AX, AX            ; AX = 0 (Acumulador)
    MOV BX, array         ; BX = Dirección base del array
    MOV CX, 5             ; Contador para el bucle
    XOR SI, SI            ; SI = 0 (Índice inicial)

.bucle_suma:
    ADD AX, [BX + SI]     ; Suma el elemento actual usando Base + Índice[cite: 4]
    ADD SI, 2             ; Avanza al siguiente word (2 bytes)
    LOOP .bucle_suma      ; CX-- y salta si CX > 0

    INT 20h               ; Fin del programa para .COM[cite: 4]