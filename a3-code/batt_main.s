	.file	"batt_main.c"
 # GNU C17 (MinGW.org GCC-8.2.0-5) version 8.2.0 (mingw32)
 #	compiled by GNU C version 8.2.0, GMP version 6.1.2, MPFR version 3.1.5, MPC version 1.0.3, isl version isl-0.18-GMP

 # GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
 # options passed:  -iprefix c:\mingw\bin\../lib/gcc/mingw32/8.2.0/
 # batt_main.c -mtune=generic -march=i586 -fverbose-asm
 # options enabled:  -faggressive-loop-optimizations
 # -fasynchronous-unwind-tables -fauto-inc-dec -fchkp-check-incomplete-type
 # -fchkp-check-read -fchkp-check-write -fchkp-instrument-calls
 # -fchkp-narrow-bounds -fchkp-optimize -fchkp-store-bounds
 # -fchkp-use-static-bounds -fchkp-use-static-const-bounds
 # -fchkp-use-wrappers -fcommon -fdelete-null-pointer-checks
 # -fdwarf2-cfi-asm -fearly-inlining -feliminate-unused-debug-types
 # -ffp-int-builtin-inexact -ffunction-cse -fgcse-lm -fgnu-runtime
 # -fgnu-unique -fident -finline-atomics -fira-hoist-pressure
 # -fira-share-save-slots -fira-share-spill-slots -fivopts
 # -fkeep-inline-dllexport -fkeep-static-consts -fleading-underscore
 # -flifetime-dse -flto-odr-type-merging -fmath-errno -fmerge-debug-strings
 # -fpeephole -fplt -fprefetch-loop-arrays -freg-struct-return
 # -fsched-critical-path-heuristic -fsched-dep-count-heuristic
 # -fsched-group-heuristic -fsched-interblock -fsched-last-insn-heuristic
 # -fsched-rank-heuristic -fsched-spec -fsched-spec-insn-heuristic
 # -fsched-stalled-insns-dep -fschedule-fusion -fsemantic-interposition
 # -fset-stack-executable -fshow-column -fshrink-wrap-separate
 # -fsigned-zeros -fsplit-ivs-in-unroller -fssa-backprop -fstdarg-opt
 # -fstrict-volatile-bitfields -fsync-libcalls -ftrapping-math
 # -ftree-cselim -ftree-forwprop -ftree-loop-if-convert -ftree-loop-im
 # -ftree-loop-ivcanon -ftree-loop-optimize -ftree-parallelize-loops=
 # -ftree-phiprop -ftree-reassoc -ftree-scev-cprop -funit-at-a-time
 # -funwind-tables -fverbose-asm -fzero-initialized-in-bss -m32 -m80387
 # -m96bit-long-double -maccumulate-outgoing-args -malign-double
 # -malign-stringops -mavx256-split-unaligned-load
 # -mavx256-split-unaligned-store -mfancy-math-387 -mfp-ret-in-387
 # -mieee-fp -mlong-double-80 -mms-bitfields -mno-red-zone -mno-sse4
 # -mpush-args -msahf -mstack-arg-probe -mstv -mvzeroupper

	.text
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 4
LC0:
	.ascii "usage: %s {voltage_val} {V | P}\12\0"
	.align 4
LC1:
	.ascii "  arg1 voltage_val: integer, units of 0.001 volts \0"
	.align 4
LC2:
	.ascii "  arg2 V or P: Voltage or Percent display\0"
LC3:
	.ascii "BATT_VOLTAGE_PORT set to: %u\12\0"
LC4:
	.ascii "Unknown display mode: '%s'\12\0"
LC5:
	.ascii "Should be 'V' or 'P'\0"
LC6:
	.ascii "set_batt_from_ports(&batt );\0"
LC7:
	.ascii "batt is {\0"
LC8:
	.ascii "  .volts   = %d\12\0"
LC9:
	.ascii "  .percent = %d\12\0"
LC10:
	.ascii "  .mode    = %d\12\0"
