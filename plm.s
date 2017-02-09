#Mayza Yuri Hirose da Costa RA88739

.section .data

#STRINGS MENU
menu:		.asciz	"\n*****************************\n* Gerenciamento de Locadora *\n*****************************\n"
menuopcoes:	.asciz	"\nEscolha uma opcao:\n1. Cliente\n2. Filmes\n3. Locação\n4. Relatorio Adicional\n5. Sair\n\n"
submenu:	.asciz	"\n*****************\n* O que deseja? *\n*****************\n"
submenuopcoes:	.asciz	"\n<1>Cadastrar\n<2>Consultar\n<3>Relatório de Cadastros\n<4>Voltar\n\n"
submenulocacao:	.asciz	"\n<1>Nova Locacao\n<2>Devolucao\n<3>Voltar\n\n"

pedeNomeArq:	.asciz "\nEntre com o nome do arquivo de entrada/saida\n> "

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
formatodec:	.asciz	"%d"
limpabuf:	.asciz	"%c"
pl:		.asciz	"\n"
pl2:		.asciz	"--------------------------"
continuar:	.asciz	"\nTecle para continuar..."
#sleep:		.asciz	"sleep 3"
#read:		.asciz	"read -t 999"

#VARIAVEIS ARQUIVO
nomeArq:		.space	50
registroCliente:	.space	241
tamListaClientes:	.int	241
registroFilme:		.space	143
tamListaFilme:		.int	1430

lixo:			.int	0
opcaoArq:		.int	0
iformato:		.asciz	"%d"
fformato:		.asciz	"%lf"
descritor:		.int	0

SYS_EXIT:	.int	1
SYS_FORK:	.int	2
SYS_READ:	.int	3
SYS_WRITE:	.int	4
SYS_OPEN:	.int	5
SYS_CLOSE:	.int	6
SYS_CREAT:	.int	8

STD_OUT:	.int	1   	
STD_IN:		.int	2

SAIDA_NORMAL:	.int	0

O_RDONLY:	.int	0x0000	# somente leitura
O_WRONLY:	.int	0x0001	# somente escrita
O_RDWR:		.int	0x0002	# leitura e escrita
O_CREAT:	.int	0x0040	# cria o arquivo na abertura, caso ele não exista
O_EXCL:		.int	0x0080	# força a criação
O_APPEND:	.int	0x0400	# posiciona o cursor do arquivo no final, para adição
O_TRUNC:	.int	0x0200

S_IRWXU:  	.int	0x01C0	# user (file owner) has read, write and execute permission
S_IRUSR:	.int	0x0100	# user has read permission
S_IWUSR:	.int	0x0080 	# user has write permission
S_IXUSR:	.int	0x0040 	# user has execute permission
S_IRWXG:	.int	0x0038 	# group has read, write and execute permission
S_IRGRP:	.int	0x0020 	# group has read permission
S_IWGRP:	.int	0x0010 	# group has write permission
S_IXGRP:	.int	0x0008	# group has execute permission
S_IRWXO:	.int	0x0007	# others have read, write and execute permission
S_IROTH:	.int	0x0004	# others have read permission
S_IWOTH:	.int	0x0002	# others have write permission
S_IXOTH:	.int	0x0001	# others have execute permission
S_NADA:		.int	0x0000	# não altera a situação


#STRINGS RELATORIOS
enfrelatoriocliente:	.asciz	"\n************************\n* Clientes Cadastrados *\n************************\n"
enfrelatoriofilme:		.asciz	"\n************************\n* Filmes Cadastrados *\n************************\n"
finallista:		.asciz	"\n\n***** FIM DA LISTA *****\n"

#STRINGS CONSULTA CLIENTE E FILME
enfeiteconsultacliente:	.asciz	"\nInsira o nome do Cliente a ser consultado:"
enfeiteconsultafilme:	.asciz	"\nInsira o título do Filme a ser consultado:"
clinaoencontrado:	.asciz	"\nCLIENTE NAO CADASTRADO!\n"
filnaoencontrado:	.asciz	"\nFILME NAO CADASTRADO!\n"


#Registro do Cliente = Nome(40) CPF(20) RG(20) Email(30) Rua(40) Nº(10) Bairro(25) Cidade(20) Telefone(20) Assistidos(4) Locados(4) Saldo(4) prox(4) = 241 Reserva(4)

