	.file	"batt_update.c"
	.text
	.section .rdata,"dr"
LC0:
	.ascii "Sensor error\0"
	.text
	.globl	_set_batt_from_ports
	.def	_set_batt_from_ports;	.scl	2;	.type	32;	.endef
_set_batt_from_ports:
	push    %rbp # arg batt
    mov     %rsp, %rbp # puts batt in stack pointer
    sub     $32, %rsp # makes room in stack
    movq    %rdi, -24(%rbp) 
    movzx   _BATT_VOLTAGE_PORT, %eax
    test    %ax, %ax # if (BATT_VOLTAGE_PORT < 0)
    jns     .GRTR # if not go to next if
    mov     OFFSET FLAT:.LC0, %edi # set up for string return
    call    puts # prints string
    mov     $1, %eax # sets 1 for return 
    jmp     .RETURN
.GRTR:
    movzx   _BATT_VOLTAGE_PORT, %edx # sets up for 
    movq    -24(%rbp), %rax # comparison 
    movzx   %dx, (%rax)
    movzx   _BATT_VOLTAGE_PORT, %eax
    cmp     $3799, %ax # if(BATT_VOLTAGE_PORT >= 3800)
    jle     .L1 # if less than 3800 continue
    mov     -23(%rbp), %rax
    mov     $100, 2(%rax) # sets batt.percent to 100
    movzx   _BATT_VOLTAGE_PORT, %eax # puts it into register
    mov     %eax, %edx 
    mov     -24(%rbp), %rax # sets batt mode from status port
    mov     %dl, 3(%rax)
    mov     $0, %eax # sets return for 0
    jmp     .RETURN
.L1:
	movzx   _BATT_VOLTAGE_PORT, %eax # prct = BATT_VOLTAGE_PORT
    cwde # prepares for subtraction 
    sub     $3000, %eax # subs 3000 from prct
    movl    %eax, -4(%rbp) # moves prct into stack
    movl    $8, -12(%rbp) # int div = 8;
    mov     $0, -8(%rbp) # int bp = 0;
    jmp     .L2 # start of while loop
.L3:
	subl     $8, -4(%rbp) # prct = prct - 8;
    addl     $1, -8(%rbp) # bp++;
.L2:
	movl    -4(%rbp), %eax  # puts prct into eax
    cmpl    -12(%rbp), %eax # compares prct and div
    jge     .L3 # jumps to loop
    movl    -8(%rbp), %eax # moving eax to bp
    movl    %eax, %edx # sets up stuff
    movq    -23(%rbp), %rax # puts bp into batt.percent
    mov     %dl, 2(%rax)
    movzx   _BATT_STATUS_PORT, %eax # moves batt status port into reg
    movl    %eax, %edx 
    movq    -24(%rbp), %rax # sets batt status port into batt.mode
    mov     %dl, 3(%rax) # clean up
    mov     $0, %eax # sets to return 0
.RETURN:
	ret	

.LFE20:
	.section .rdata,"dr"
.LC1:
	.ascii "Error in battery\0"
	.text
	.globl	_set_display_from_batt
	.def	_set_display_from_batt;	.scl	2;	.type	32;	.endef
_set_display_from_batt:
.LD1:
	push    %rbp # push args 
    movl     %rsp, %rbp # moves into stack
    subl     $144, %rsp # makes room in stack
    movl    %edi, -132(%rbp) # set batt
    movq    %rsi, -144(%rbp) # set display
    movzx   -129(%rbp) ,%eax
    test    al, al # if(batt.mode != 0
    jne     .LD2 # jump to error
    movzx   -129(%rbp), %eax 
    cmp     $1, %al # if(batt.mode != 1)
    je      .LD3 # if equal jump
.LD2:
    movl     OFFSET FLAT:.LC1, %edi  # gets string
    call    puts # prints
    movl     $1, %eax # set to return 1
    jmp     .RETURN2
