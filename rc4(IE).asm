.386
.model flat, stdcall
option casemap : none
;-------------------------------PROTOTIPOS---------------------------------------
                     ; array  pos1   pos2
intercambiaElementos proto :dword, :dword, :dword
         ;vectorS  vectorT  vector R
rc4 proto :dword,   :dword, :dword
;              valor     palabra   
getInPos proto :dword, :dword, :dword

.data

VectorS db 0,1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
        db 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
        db 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47
        db 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63
        db 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79
        db 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95
        db 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111
        db 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127
        db 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143
        db 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159
        db 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175
        db 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191
        db 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207
        db 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223
        db 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239
        db 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255
        
VectorT db "SeSaMo",0
VectorR db 0 
.code
start:
    xor eax, eax
    xor ebx, ebx
    xor edx, edx
    xor ecx, ecx
    
    
    invoke rc4, addr VectorS, addr VectorT, addr VectorR
    ;invoke intercambiaElementos, addr VectorP, ecx, edx
 
    ret
    
    intercambiaElementos proc uses ebx ecx edx esi edi vec:dword, pos1:dword, pos2:dword
    
    mov ebx, vec
    mov edx, vec
    mov esi, pos1
    mov ecx, pos2
    
    add ebx, pos1
    add edx, pos2
    
    xor ecx, ecx
    
    mov al, [ebx]
    mov cl,[edx]
    mov [ebx], cl
    mov [edx], al
    
    ret
    intercambiaElementos endp 
    
   rc4  proc uses ebx ecx edx esi edi vecS:dword,  vecT:dword, vecR:dword
   
   mov ebx,vecS
   mov ecx,vecT
   mov edi, 0 ;edi sera j para el primer cifrado
   mov esi, 0 ; esi sera i para el primer cifrado
   
   cif1:
   
   mov al, [ebx]
   inc ebx
   add edi, eax
   mov al, [ecx] 
   inc ecx
   add edi, eax 
   invoke intercambiaElementos, addr VectorS, esi, edi  
   inc esi
   cmp esi,255
   jne cif1
   
   ret
   rc4 endp
    
end start
;RUTINA PRIMER CIFRADO
;Desde 0 hasta 255
    ;j = (j +VectorS[i] + VectorT[i])mod 256
    ;swap S[i] y S[j]
;----------------RUTINA CIFRADO FINAL---------------
; i j  k =0
;Mientras k < a la longitud de clave
; i=(i+1) mod 256
; j=(j+S[i])mod 256
;swap S[i], S[j]
;t =(S[i]+S[j]) mod 256
;EXPONER VALOR DE S[T]//
;k++


    