LC11:
	.ascii "}\0"
	.align 4
LC12:
	.ascii "set_batt_from_ports() returned non-zero: %d\12\0"
	.align 4
LC13:
	.ascii "\12Checking results for display bits\0"
	.align 4
LC14:
	.ascii "set_display_from_batt(batt, &display);\0"
LC15:
	.ascii "\12display is:\0"
	.align 4
LC16:
	.ascii "        3         2         1         0\0"
	.align 4
LC17:
	.ascii "index: 10987654321098765432109876543210\0"
LC18:
	.ascii "bits:  \0"
	.align 4
LC19:
	.ascii "guide:  |    |    |    |    |    |    |\0"
	.align 4
LC20:
	.ascii "index:  30        20        10        0\0"
	.align 4
LC21:
	.ascii "set_display_from_batt() returned non-zero: %d\12\0"
LC22:
	.ascii "\12Running batt_update()\0"
LC23:
	.ascii "\12BATT_DISPLAY_PORT is:\0"
	.align 4
LC24:
	.ascii "index:  3         2         1    0    0\0"
LC25:
	.ascii "\12Battery Meter Display:\0"
	.text
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB20:
	.cfi_startproc
	pushl	%ebp	 #
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp	 #,
	.cfi_def_cfa_register 5
	andl	$-16, %esp	 #,
	subl	$32, %esp	 #,
 # batt_main.c:16: int main(int argc, char **argv){
	call	___main	 #
 # batt_main.c:18:   if(argc < 3){                 
	cmpl	$2, 8(%ebp)	 #, argc
	jg	L2	 #,
 # batt_main.c:19:     printf("usage: %s {voltage_val} {V | P}\n",argv[0]);
	movl	12(%ebp), %eax	 # argv, tmp121
	movl	(%eax), %eax	 # *argv_38(D), _1
	movl	%eax, 4(%esp)	 # _1,
	movl	$LC0, (%esp)	 #,
	call	_printf	 #
 # batt_main.c:20:     printf("  arg1 voltage_val: integer, units of 0.001 volts \n");
	movl	$LC1, (%esp)	 #,
	call	_puts	 #
 # batt_main.c:21:     printf("  arg2 V or P: Voltage or Percent display\n");
	movl	$LC2, (%esp)	 #,
	call	_puts	 #
 # batt_main.c:22:     return 0;
	movl	$0, %eax	 #, _33
	jmp	L11	 #
L2:
 # batt_main.c:24:   BATT_VOLTAGE_PORT = atoi(argv[1]);
	movl	12(%ebp), %eax	 # argv, tmp122
	addl	$4, %eax	 #, _2
 # batt_main.c:24:   BATT_VOLTAGE_PORT = atoi(argv[1]);
	movl	(%eax), %eax	 # *_2, _3
	movl	%eax, (%esp)	 # _3,
	call	_atoi	 #
 # batt_main.c:24:   BATT_VOLTAGE_PORT = atoi(argv[1]);
	movw	%ax, _BATT_VOLTAGE_PORT	 # _5, BATT_VOLTAGE_PORT
 # batt_main.c:25:   printf("BATT_VOLTAGE_PORT set to: %u\n", BATT_VOLTAGE_PORT);
	movzwl	_BATT_VOLTAGE_PORT, %eax	 # BATT_VOLTAGE_PORT, BATT_VOLTAGE_PORT.0_6
	cwtl
	movl	%eax, 4(%esp)	 # _7,
	movl	$LC3, (%esp)	 #,
	call	_printf	 #
 # batt_main.c:33:   if(argv[2][0]=='V' || argv[2][0]=='v'){
	movl	12(%ebp), %eax	 # argv, tmp123
	addl	$8, %eax	 #, _8
	movl	(%eax), %eax	 # *_8, _9
 # batt_main.c:33:   if(argv[2][0]=='V' || argv[2][0]=='v'){
	movzbl	(%eax), %eax	 # *_9, _10
 # batt_main.c:33:   if(argv[2][0]=='V' || argv[2][0]=='v'){
	cmpb	$86, %al	 #, _10
	je	L4	 #,
 # batt_main.c:33:   if(argv[2][0]=='V' || argv[2][0]=='v'){
	movl	12(%ebp), %eax	 # argv, tmp124
	addl	$8, %eax	 #, _11
	movl	(%eax), %eax	 # *_11, _12
 # batt_main.c:33:   if(argv[2][0]=='V' || argv[2][0]=='v'){
	movzbl	(%eax), %eax	 # *_12, _13
 # batt_main.c:33:   if(argv[2][0]=='V' || argv[2][0]=='v'){
	cmpb	$118, %al	 #, _13
	jne	L5	 #,