.LD3:
 # int mask[10] = {0b0111111, 0b0000110, 0b1011011, 0b1001111,
	movl	$63, -96(%ebp)	 
	movl	$6, -92(%ebp)	 
	movl	$91, -88(%ebp)	 
	movl	$79, -84(%ebp)	 
	movl	$102, -80(%ebp)	 
	movl	$109, -76(%ebp)	 
	movl	$125, -72(%ebp)	 
	movl	$7, -68(%ebp)	 
	movl	$127, -64(%ebp)	 
	movl	$111, -60(%ebp)	 
 # int prcnt = 0b10;
	movl	$2, -24(%ebp)	
 # int vlt = 0b01;
	movl	$1, -28(%ebp)	 
 # int lvl[5] = {0b00000, 0b10000, 0b11000, 0b11100, 0b11110, 0b11111};
	movl	$0, -116(%ebp)	 
	movl	$16, -112(%ebp)	 
	movl	$24, -108(%ebp)	 
	movl	$28, -104(%ebp)	 
	movl	$30, -100(%ebp)	 
 # int blank = 0b0000000;
	movl	$0, -32(%ebp)	 
 # int state = 0;
	movl	$0, -12(%ebp)	 
 # int i = 0;
	movl	$0, -16(%ebp)	 
 # int temp = batt.percent;
	movzbl	10(%ebp), %eax	 
 # int temp = batt.percent;
	movsbl	%al, %eax	
	movl	%eax, -20(%ebp)	 
 # while(temp>5){
	jmp	.LD4	 #
.LD5:
 # state = state|lvl[i]<<24;
	movl	-16(%ebp), %eax	 # i
	movl	-116(%ebp,%eax,4), %eax	 # lvl[i]
 # state = state|lvl[i]<<24;
	sall	$24, %eax	 
 # state = state|lvl[i]<<24;
	orl	%eax, -12(%ebp)	 
 # temp = temp - 20;
	subl	$20, -20(%ebp)	 
 # i++;
	addl	$1, -16(%ebp)	 