#Registro do Filme = Titulo(40) Ano Lançamento(15) Duração(15) Ator Principal(20) Diretor(20) Total Copias(5) Locadas(5) Disponiveis(5) Num Locaçoes(5) Av Media(5) Clientes que Locaram(4) prox(4) = 143 clientes na Espera(4)

#Nova Locacao = CopiasDisponiveis

opcao:		.int	0
NULL:		.int	0

listaclientes:	.int 	NULL
listafilmes:	.int	NULL
tamregcliente:	.int	241
tamregfilme:	.int	143
consulta:	.int	40
teclacontinua:	.int	4

todosclientes:	.space	2410 #(10 clientes)
todosfilmes:	.space	1430 #(10 filmes)
teste:		.asciz 	"TAM = %d\n\n"

.section .text

.globl _start

_start:
	
	#jmp telainicial
	call abertura
	finit	

telainicial:

	#Enfeite Sistema
	pushl	$menu
	call	printf
	addl	$4, %esp

	#Recebe opção
	pushl	$menuopcoes
	call	printf
	pushl	$opcao
	pushl	$formatodec
	call	scanf
	addl	$12, %esp

	#Verifica opção
	movl	opcao, %ebx
	call	redirecionaopcao
	cmpl	$5, %ebx
	je	sair
	jne	telainicial

	ret	

abertura: 
	pushl	$pedeNomeArq
	call	printf
	pushl	$nomeArq
	call	gets
	addl	$8, %esp
	ret

redirecionaopcao:

	cmpl	$1, %ebx
	je	menucliente

	cmpl	$2, %ebx
	je	menufilme

	cmpl	$3, %ebx
	je	menulocacao

	cmpl	$4, %ebx
	je	opcaorelatorioadicional
	
	ret

menucliente:

	#Enfeite menu cliente
	pushl	$submenu
	call	printf

	#Recebe opção
	pushl	$submenuopcoes
	call	printf
	pushl	$opcao
	pushl	$formatodec
	call	scanf
	addl	$16, %esp

	#Verifica opção
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

	#Aloca espaço na memória para o novo registro
	pushl	$tamregcliente
	call	malloc
	movl	%eax, %edi
	addl	$4, %esp
	
	call	pegadadoscliente
	movl	listaclientes, %esi

	#Verifica se a lista está vazia. Se estiver, insere direto
	cmpl	$NULL, %esi
	je	insereprimeirocliente

	#Se não estiver vazia, procura posição
	call	achaposicaonalistaclientes

	#A função acima retornará NULL se o novo registro tiver que ser inserido na frente de todos
	#Caso retorne outro valor, o registro sera "encaixado" na lista nas tres ultimas instruções
	cmpl	$NULL, %esi
	je	insereregistroiniciocliente

	#"Encaixa" o novo registro caso o valor retornado pelo "achaposiçãolistaclientes" for diferente de NULO
	#Faz o novo registro apontar para o registro apontado pelo retornado; e o registro retornado apontar para o novo registro
	movl	237(%esi), %ecx
	movl	%ecx, 237(%edi)
	movl	%edi, 237(%esi)

	call	abreArqS
	call	gravaReg
	call	fechaArq

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

	subl	$237, %edi

	ret

insereprimeirocliente:

	movl	%edi, listaclientes

	call	abreArqS
	call	gravaReg
	call	fechaArq

	ret

achaposicaonalistaclientes:
	
	#Compara a primeira string da lista com a do novo registro
	movl	listaclientes, %esi
	pushl	%edi
	pushl	%esi
	call	strcmp
	popl	%esi
	popl	%edi

	#se a string da lista for menor que a do novo registro, continua procurando a posição
	jl	procuraposicaomeioclientes

	#se não ela retorna NULL (insere no início da lista)
	movl	$NULL, %esi
	
	ret

insereregistroiniciocliente:

	movl	listaclientes, %esi
	movl	%esi, 237(%edi) #passa o endereço apontado pela lista para o final do registro a ser adicionado. 
	movl	%edi, listaclientes

	call	abreArqS
	call	gravaReg
	call	fechaArq

	ret

procuraposicaomeioclientes:	
	
	#Recupera o registro apontado pelo reg anterior. 
	movl	237(%esi), %ecx

	#Se NULL, é o fim da lista. Se não, continua percorrendo a lista
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
	jmp	procuraposicaomeioclientes

	ret

