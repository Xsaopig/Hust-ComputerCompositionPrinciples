.text
addi $sp, $zero, 2000

.text
START:

addi $s0,$zero,0
WAITING_LOOP:
beq  $s0,$zero,WAITING_LOOP 

addi $s0,$zero,0
addi   $v0,$0,1
syscall				#ϵͳ���ã�����һ��ָ����д��Ĵ������е�ֵ�滻Ϊ�Ĵ���first_letter�е�ֵ
addi   $s1,$zero,0	#ִ�����ָ���$s1�Ĵ����е�ֵΪfirst_letter
addi   $v0,$0,2
syscall				#ϵͳ���ã�����һ��ָ����д��Ĵ������е�ֵ�滻Ϊ�Ĵ���random_num�е�ֵ
addi   $s2,$zero,0	#ִ�����ָ���$s2�Ĵ����е�ֵΪrandom_num
sll  $s3,$s1,7     # $s3=$s1*32*4
sll $s4,$s2,2	# $s4=$s2*4
add  $s5,$s3,$s4
lw $s6,0($s5)
bne $s6,$zero,USED				
NOTUSED:
addi $s7,$zero,1
sw  $s7,0($s5)
addi   $v0,$0,3
syscall		#ϵͳ���ã�����źš��õ���δʹ�ù���
j WAITING_LOOP 
USED:
addi   $v0,$0,4
syscall		#ϵͳ���ã�����źš��õ����Ѿ�ʹ�ù���
j WAITING_LOOP 


InteruptProgram1:
addi $s0,$zero,1	#�жϷ���
eret         #ͬ�����жϣ�epc-->pc


InteruptProgram2:
sw $v0, 0($sp)          #�����ֳ�
addi $sp, $sp, 4
sw $a0, 0($sp)
addi $sp, $sp, 4

addi   $a0,$0,1       #display $s0		#�жϷ���
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

addi $sp, $sp, -4		# �ָ��ֳ�
lw $a0, 0($sp)
addi $sp, $sp, -4
lw $v0, 0($sp)
addi $sp, $sp, -4
lw $v1, 0($sp)
eret         #ͬ�����жϣ�epc-->pc

InteruptProgram3:
sw $v0, 0($sp)          #�����ֳ�
addi $sp, $sp, 4
sw $a0, 0($sp)
addi $sp, $sp, 4

#�жϷ���

addi $sp, $sp, -4		# �ָ��ֳ�
lw $v1, 0($sp)
addi $sp, $sp, -4		
lw $a0, 0($sp)
addi $sp, $sp, -4
lw $v0, 0($sp)
eret         #ͬ�����жϣ�epc-->pc