L4:
 # batt_main.c:34:     BATT_STATUS_PORT |= VOLTAGE_FLAG;
	movzbl	_BATT_STATUS_PORT, %eax	 # BATT_STATUS_PORT, BATT_STATUS_PORT.1_14
	movb	%al, _BATT_STATUS_PORT	 # BATT_STATUS_PORT.1_14, BATT_STATUS_PORT
	jmp	L6	 #
L5:
 # batt_main.c:36:   else if(argv[2][0]=='P' || argv[2][0]=='p'){
	movl	12(%ebp), %eax	 # argv, tmp125
	addl	$8, %eax	 #, _15
	movl	(%eax), %eax	 # *_15, _16
 # batt_main.c:36:   else if(argv[2][0]=='P' || argv[2][0]=='p'){
	movzbl	(%eax), %eax	 # *_16, _17
 # batt_main.c:36:   else if(argv[2][0]=='P' || argv[2][0]=='p'){
	cmpb	$80, %al	 #, _17
	je	L7	 #,
 # batt_main.c:36:   else if(argv[2][0]=='P' || argv[2][0]=='p'){
	movl	12(%ebp), %eax	 # argv, tmp126
	addl	$8, %eax	 #, _18
	movl	(%eax), %eax	 # *_18, _19
 # batt_main.c:36:   else if(argv[2][0]=='P' || argv[2][0]=='p'){
	movzbl	(%eax), %eax	 # *_19, _20
 # batt_main.c:36:   else if(argv[2][0]=='P' || argv[2][0]=='p'){
	cmpb	$112, %al	 #, _20
	jne	L8	 #,
L7:
 # batt_main.c:37:     BATT_STATUS_PORT |= PERCENT_FLAG;
	movzbl	_BATT_STATUS_PORT, %eax	 # BATT_STATUS_PORT, BATT_STATUS_PORT.2_21
	orl	$1, %eax	 #, _22
	movb	%al, _BATT_STATUS_PORT	 # _22, BATT_STATUS_PORT
	jmp	L6	 #
L8:
 # batt_main.c:40:     printf("Unknown display mode: '%s'\n",argv[2]);
	movl	12(%ebp), %eax	 # argv, tmp127
	addl	$8, %eax	 #, _23
 # batt_main.c:40:     printf("Unknown display mode: '%s'\n",argv[2]);
	movl	(%eax), %eax	 # *_23, _24
	movl	%eax, 4(%esp)	 # _24,
	movl	$LC4, (%esp)	 #,
	call	_printf	 #
 # batt_main.c:41:     printf("Should be 'V' or 'P'\n");
	movl	$LC5, (%esp)	 #,
	call	_puts	 #
 # batt_main.c:42:     return 1;
	movl	$1, %eax	 #, _33
	jmp	L11	 #
