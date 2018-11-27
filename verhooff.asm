.386
.model flat, stdcall
option casemap : none
 convertir PROTO : DWORD, : DWORD
                         ;num
generateVerhoeff proto :dword, :dword
stringToReversedIntArray proto :dword, :dword
reverse proto :dword, :dword
.data
multiplicationTable db 0,1,2,3,4,5,6,7,8,9
                    db 1,2,3,4,0,6,7,8,9,5
                    db 2,3,4,0,1,7,8,9,5,6
                    db 3,4,0,1,2,8,9,5,6,7
                    db 4,0,1,2,3,9,5,6,7,8
                    db 5,9,8,7,6,0,4,3,2,1
                    db 6,5,9,8,7,1,0,4,3,2
                    db 7,6,5,9,8,2,1,0,4,3
                    db 8,7,6,5,9,3,2,1,0,4
                    db 9,8,7,6,5,4,3,2,1,0
permutationTable db 0,1,2,3,4,5,6,7,8,9
                 db 1,5,7,6,2,8,3,0,9,4
                 db 5,8,0,3,7,9,6,1,4,2
                 db 8,9,1,6,0,4,3,5,2,7
                 db 9,4,5,3,1,2,6,8,7,0
                 db 4,2,8,6,5,7,3,9,0,1
                 db 2,7,9,3,8,0,6,4,1,5
                 db 7,0,4,6,9,1,3,2,5,8
inverseTable db 0,4,3,2,1,5,6,7,8,9
 


  myArray db 0
  cad db '123',0
  longitud db 0
  res db 0

.code
start:
    ;write your code here
    xor eax, eax
    ;invoke generateVerhoeff
    
   
    invoke convertir, addr cad, addr myArray	
     mov ebx,offset myArray
     xor eax,eax
     mov ah,byte ptr [ebx]
    ret
     




convertir PROC uses esi ebx ecx edx cadena: DWORD, resul:DWORD
    mov ebx, cadena
    mov esi, 0
    mov edi, 0
   ; mov ecx, resul
    xor edx,edx
    xor eax,eax
mov ch, byte ptr[ebx+esi]
mov ah,ch
xor ecx,ecx
 contar:    
    mov ch, byte ptr[ebx+esi]
    cmp ch, 0
    je volteo1
    inc esi
    jmp contar
volteo1:
    xor ecx,ecx
    mov ecx, resul
    jmp volteo2
volteo2:
    cmp esi,-1
    je intermedio
    mov al, byte ptr[ebx+esi]
    mov byte ptr [ecx+edi], al
    inc edi
    dec esi
    jmp volteo2 
    
    
intermedio:
    dec edi
    mov byte ptr [ecx+edi], ah
    xor eax,eax
    mov esi,0
    mov eax, ebx
    mov ebx, ecx
    mov ecx, eax
    xor eax,eax
    jmp aNum   ;esta en ecx la cosa es devolverlo y luego subirlo al metodo de niki de convertir 
                ;y lo convertirmos y somos felices
aNum:
    mov ch, byte ptr[ebx+esi]
    cmp esi, edi
    je salir
    sub al, 48
    mov dl, 10
    add al, bh
    mul dl 
    inc esi
    jmp aNum
    
salir:
    mov bl, al
    mov cl,bl
    div dl
    mov ebx, resul
    mov dword ptr[ebx], eax
    ret
 
    convertir endp 


stringToReversedIntArray PROC uses esi ebx ecx stringNum: dword, result: dword
   
    invoke convertir, stringNum,addr myArray
    mov dl,0
   invoke reverse, addr myArray, addr res
   
   
    
    
    ret    
stringToReversedIntArray endp

reverse PROC uses esi eax ebx ecx edx edi cadenaNumero: dword, reverseVec: dword
    mov ebx,cadenaNumero
    mov eax, 0

    mov esi, 0
    mov edi,0
    xor ecx, ecx
    mov cl, byte ptr[ebx+esi]
sig: 
    mov ch,byte ptr[ebx+esi]
    push ebx
    inc esi
    cmp ch,0
    jne sig
    cmp ch,0
    je desapila
    
desapila:
    mov ch,byte ptr[ebx+esi]
    pop eax
    inc edi
    cmp edi,esi
    jne desapila
    
   mov ebx, reverseVec
   mov dword ptr[ebx], eax

    ret
reverse endp
    ret
    end start
    
