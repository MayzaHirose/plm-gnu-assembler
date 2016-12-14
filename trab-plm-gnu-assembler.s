#Mayza Yuri Hirose da Costa

.section .data

menu:		.asciz	"\n*****************************\n* Gerenciamento de Locadora *\n*****************************\n"
menuopcoes:		.asciz	"\nEscolha uma opcao:\n<1>Cliente\n<2>Filmes\n<3>Locação\n<4>Sair\n\n"
submenu:	.asciz	"\n*****************\n* O que deseja? *\n*****************\n"
submenuopcoes:	.asciz	"\n<1>Cadastrar\n<2>Consultar\n<3>Relatório\n<4>Voltar\n\n"
menulocacao:	.asciz	"\n******* EM CONSTRUÇÃO *******\n\n"

#CADASTRO DE CLIENTE
pedenome:	.asciz	"\n>Dados Pessoais<\nNome:"
pedecpf:	.asciz	"CPF:"
pederg:		.asciz	"RG:"
pedeemail:	.asciz	"Email:"
pederua:	.asciz	"\n>Endereço<\nRua:"
pedenum:	.asciz	"Nº:"
pedebairro:	.asciz	"Bairro:"
pedecidade:	.asciz	"Cidade:"
pedetelefone:	.asciz	"Telefone:"
pl:		.asciz	"\n"
pl2:		.asciz	"--------------------------"

#RELATORIO DE CLIENTES
enfeiterelatorio:	.asciz	"\n************************\n* Clientes Cadastrados *\n************************\n"
finallistaclientes:	.asciz	"\n\n***** FIM DA LISTA *****\n"

#Registro do cliente = Nome(40) CPF(20) RG(20) Email(30) Rua(40) Nº(10) Bairro(25) Cidade(20) Telefone(20) Assistidos(4) Locados(4) Reserva(4) Saldo(4) prox(4) = 245

opcao:		.int	0
formato:	.asciz	"%d"
NULL:		.int	0
listaclientes:	.int 	NULL
tamregcliente:	.int	245

limpabuf:	.asciz	"%c"

.section .text

.globl _start

_start:
	
	jmp telainicial

telainicial:

	pushl	$menu
	call	printf
	addl	$4, %esp

	pushl	$menuopcoes
	call	printf

	pushl	$opcao
	pushl	$formato
	call	scanf

	addl	$12, %esp

	movl	opcao, %ebx
	call	redirecionaopcao
	cmpl	$4, %ebx
	je	sair
	jne	telainicial	

redirecionaopcao:

	cmpl	$1, %ebx
	je	opcaocliente

	cmpl	$2, %ebx
	je	opcaofilme

	cmpl	$3, %ebx
	je	opcaolocacao

	ret

opcaocliente:

	pushl	$submenu
	call	printf
	pushl	$submenuopcoes
	call	printf

	pushl	$opcao
	pushl	$formato
	call	scanf

	addl	$16, %esp

	movl	opcao, %ebx
	
	cmpl	$1, %ebx
	je	cadastrocliente

	cmpl	$2, %ebx
	je	consultarcliente

	cmpl	$3, %ebx
	je	relatoriocliente

	cmpl	$4, %ebx
	je	telainicial

	ret

cadastrocliente:

	pushl	$tamregcliente
	call	malloc
	movl	%eax, %edi
	addl	$4, %esp
	
	call	pegadadoscliente
	movl	listaclientes, %esi

	cmpl	$NULL, %esi
	je	insereprimeirocliente

	call	encaixaclientenalista

	cmpl	$NULL, %esi
	je	inserecliini
	movl	241(%esi), %ecx
	movl	%ecx, 241(%edi)
	movl	%edi, 241(%esi)

	ret

