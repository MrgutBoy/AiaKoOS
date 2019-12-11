# set magic number para 0x1BADB002 identified by bootloader
.set MAGIC,	0x1BADB002
# set flags to 0
.set FLAGS,	0

# set Checksum
.set CHECKSUM, -(MAGIC + FLAGS)

# enable multiboot
.section .multiboot

# Definir tipo para long para cada dado definido acima
.long MAGIC
.long FLAGS
.long CHECKSUM

# set the Stack Bottom
stackBottom:
.skip 1024
# stack max. size 512B
stackTop:
.section .text
.global _start
.type _start, @function

_start:
	mov $stackTop, %esp
	call kernel_entry
	cli

# Loop of sys
hltLoop:
	hlt
	jmp hltLoop

.size _start, . - _start