L6:
 # batt_main.c:45:   batt_t batt = {.volts=-100, .percent=-1, .mode=-1};
	movw	$-100, 24(%esp)	 #, batt.volts
	movb	$-1, 26(%esp)	 #, batt.percent
	movb	$-1, 27(%esp)	 #, batt.mode
 # batt_main.c:46:   int result = set_batt_from_ports(&batt);
	leal	24(%esp), %eax	 #, tmp128
	movl	%eax, (%esp)	 # tmp128,
	call	_set_batt_from_ports	 #
	movl	%eax, 28(%esp)	 # tmp129, result
 # batt_main.c:47:   printf("set_batt_from_ports(&batt );\n");
	movl	$LC6, (%esp)	 #,
	call	_puts	 #
 # batt_main.c:49:   printf("batt is {\n"); 
	movl	$LC7, (%esp)	 #,
	call	_puts	 #
 # batt_main.c:50:   printf("  .volts   = %d\n", batt.volts);
	movzwl	24(%esp), %eax	 # batt.volts, _25
 # batt_main.c:50:   printf("  .volts   = %d\n", batt.volts);
	cwtl
	movl	%eax, 4(%esp)	 # _26,
	movl	$LC8, (%esp)	 #,
	call	_printf	 #
 # batt_main.c:51:   printf("  .percent = %d\n", batt.percent);
	movzbl	26(%esp), %eax	 # batt.percent, _27
 # batt_main.c:51:   printf("  .percent = %d\n", batt.percent);
	movsbl	%al, %eax	 # _27, _28
	movl	%eax, 4(%esp)	 # _28,
	movl	$LC9, (%esp)	 #,
	call	_printf	 #
 # batt_main.c:52:   printf("  .mode    = %d\n", batt.mode);
	movzbl	27(%esp), %eax	 # batt.mode, _29
 # batt_main.c:52:   printf("  .mode    = %d\n", batt.mode);
	movsbl	%al, %eax	 # _29, _30
	movl	%eax, 4(%esp)	 # _30,
	movl	$LC10, (%esp)	 #,
	call	_printf	 #
 # batt_main.c:53:   printf("}\n");
	movl	$LC11, (%esp)	 #,
	call	_puts	 #
 # batt_main.c:59:   if(result != 0){
	cmpl	$0, 28(%esp)	 #, result
	je	L9	 #,
 # batt_main.c:60:     printf("set_batt_from_ports() returned non-zero: %d\n",result);
	movl	28(%esp), %eax	 # result, tmp130
	movl	%eax, 4(%esp)	 # tmp130,
	movl	$LC12, (%esp)	 #,
	call	_printf	 #
 # batt_main.c:61:     return 1;
	movl	$1, %eax	 #, _33
	jmp	L11	 #
L9:
 # batt_main.c:64:   printf("\nChecking results for display bits\n");
	movl	$LC13, (%esp)	 #,
	call	_puts	 #
 # batt_main.c:66:   int display = 0;
	movl	$0, 20(%esp)	 #, display
 # batt_main.c:67:   result = set_display_from_batt(batt, &display);
	leal	20(%esp), %eax	 #, tmp131
	movl	%eax, 4(%esp)	 # tmp131,
	movl	24(%esp), %eax	 # batt, tmp132
	movl	%eax, (%esp)	 # tmp132,
	call	_set_display_from_batt	 #
	movl	%eax, 28(%esp)	 # tmp133, result
 # batt_main.c:68:   printf("set_display_from_batt(batt, &display);\n");
	movl	$LC14, (%esp)	 #,
	call	_puts	 #
 # batt_main.c:70:   printf("\ndisplay is:\n");
	movl	$LC15, (%esp)	 #,
	call	_puts	 #
 # batt_main.c:71:   printf("        3         2         1         0\n");
	movl	$LC16, (%esp)	 #,
	call	_puts	 #
 # batt_main.c:72:   printf("index: 10987654321098765432109876543210\n");
	movl	$LC17, (%esp)	 #,
	call	_puts	 #
 # batt_main.c:73:   printf("bits:  "); showbits(display); printf("\n");
	movl	$LC18, (%esp)	 #,
	call	_printf	 #
 # batt_main.c:73:   printf("bits:  "); showbits(display); printf("\n");
	movl	20(%esp), %eax	 # display, display.3_31
	movl	%eax, (%esp)	 # display.3_31,
	call	_showbits	 #
 # batt_main.c:73:   printf("bits:  "); showbits(display); printf("\n");
	movl	$10, (%esp)	 #,
	call	_putchar	 #
 # batt_main.c:74:   printf("guide:  |    |    |    |    |    |    |\n");
	movl	$LC19, (%esp)	 #,
	call	_puts	 #
 # batt_main.c:75:   printf("index:  30        20        10        0\n");
	movl	$LC20, (%esp)	 #,
	call	_puts	 #
 # batt_main.c:77:   if(result != 0){
	cmpl	$0, 28(%esp)	 #, result
	je	L10	 #,
 # batt_main.c:78:     printf("set_display_from_batt() returned non-zero: %d\n",result);
	movl	28(%esp), %eax	 # result, tmp134
	movl	%eax, 4(%esp)	 # tmp134,
	movl	$LC21, (%esp)	 #,
	call	_printf	 #
 # batt_main.c:79:     return 1;
	movl	$1, %eax	 #, _33
	jmp	L11	 #
