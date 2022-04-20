.text
addi $sp, $zero, 2000

.text
START:

addi $s0,$zero,0
WAITING_LOOP:
beq  $s0,$zero,WAITING_LOOP 

addi $s0,$zero,0
addi   $v0,$0,1
syscall				#系统调用，将下一条指令中写入寄存器堆中的值替换为寄存器first_letter中的值
addi   $s1,$zero,0	#执行完该指令后$s1寄存器中的值为first_letter
addi   $v0,$0,2
syscall				#系统调用，将下一条指令中写入寄存器堆中的值替换为寄存器random_num中的值
addi   $s2,$zero,0	#执行完该指令后$s2寄存器中的值为random_num
sll  $s3,$s1,7     # $s3=$s1*32*4
sll $s4,$s2,2	# $s4=$s2*4
add  $s5,$s3,$s4
lw $s6,0($s5)
bne $s6,$zero,USED				
NOTUSED:
addi $s7,$zero,1
sw  $s7,0($s5)
addi   $v0,$0,3
syscall		#系统调用，输出信号“该单词未使用过”
j WAITING_LOOP 
USED:
addi   $v0,$0,4
syscall		#系统调用，输出信号“该单词已经使用过”
j WAITING_LOOP 


InteruptProgram1:
addi $s0,$zero,1	#中断服务
eret         #同步开中断，epc-->pc


InteruptProgram2:
sw $v0, 0($sp)          #保护现场
addi $sp, $sp, 4
sw $a0, 0($sp)
addi $sp, $sp, 4

addi   $a0,$0,1       #display $s0		#中断服务
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

addi $sp, $sp, -4		# 恢复现场
lw $a0, 0($sp)
addi $sp, $sp, -4
lw $v0, 0($sp)
addi $sp, $sp, -4
lw $v1, 0($sp)
eret         #同步开中断，epc-->pc

InteruptProgram3:
sw $v0, 0($sp)          #保护现场
addi $sp, $sp, 4
sw $a0, 0($sp)
addi $sp, $sp, 4

#中断服务

addi $sp, $sp, -4		# 恢复现场
lw $v1, 0($sp)
addi $sp, $sp, -4		
lw $a0, 0($sp)
addi $sp, $sp, -4
lw $v0, 0($sp)
eret         #同步开中断，epc-->pc
