; =============================================
; PROGRAMA: CALCULADORA COM VERIFICAÇÃO DE OVERFLOW
; AUTOR: Thales Vincius Pereira Simas
; DATA: 19/09/2025
; =============================================

ORG 0

JMP MAIN

; --- CONSTANTES E MENSAGENS ---
DB "CALCULADORA NEANDER", 0
DB "1-SOMA 2-SUBTRACAO", 0  
DB "NUMERO 1: ", 0
DB "NUMERO 2: ", 0
DB "RESULTADO: ", 0
DB "OVERFLOW!", 0
DB "SEM OVERFLOW", 0
DB "BIN: ", 0

; --- VARIÁVEIS ---
NUM1:       DS 1
NUM2:       DS 1
RESULT:     DS 1
OPERACAO:   DS 1
TEMP:       DS 1

; --- PROGRAMA PRINCIPAL ---
MAIN:
    LDA #10
    OUT 0       ; Limpa tela
    
    ; Exibe mensagem de boas-vindas
    LDA #2      ; Endereço da primeira mensagem
    STA 240
    LDA #0
    STA 241
    
    LDA #13
    OUT 0       ; Nova linha
    
    ; Exibe opções
    LDA #23     ; Endereço da segunda mensagem
    STA 240
    LDA #0
    STA 241
    
    LDA #13
    OUT 0
    
    ; Aguarda escolha da operação
    IN 1
    STA OPERACAO
    
    LDA #13
    OUT 0
    
    ; Solicita primeiro número
    LDA #42     ; Endereço da terceira mensagem
    STA 240
    LDA #0
    STA 241
    
    IN 1
    STA NUM1
    
    LDA #13
    OUT 0
    
    ; Solicita segundo número
    LDA #53     ; Endereço da quarta mensagem
    STA 240
    LDA #0
    STA 241
    
    IN 1
    STA NUM2
    
    LDA #13
    OUT 0
    
    ; Executa operação selecionada
    LDA OPERACAO
    SUB #1
    JZ SOMA
    SUB #1
    JZ SUBTRACAO
    JMP FIM

SOMA:
    LDA NUM1
    ADD NUM2
    STA RESULT
    
    ; Verifica overflow na soma
    JV OVERFLOW_SOMA
    JMP MOSTRA_RESULTADO

SUBTRACAO:
    LDA NUM1
    SUB NUM2
    STA RESULT
    
    ; Verifica overflow na subtração
    JV OVERFLOW_SUB
    JMP MOSTRA_RESULTADO

OVERFLOW_SOMA:
    LDA #64     ; Endereço da mensagem de overflow
    STA 240
    LDA #0
    STA 241
    JMP MOSTRA_RESULTADO

OVERFLOW_SUB:
    LDA #64     ; Endereço da mensagem de overflow
    STA 240
    LDA #0
    STA 241

MOSTRA_RESULTADO:
    LDA #13
    OUT 0
    
    ; Mostra mensagem de resultado
    LDA #74     ; Endereço da mensagem de resultado
    STA 240
    LDA #0
    STA 241
    
    ; Mostra resultado em decimal
    LDA RESULT
    OUT 2
    
    LDA #13
    OUT 0
    
    ; Mostra resultado em binário
    LDA #86     ; Endereço da mensagem bin
    STA 240
    LDA #0
    STA 241
    
    LDA RESULT
    OUT 3
    
FIM:
    HLT