L10:
 # batt_main.c:82:   printf("\nRunning batt_update()\n");
	movl	$LC22, (%esp)	 #,
	call	_puts	 #
 # batt_main.c:84:   batt_update();
	call	_batt_update	 #
 # batt_main.c:86:   printf("\nBATT_DISPLAY_PORT is:\n");
	movl	$LC23, (%esp)	 #,
	call	_puts	 #
 # batt_main.c:87:   printf("index:  3         2         1    0    0\n");
	movl	$LC24, (%esp)	 #,
	call	_puts	 #
 # batt_main.c:88:   printf("index: 10987654321098765432109876543210\n");
	movl	$LC17, (%esp)	 #,
	call	_puts	 #
 # batt_main.c:89:   printf("bits:  "); showbits(BATT_DISPLAY_PORT); printf("\n");
	movl	$LC18, (%esp)	 #,
	call	_printf	 #
 # batt_main.c:89:   printf("bits:  "); showbits(BATT_DISPLAY_PORT); printf("\n");
	movl	_BATT_DISPLAY_PORT, %eax	 # BATT_DISPLAY_PORT, BATT_DISPLAY_PORT.4_32
	movl	%eax, (%esp)	 # BATT_DISPLAY_PORT.4_32,
	call	_showbits	 #
 # batt_main.c:89:   printf("bits:  "); showbits(BATT_DISPLAY_PORT); printf("\n");
	movl	$10, (%esp)	 #,
	call	_putchar	 #
 # batt_main.c:90:   printf("guide:  |    |    |    |    |    |    |\n");
	movl	$LC19, (%esp)	 #,
	call	_puts	 #
 # batt_main.c:91:   printf("index:  30        20        10        0\n");
	movl	$LC20, (%esp)	 #,
	call	_puts	 #
 # batt_main.c:94:   printf("\nBattery Meter Display:\n");
	movl	$LC25, (%esp)	 #,
	call	_puts	 #
 # batt_main.c:95:   print_batt_display();
	call	_print_batt_display	 #
 # batt_main.c:97:   return 0;
	movl	$0, %eax	 #, _33
L11:
 # batt_main.c:98: }
	leave	
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret	
	.cfi_endproc
LFE20:
	.ident	"GCC: (MinGW.org GCC-8.2.0-5) 8.2.0"
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_puts;	.scl	2;	.type	32;	.endef
	.def	_atoi;	.scl	2;	.type	32;	.endef
	.def	_set_batt_from_ports;	.scl	2;	.type	32;	.endef
	.def	_set_display_from_batt;	.scl	2;	.type	32;	.endef
	.def	_showbits;	.scl	2;	.type	32;	.endef
	.def	_putchar;	.scl	2;	.type	32;	.endef
	.def	_batt_update;	.scl	2;	.type	32;	.endef
	.def	_print_batt_display;	.scl	2;	.type	32;	.endef
