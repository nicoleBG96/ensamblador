.386
.model flat, stdcall
option casemap : none
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;PROTOTIPOS

;                array,  tam,    pos
getInPos proto :dword, :dword, :dword
;            valor   palabra   
base64 proto :dword, :dword


.data
diccionario db "0123456789"
            db "ABCDEFGHIJ"
            db "KLMNOPQRST"
            db "UVWXYZabcd"
            db "efghijklmn"
            db "opqrstuvwx"
            db "yz+/"
base dw 64
palabra db 0
posi db 6
valor dd 1056575376


.code
start:
    ;write your code here
    xor eax, eax
    xor ebx, ebx
    xor edx, edx
    xor ecx, ecx
    
    invoke base64,  valor, addr palabra
     ret
  
    ;devolver en eax , el valor del arreglo en pos
    getInPos proc uses ebx esi ecx arreglo:dword, tam:dword, pos:dword
    
    mov ebx, arreglo
    mov ecx, pos
    xor esi, esi
    
    add ebx, ecx
    mov al, [ebx]
 
    
    ret
    getInPos endp
   
    
    ;algortimo base 64
    base64 proc uses ebx ecx edx esi edi val:dword, pal:dword
    
    mov eax, val
    mov ebx, pal
    xor edi, edi
    xor ecx, ecx
    
    
    
    sig:
    div base; eax representa res
    mov edi, eax
    ; residuo se encuentra en edx
    invoke getInPos, addr diccionario  ,addr base , edx
    xor edx, edx
    mov [ebx], al
    inc ebx
    mov eax, edi  
    cmp  eax,0
    jg sig
    
    ret
    base64 endp
   
    
    
;def base64(valor)
; res = 1
;mientras res>0
; res = valor/64
;residuo= valor %64
; palabra = diccionario[residuo]+ palabra
; valor = res
; retorno palabra
    
    

end start
    
 