.LD4:
 # while(temp>5){
	cmpl	$5, -20(%ebp)	 
	jg	.LD5	 
 # int temp_hndr = mask[(batt.volts / 10) % 10];
	movzwl	8(%ebp), %eax	 
 # int temp_hndr = mask[(batt.volts / 10) % 10];
 # lots of arithmetic using temps 
	movswl	%ax, %edx	 # _6, tmp121
	imull	$26215, %edx, %edx	 # tmp121, tmp122
	shrl	$16, %edx	 # tmp123
	sarw	$2, %dx	 # tmp124
	sarw	$15, %ax	 # tmp125
	movl	%edx, %ecx	 # tmp124, tmp124
	subl	%eax, %ecx	 # tmp125, tmp124
	movswl	%cx, %eax	 # _7, tmp126
	imull	$26215, %eax, %eax	 # tmp126, tmp127
	shrl	$16, %eax	 # tmp128
	movl	%eax, %edx	 # tmp128, tmp129
	sarw	$2, %dx	 # tmp129
	movl	%ecx, %eax	 # _7 tmp130
	sarw	$15, %ax	 # tmp130
	subl	%eax, %edx	 # tmp130, _8
	movl	%edx, %eax	 # _8, tmp131
	sall	$2, %eax	 # tmp131
	addl	%edx, %eax	 # _8 tmp131
	addl	%eax, %eax	 # tmp132
	subl	%eax, %ecx	 # tmp131, _7
	movl	%ecx, %edx	 # _7 _8
	movswl	%dx, %eax	 # _8 _9
 # int temp_hndr = mask[(batt.volts / 10) % 10];
	movl	-96(%ebp,%eax,4), %eax	 
	movl	%eax, -36(%ebp)	 
 # int temp_tnths = mask[(batt.volts / 100) % 10];
	movzwl	8(%ebp), %eax	
 # int temp_tnths = mask[(batt.volts / 100) % 10];
 # more arithmetic using temp values
	movswl	%ax, %edx	 # _10, tmp134
	imull	$5243, %edx, %edx	 # tmp134, tmp135
	shrl	$16, %edx	 # tmp136
	sarw	$3, %dx	 # tmp137
	sarw	$15, %ax	 # tmp138
	movl	%edx, %ecx	 # tmp137, tmp137
	subl	%eax, %ecx	 # tmp138, tmp137
	movswl	%cx, %eax	 # _11, tmp139
	imull	$26215, %eax, %eax	 # tmp139, tmp140
	shrl	$16, %eax	 # tmp141
	movl	%eax, %edx	 # tmp141, tmp142
	sarw	$2, %dx	 # tmp142
	movl	%ecx, %eax	 # _11, tmp143
	sarw	$15, %ax	 # tmp143
	subl	%eax, %edx	 # tmp143, _12
	movl	%edx, %eax	 # _12, tmp144
	sall	$2, %eax	 # tmp144
	addl	%edx, %eax	 # _12, tmp144
	addl	%eax, %eax	 # tmp145
	subl	%eax, %ecx	 # tmp144, _11
	movl	%ecx, %edx	 # _11, _12
	movswl	%dx, %eax	 # _12, _13
 # int temp_tnths = mask[(batt.volts / 100) % 10];
	movl	-96(%ebp,%eax,4), %eax	 
	movl	%eax, -40(%ebp)	 
 # int temp_ones = mask[(batt.volts / 1000) % 10];
	movzwl	8(%ebp), %eax	 
 # int temp_ones = mask[(batt.volts / 1000) % 10];
 # even more arithmetic using temp values
	movswl	%ax, %edx	 # _14, tmp147
	imull	$-31981, %edx, %edx	 # tmp147, tmp148
	shrl	$16, %edx	 # tmp149
	addl	%eax, %edx	 # _14, tmp150
	sarw	$9, %dx	 # tmp151
	sarw	$15, %ax	 # tmp152
	movl	%edx, %ecx	 # tmp151, tmp151
	subl	%eax, %ecx	 # tmp152, tmp151
	movswl	%cx, %eax	 # _15, tmp153
	imull	$26215, %eax, %eax	 # tmp153, tmp154
	shrl	$16, %eax	 # tmp155
	movl	%eax, %edx	 # tmp155, tmp156
	sarw	$2, %dx	 # tmp156
	movl	%ecx, %eax	 # _15, tmp157
	sarw	$15, %ax	 # tmp157
	subl	%eax, %edx	 # tmp157, _16
	movl	%edx, %eax	 # _16, tmp158
	sall	$2, %eax	 # tmp158
	addl	%edx, %eax	 # _16, tmp158
	addl	%eax, %eax	 # tmp159
	subl	%eax, %ecx	 # tmp158, _15
	movl	%ecx, %edx	 # _15, _16
	movswl	%dx, %eax	 # _16, _17
 # int temp_ones = mask[(batt.volts / 1000) % 10];
	movl	-96(%ebp,%eax,4), %eax	 
	movl	%eax, -44(%ebp)	 
 # int prcnt_hndr = mask[(batt.percent / 100) % 10];
	movzbl	10(%ebp), %ecx	 
 # int prcnt_hndr = mask[(batt.percent / 100) % 10];
 # percent arithmetic using temp values
	movsbw	%cl, %dx	 # _18, tmp161
	movl	%edx, %eax	 # tmp161, tmp162
	sall	$2, %eax	 # tmp162
	addl	%edx, %eax	 # tmp161, tmp162
	sall	$3, %eax	 # tmp162
	addl	%edx, %eax	 # tmp161, tmp162
	shrw	$8, %ax	 # tmp163
	movl	%eax, %edx	 # tmp163, tmp164
	sarb	$4, %dl	 # tmp164
	movl	%ecx, %eax	 # _18, _18
	sarb	$7, %al	 # _18
	movl	%edx, %ecx	 # tmp164, tmp164
	subl	%eax, %ecx	 # tmp165, tmp164
	movsbw	%cl, %ax	 # _19, tmp166
	imull	$103, %eax, %eax	 # tmp166, tmp167
	shrw	$8, %ax	 # tmp168
	movl	%eax, %edx	 # tmp168, tmp169
	sarb	$2, %dl	 # tmp169
	movl	%ecx, %eax	 # _19, tmp170
	sarb	$7, %al	 # tmp170
	subl	%eax, %edx	 # tmp170, _20
	movl	%edx, %eax	 # _20, tmp171
	sall	$2, %eax	 # tmp171
	addl	%edx, %eax	 # _20, tmp171
	addl	%eax, %eax	 # tmp172
	subl	%eax, %ecx	 # tmp171, _19
	movl	%ecx, %edx	 # _19, _20
	movsbl	%dl, %eax	 # _20, _21
 # int prcnt_hndr = mask[(batt.percent / 100) % 10];
	movl	-96(%ebp,%eax,4), %eax	 
	movl	%eax, -48(%ebp)	 # 
 # int prcnt_ten = mask[(batt.percent / 10) % 10];
	movzbl	10(%ebp), %eax	 
 # int prcnt_ten = mask[(batt.percent / 10) % 10];
 # nothing new
	movsbw	%al, %dx	 # _22, tmp174
	imull	$103, %edx, %edx	 # tmp174, tmp175
	shrw	$8, %dx	 # tmp176
	sarb	$2, %dl	 # tmp177
	sarb	$7, %al	 # tmp178
	movl	%edx, %ecx	 # tmp177, tmp177
	subl	%eax, %ecx	 # tmp178, tmp177
	movsbw	%cl, %ax	 # _23, tmp179
	imull	$103, %eax, %eax	 # tmp179, tmp180
	shrw	$8, %ax	 # tmp181
	movl	%eax, %edx	 # tmp181, tmp182
	sarb	$2, %dl	 # tmp182
	movl	%ecx, %eax	 # _23, tmp183
	sarb	$7, %al	 # tmp183
	subl	%eax, %edx	 # tmp183, _24
	movl	%edx, %eax	 # _24, tmp184
	sall	$2, %eax	 # tmp184
	addl	%edx, %eax	 # _24, tmp184
	addl	%eax, %eax	 # tmp185
	subl	%eax, %ecx	 # tmp184, _23
	movl	%ecx, %edx	 # _23, _24
	movsbl	%dl, %eax	 # _24, _25
 # int prcnt_ten = mask[(batt.percent / 10) % 10];
	movl	-96(%ebp,%eax,4), %eax	
	movl	%eax, -52(%ebp)	 
 # int prct_one = mask[batt.percent % 10];
	movzbl	10(%ebp), %ecx	 
 # int prct_one = mask[batt.percent % 10];
 # Almost done
	movsbw	%cl, %ax	 # _26, tmp187
	imull	$103, %eax, %eax	 # tmp187, tmp188
	shrw	$8, %ax	 # tmp189
	movl	%eax, %edx	 # tmp189, tmp190
	sarb	$2, %dl	 # tmp190
	movl	%ecx, %eax	 # _26, tmp191
	sarb	$7, %al	 # tmp191
	subl	%eax, %edx	 # tmp191, _27
	movl	%edx, %eax	 # _27, tmp192
	sall	$2, %eax	 # tmp192
	addl	%edx, %eax	 # _27, tmp192
	addl	%eax, %eax	 # tmp193
	subl	%eax, %ecx	 # tmp192, _26
	movl	%ecx, %edx	 # _26, _27
	movsbl	%dl, %eax	 # _27, _28
 # int prct_one = mask[batt.percent % 10];
	movl	-96(%ebp,%eax,4), %eax	 
	movl	%eax, -56(%ebp)	 
 # if(batt.mode){
	movzbl	11(%ebp), %eax	 
 # if(batt.mode){
	testb	%al, %al	 
	je	L13	 #,
 # state = state|prcnt<<22;
	movl	-24(%ebp), %eax	 
	sall	$22, %eax	 #, _30
 # state = state|prcnt<<22;
	orl	%eax, -12(%ebp)	 
.LD6:
	# wasn't able to finish this part.
	# really needed to turn it in
.RETURN2:
	ret	