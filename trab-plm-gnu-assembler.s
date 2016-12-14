#Mayza Yuri Hirose da Costa RA88739

.section .data

#STRINGS MENU
menu:		.asciz	"\n*****************************\n* Gerenciamento de Locadora *\n*****************************\n"
menuopcoes:	.asciz	"\nEscolha uma opcao:\n<1>Cliente\n<2>Filmes\n<3>Locação\n<4>Sair\n\n"
submenu:	.asciz	"\n*****************\n* O que deseja? *\n*****************\n"
submenuopcoes:	.asciz	"\n<1>Cadastrar\n<2>Consultar\n<3>Relatório\n<4>Voltar\n\n"
menulocacao:	.asciz	"\n******* EM CONSTRUÇÃO *******\n\n"

#CADASTRO DE CLIENTE
nome:		.asciz	"\n>Dados Pessoais<\nNome:"
cpf:		.asciz	"CPF:"
rg:		.asciz	"RG:"
email:		.asciz	"Email:"
rua:		.asciz	"\n>Endereço<\nRua:"
num:		.asciz	"Nº:"
bairro:		.asciz	"Bairro:"
cidade:		.asciz	"Cidade:"
telefone:	.asciz	"Telefone:"

#CADASTRO DE FILME
titulo:		.asciz	"\nTitulo:"
anolancamento:	.asciz	"Ano de Lançamento:"
duracao:	.asciz	"Duração:"
atorprincipal:	.asciz	"Ator Principal:"
diretor:	.asciz	"Diretor:"
totalcopias:	.asciz	"Total de Copias:"
locadas:	.asciz	"Copias Locadas:"
disponiveis:	.asciz	"Copias disponiveis:"
totallocacoes:	.asciz	"Total de Locacoes:"
avmedia:	.asciz	"Nota dos Clientes:"

#STRINGS AUXILIARES
pl:		.asciz	"\n"
pl2:		.asciz	"--------------------------"

#STRINGS RELATORIOS
enfrelatoriocliente:	.asciz	"\n************************\n* Clientes Cadastrados *\n************************\n"
enfrelatoriofilme:		.asciz	"\n************************\n* Filmes Cadastrados *\n************************\n"
finallista:		.asciz	"\n\n***** FIM DA LISTA *****\n"

#Registro do Cliente = Nome(40) CPF(20) RG(20) Email(30) Rua(40) Nº(10) Bairro(25) Cidade(20) Telefone(20) Assistidos(4) Locados(4) Reserva(4) Saldo(4) prox(4) = 245

#Registro do Filme = Titulo(40) Ano Lançamento(15) Duração(15) Ator Principal(20) Diretor(20) Total Copias(5) Locadas(5) Disponiveis(5) Num Locaçoes(5) Av Media(5) Clientes que Locaram(4) clientes na Espera(4) prox(4) = 147

opcao:		.int	0
formatodec:	.asciz	"%d"
limpabuf:	.asciz	"%c"
NULL:		.int	0

listaclientes:	.int 	NULL
listafilmes:	.int	NULL
tamregcliente:	.int	245
tamregfilme:	.int	147

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
	pushl	$formatodec
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
	pushl	$formatodec
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

	call	achaposicaonalistaclientes

	cmpl	$NULL, %esi
	je	insereregistroiniciocliente
	movl	241(%esi), %ecx
	movl	%ecx, 241(%edi)
	movl	%edi, 241(%esi)

	ret

pegadadoscliente:

	pushl	%edi
	
	pushl	$limpabuf
	call	scanf
	addl	$4, %esp

	pushl	$nome
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$40, %edi
	pushl	%edi

	pushl	$cpf
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$20, %edi
	pushl	%edi

	pushl	$rg
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$20, %edi
	pushl	%edi

	pushl	$email
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$30, %edi
	pushl	%edi

	pushl	$rua
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$40, %edi
	pushl	%edi

	pushl	$num
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$10, %edi
	pushl	%edi

	pushl	$bairro
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$25, %edi
	pushl	%edi

	pushl	$cidade
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$20, %edi
	pushl	%edi

	pushl	$telefone
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

achaposicaonalistaclientes:
	
	movl	listaclientes, %esi
	pushl	%edi
	pushl	%esi
	call	strcmp
	popl	%esi
	popl	%edi

	jl	procuraposicaomeioclientes
	movl	$NULL, %esi
	
	ret

insereregistroiniciocliente:

	movl	listaclientes, %esi
	movl	%esi, 241(%edi) #passa o endereço apontado pela lista para o final do registro a ser adicionado. 
	movl	%edi, listaclientes

	ret

procuraposicaomeioclientes:	
	
	movl	241(%esi), %ecx
	cmpl	$NULL, %ecx
	jne	existeregistroaindaclientes

	ret

existeregistroaindaclientes:
	
	pushl	%esi
	movl	%ecx, %esi

	#verifica se o proximo reg é maior ou menor
	pushl	%edi
	pushl	%esi
	call	strcmp
	popl	%esi
	popl	%edi

	jl	registroemaiorcliente
	popl	%esi	#se o registro é menor, entao recupera o %esi da pilha

	ret

registroemaiorcliente:

	addl	$4, %esp
	#movl	%ecx, %esi
	jmp	procuraposicaomeioclientes

	ret

