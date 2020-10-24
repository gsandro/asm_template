.text                           # section declaration

	# we must export the entry point to the ELF linker or
	# loader. They conventionally recognize _start as their
	# entry point. Use ld -e foo to override the default.
	.global _start

_write:
	push	%rcx
	movl    $len,%edx           # third argument: message length
	movl    $msg,%ecx           # second argument: pointer to message to write
	movl    $1,%ebx             # first argument: file handle (stdout)
	movl    $4,%eax             # system call number (sys_write)
	int     $0x80               # call kernel
	pop	%rcx

_loop:
	dec	%ecx
	cmp	$0, %ecx
	jz	_exit
	call	_write
	
_exit:

	movl    $0,%ebx             # first argument: exit code
	movl    $1,%eax             # system call number (sys_exit)
	int     $0x80               # call kernel

_start:
	movl	$10,%ecx
	call	_loop

.data                           # section declaration

msg:
	.ascii    "Hello, world!\n"   # our dear string
	len = . - msg                 # length of our dear string