pegadadoscliente:

	pushl	%edi
	
	pushl	$limpabuf
	call	scanf
	addl	$4, %esp

	pushl	$pedenome
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$40, %edi
	pushl	%edi

	pushl	$pedecpf
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$20, %edi
	pushl	%edi

	pushl	$pederg
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$20, %edi
	pushl	%edi

	pushl	$pedeemail
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$30, %edi
	pushl	%edi

	pushl	$pederua
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$40, %edi
	pushl	%edi

	pushl	$pedenum
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$10, %edi
	pushl	%edi

	pushl	$pedebairro
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$25, %edi
	pushl	%edi

	pushl	$pedecidade
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$20, %edi
	pushl	%edi

	pushl	$pedetelefone
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$20, %edi

	movl	$NULL, (%edi);
	addl	$4, %edi

	movl	$NULL, (%edi);
	addl	$4, %edi

	movl	$NULL, (%edi);
	addl	$4, %edi

	movl	$NULL, (%edi);
	addl	$4, %edi

	movl	$NULL, (%edi);
	#addl	$4, %edi

	subl	$241, %edi

	ret

insereprimeirocliente:

	movl	%edi, listaclientes

	ret

encaixaclientenalista:
	
	movl	listaclientes, %esi
	pushl	%edi
	pushl	%esi
	call	strcmp
	popl	%esi
	popl	%edi

	jl	contcli
	movl	$NULL, %esi
	
	ret

inserecliini:

	movl	listaclientes, %esi
	movl	%esi, 241(%edi) #passa o endereço apontado pela lista para o final do registro a ser adicionado. 
	movl	%edi, listaclientes

	ret

contcli:	
	
	movl	241(%esi), %ecx
	cmpl	$NULL, %ecx
	jne	avancacli

	ret

avancacli:
	
	pushl	%esi
	movl	%ecx, %esi
	jmp	voltacli

	ret

voltacli:
	
	pushl	%edi
	pushl	%esi
	call	strcmp
	popl	%esi
	popl	%edi

	jl	contcliaux
	#movl	%esp, %esi 
	popl	%esi	#ok, caso em que o B É MAIOR QUE O Q ESTA SENDO INSERIDO 

	ret

contcliaux:

	addl	$4, %esp
	#movl	%ecx, %esi
	jmp	contcli

	ret

consultarcliente:

	ret

relatoriocliente:
	
	pushl	$enfeiterelatorio
	call	printf
	addl	$4, %esp

	movl	listaclientes, %edi
		
	call	verificalista

	ret

verificalista:

	cmpl	$NULL, %edi
	je	fimlista

	call	mostracliente
	movl	241(%edi), %edi #pega o valor apontado pela posicao 241 do %edi e passa pro %edi
	jmp	verificalista

	ret

mostracliente:

	pushl	$pedenome
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$40, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$pedecpf
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$20, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$pederg
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$20, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$pedeemail
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$30, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$pederua
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$40, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$pedenum
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$10, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$pedebairro
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$25, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$pedecidade
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$20, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$pedetelefone
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$20, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$pl2
	call	printf
	addl	$4, %esp

	subl	$225, %edi

	ret

fimlista:

	pushl	$finallistaclientes
	call	printf
	addl	$4, %esp
	
	ret

opcaofilme:

	pushl	$submenu
	call	printf
	pushl	$submenuopcoes
	call	printf
	
	pushl	$opcao
	pushl	$formato
	call	scanf

	addl	$16, %esp

	movl	opcao, %ebx
	
	cmpl	$1, %ebx
	je	cadastrofilme

	cmpl	$2, %ebx
	je	consultarfilme

	cmpl	$3, %ebx
	je	relatoriofilme

	cmpl	$4, %ebx
	je	telainicial

	ret

opcaolocacao:

	pushl	$menulocacao
	call	printf
	addl	$4, %esp

	ret

cadastrofilme:
	
	ret

pegadadosfilme:

	ret

consultarfilme:

	ret

relatoriofilme:
	
	ret

sair:
	addl	$8, %esp
	pushl	$0
	call	exit


	