consultarcliente:

	ret

relatoriocliente:
	
	pushl	$enfrelatoriocliente
	call	printf
	addl	$4, %esp

	movl	listaclientes, %edi
		
	call	verificalistaclientes

	ret

verificalistaclientes:

	cmpl	$NULL, %edi
	je	fimlista

	call	mostracliente
	movl	241(%edi), %edi #pega o valor apontado pela posicao 241 do %edi e passa pro %edi
	jmp	verificalistaclientes

	ret

mostracliente:

	pushl	$nome
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$40, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$cpf
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$20, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$rg
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$20, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$email
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$30, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$rua
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$40, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$num
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$10, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$bairro
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$25, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$cidade
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$20, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$telefone
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

	pushl	$finallista
	call	printf
	addl	$4, %esp
	
	ret

opcaofilme:

	pushl	$submenu
	call	printf
	pushl	$submenuopcoes
	call	printf

	pushl	$opcao
	pushl	$formatodec
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

cadastrofilme:
	
	pushl	$tamregfilme
	call	malloc
	movl	%eax, %edi
	addl	$4, %esp
	
	call	pegadadosfilme
	movl	listafilmes, %esi

	cmpl	$NULL, %esi
	je	insereprimeirofilme

	call	achaposicaonalistafilmes

	cmpl	$NULL, %esi
	je	insereregistroiniciofilme
	movl	143(%esi), %ecx
	movl	%ecx, 143(%edi)
	movl	%edi, 143(%esi)
	
	ret

pegadadosfilme:

	pushl	%edi
	
	pushl	$limpabuf
	call	scanf
	addl	$4, %esp

	pushl	$titulo
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$40, %edi
	pushl	%edi

	pushl	$anolancamento
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$15, %edi
	pushl	%edi

	pushl	$duracao
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$15, %edi
	pushl	%edi

	pushl	$atorprincipal
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$20, %edi
	pushl	%edi

	pushl	$diretor
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$20, %edi
	pushl	%edi

	pushl	$totalcopias
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$5, %edi
	pushl	%edi

	pushl	$locadas
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$5, %edi
	pushl	%edi

	pushl	$disponiveis
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$5, %edi
	pushl	%edi

	pushl	$totallocacoes
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$5, %edi
	pushl	%edi

	pushl	$avmedia
	call	printf
	addl	$4, %esp
	call	gets
	popl	%edi
	addl	$5, %edi

	movl	$NULL, (%edi);
	addl	$4, %edi

	movl	$NULL, (%edi);
	addl	$4, %edi

	movl	$NULL, (%edi);
	#addl	$4, %edi

	subl	$143, %edi

	ret

insereprimeirofilme:

	movl	%edi, listafilmes

	ret

achaposicaonalistafilmes:
	
	movl	listafilmes, %esi
	pushl	%edi
	pushl	%esi
	call	strcmp
	popl	%esi
	popl	%edi

	jl	procuraposicaomeiofilmes
	movl	$NULL, %esi
	
	ret

insereregistroiniciofilme:

	movl	listafilmes, %esi
	movl	%esi, 143(%edi) #passa o endereço apontado pela lista para o final do registro a ser adicionado. 
	movl	%edi, listafilmes

	ret

procuraposicaomeiofilmes:	
	
	movl	143(%esi), %ecx
	cmpl	$NULL, %ecx
	jne	existeregistroaindafilmes

	ret

existeregistroaindafilmes:
	
	pushl	%esi
	movl	%ecx, %esi

	#verifica se o proximo reg é maior ou menor
	pushl	%edi
	pushl	%esi
	call	strcmp
	popl	%esi
	popl	%edi

	jl	registroemaiorfilme
	popl	%esi	#se o registro é menor, entao recupera o %esi da pilha

	ret

registroemaiorfilme:

	addl	$4, %esp
	#movl	%ecx, %esi
	jmp	procuraposicaomeiofilmes

	ret

consultarfilme:

	ret

relatoriofilme:
	
	pushl	$enfrelatoriofilme
	call	printf
	addl	$4, %esp

	movl	listafilmes, %edi
		
	call	verificalistafilmes

	ret

verificalistafilmes:

	cmpl	$NULL, %edi
	je	fimlista

	call	mostrafilme
	movl	143(%edi), %edi #pega o valor apontado pela posicao 143 do %edi e passa pro %edi
	jmp	verificalistafilmes

	ret

mostrafilme:

	pushl	$titulo
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$40, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$anolancamento
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$15, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$duracao
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$15, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$atorprincipal
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$20, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$diretor
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$20, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$totalcopias
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$5, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$locadas
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$5, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$disponiveis
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$5, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$totallocacoes
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$5, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$avmedia
	call	printf
	pushl	%edi
	call	printf
	addl	$8, %esp
	addl	$5, %edi
	pushl	$pl
	call	printf
	addl	$4, %esp

	pushl	$pl2
	call	printf
	addl	$4, %esp

	subl	$135, %edi

	ret

opcaolocacao:

	pushl	$menulocacao
	call	printf
	addl	$4, %esp

	ret

sair:
	addl	$8, %esp
	pushl	$0
	call	exit


	