consultarcliente:	

	jmp 	mostraArq
	
	pushl	$enfeiteconsultacliente
	call	printf
	addl	$4, %esp

	#Aloca espaço na memória para guardar o nome do cliente a ser consultado
	pushl	$consulta
	call	malloc
	movl	%eax, %esi
	addl	$4, %esp	

	pushl	%esi

	#limpa buffer e captura o nome
	pushl	$limpabuf
	call	scanf
	addl	$4, %esp
	call	gets
	popl	%esi

	movl	listaclientes, %edi
	call	procuracliente

	ret

procuracliente:

	#compara o registro atual com NULL. Se NULL, o cliente não foi encontrado
	cmpl	$NULL, %edi
	je	clientenaoencontrado

	#Compara o registro atual com o nome procurado
	pushl	%edi
	pushl	%esi
	call	strcmp
	popl	%esi
	popl	%edi
	
	#Se for igual, cliente foi encontrado
	je	clienteencontrado

	#Se não, recupera o próximo registro da lista de cliente e repete a procura
	movl	237(%edi), %edi #pega o valor apontado pela posicao 241 do %edi e passa pro %edi
	jmp	procuracliente

	ret

clienteencontrado:
	
	call	mostracliente

	call	tecleparacontinuar

	ret

clientenaoencontrado:

	pushl	$clinaoencontrado
	call	printf
	addl	$4, %esp

	call	tecleparacontinuar

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

	#Mostra o cliente atual e recupera o próximo da lista
	call	mostracliente
	movl	237(%edi), %edi #pega o valor apontado pela posicao 241 do %edi e passa pro %edi
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

	pushl	%esi
	pushl	$limpabuf
	call	scanf
	addl	$8, %esp

	call	tecleparacontinuar
	
	ret

menufilme:

	#Enfeite menu cliente
	pushl	$submenu
	call	printf

	#Recebe opção
	pushl	$submenuopcoes
	call	printf
	pushl	$opcao
	pushl	$formatodec
	call	scanf
	addl	$16, %esp

	#Verifica opção
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
	
	#Aloca espaço na memória para o novo registro
	pushl	$tamregfilme
	call	malloc
	movl	%eax, %edi
	addl	$4, %esp
	
	call	pegadadosfilme
	movl	listafilmes, %esi

	#Verifica se a lista está vazia. Se estiver, insere direto
	cmpl	$NULL, %esi
	je	insereprimeirofilme

	#Se não estiver vazia, procura posição
	call	achaposicaonalistafilmes

	#A função acima retornará NULL se o novo registro tiver que ser inserido na frente de todos
	#Caso retorne outro valor, o registro sera "encaixado" na lista nas tres ultimas instruções
	cmpl	$NULL, %esi
	je	insereregistroiniciofilme

	#"Encaixa" o novo registro caso o valor retornado pelo "achaposiçãolistafilmes" for diferente de NULO
	#Faz o novo registro apontar para o registro apontado pelo retornado; e o registro retornado apontar para o novo registro
	movl	139(%esi), %ecx
	movl	%ecx, 139(%edi)
	movl	%edi, 139(%esi)
	
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

	subl	$139, %edi

	ret

insereprimeirofilme:

	movl	%edi, listafilmes

	ret

achaposicaonalistafilmes:
	
	#Compara a primeira string da lista com a do novo registro
	movl	listafilmes, %esi
	pushl	%edi
	pushl	%esi
	call	strcmp
	popl	%esi
	popl	%edi

	#se a string da lista for menor que a do novo registro, continua procurando a posição
	jl	procuraposicaomeiofilmes

	#se não ela retorna NULL (insere no início da lista)
	movl	$NULL, %esi
	
	ret

insereregistroiniciofilme:

	movl	listafilmes, %esi
	movl	%esi, 139(%edi) #passa o endereço apontado pela lista para o final do registro a ser adicionado. 
	movl	%edi, listafilmes

	ret

procuraposicaomeiofilmes:	
	
	#Recupera o registro apontado pelo reg anterior.
	movl	139(%esi), %ecx

	#Se NULL, é o fim da lista. Se não, continua percorrendo a lista
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

	pushl	$enfeiteconsultafilme
	call	printf
	addl	$4, %esp

	#Aloca espaço na memória para guardar o nome do cliente a ser consultado
	pushl	$consulta
	call	malloc
	movl	%eax, %esi
	addl	$4, %esp	

	pushl	%esi

	#limpa buffer e captura o titulo
	pushl	$limpabuf
	call	scanf
	addl	$4, %esp
	call	gets
	popl	%esi

	movl	listafilmes, %edi
	call	procurafilme

	ret

procurafilme:

	#compara o registro atual com NULL. Se NULL, o cliente não foi encontrado
	cmpl	$NULL, %edi
	je	filmenaoencontrado

	#Compara o registro atual com o titulo procurado
	pushl	%edi
	pushl	%esi
	call	strcmp
	popl	%esi
	popl	%edi
	
	#Se for igual, filme foi encontrado
	je	filmeencontrado

	#Se não, recupera o próximo registro da lista de filmes e repete a procura
	movl	139(%edi), %edi #pega o valor apontado pela posicao 139 do %edi e passa pro %edi
	jmp	procurafilme

	ret

filmeencontrado:
	
	call	mostrafilme
	call	tecleparacontinuar

	ret

filmenaoencontrado:

	pushl	$filnaoencontrado
	call	printf
	addl	$4, %esp

	call	tecleparacontinuar

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

	#Mostra o filme atual e recupera o próximo da lista
	call	mostrafilme
	movl	139(%edi), %edi #pega o valor apontado pela posicao 143 do %edi e passa pro %edi
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

menulocacao:

	#Enfeite menu 
	pushl	$submenu
	call	printf

	#Recebe opção
	pushl	$submenulocacao
	call	printf
	pushl	$opcao
	pushl	$formatodec
	call	scanf
	addl	$16, %esp

	#Verifica opção
	movl	opcao, %ebx
	
	cmpl	$1, %ebx
	je	novalocacao

	cmpl	$2, %ebx
	je	devolucao

	cmpl	$3, %ebx
	je	telainicial

	ret

novalocacao:

	pushl	$submenulocacao
	call	printf
	addl	$4, %esp

	ret

devolucao:

	pushl	$submenulocacao
	call	printf
	addl	$4, %esp

	ret

opcaorelatorioadicional:

	pushl	$submenulocacao
	call	printf
	addl	$4, %esp

	ret

tecleparacontinuar:

	#Função para enfeite e organização do sistema
	pushl	$continuar
	call	printf
	addl	$4, %esp
	
	pushl	$teclacontinua
	call	malloc
	movl	%eax, %esi
	addl	$4, %esp

	pushl	%esi

	call	gets
	addl	$4, %esp

	ret

abreArqS:
	movl 	SYS_OPEN, %eax	# system call OPEN: retorna o descritor em %eax
	movl	$nomeArq, %ebx
	movl 	O_WRONLY, %ecx
	orl	O_CREAT, %ecx
	orl	O_APPEND, %ecx
	movl	S_IRUSR, %edx
	orl	S_IWUSR, %edx
	int  	$0x80
	movl	%eax, descritor	# guarda o descritor
	ret	

gravaReg:

	movl	listaclientes, %edi

	movl	$241, tamListaClientes
	pushl	tamListaClientes
	pushl	$teste
	call	printf
	addl	$8, %esp

	call	contaregistros

	pushl	tamListaClientes
	pushl	$teste
	call	printf
	addl	$8, %esp

	movl 	SYS_WRITE, %eax
	movl	descritor, %ebx	# recupera o descritor
	movl 	%edi, %ecx
	movl	tamListaClientes, %edx
	int  	$0x80
	ret	

contaregistros:
	movl	237(%edi), %esi

	cmpl	$NULL, %esi
	jne	somatamlista

	ret

contaregistros2:
	movl	237(%esi), %esi

	cmpl	$NULL, %esi
	jne	somatamlista

	ret

somatamlista:
	addl	$241, tamListaClientes
	jmp	contaregistros2

	ret

mostraArq:
	call	abreArqE
	call	mostraRegs
	call	fechaArq
	ret

abreArqE:
	movl 	SYS_OPEN, %eax	# system call OPEN: retorna o descritor em %eax
	movl	$nomeArq, %ebx	
	movl 	O_RDONLY, %ecx
	int  	$0x80
	movl	%eax, descritor	# guarda o descritor
	ret

mostraRegs:

	movl 	SYS_READ, %eax	# %eax retorna numero de bytes lidos
	movl	descritor, %ebx	# recupera o descritor
	movl 	$registroCliente, %ecx	
	movl	tamListaClientes, %edx
	int  	$0x80		# le registro do arquivo
	movl	$registroCliente, %edi
	cmpl	$0, %eax

	jle	fimMostra

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

	jmp	mostraRegs

	ret

fimMostra:
	ret

fechaArq:
	movl	SYS_CLOSE, %eax
	movl	descritor, %ebx	# recupera o descritor
	int	$0x80
	ret	

sair:
	addl	$8, %esp
	pushl	$0
	call	exit


	
