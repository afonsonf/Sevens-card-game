:- use_module(library(lists)).
:- op(100,yfx,'de').

/*** BASIC ***********************************************************************************************************************************/

x(a,X):-num(L),member(X,L).

%representacao de uma carta
simb([copas,ouros,paus,espadas]).
num([1,2,3,4,5,6,7,8,9,10,11,12,13]).

%deck(baralho)
deck(L):-
    findall(card(Y de X),(simb(L1),num(L2),member(X,L1),member(Y,L2)),L).

%fresh_board(board inicial)
%t(lista de cartas que podem serjogadas,naipe)
%[0] para destuinguir de [] quando uma sequencia esta completa
fresh_board([t([0],copas  ), 
             t([7],espadas),
             t([0],ouros  ), 
             t([0],paus   )]).

%shuffle(deck,deck baralhado)
%embaralha deck
shuffle(Deck,Deck_shuffled):-
    random_permutation(Deck,Deck_shuffled).

%separate_deck(deck,numero de jogadores,deck separado)
%separa o deck em N maos
separate_deck(D,N,R):-
	length(D,X),
	K is X mod N,W is X div N,
	(K=0,Wx=W,!;Wx is W + 1), 
	create(N,Rx,Rx2,Wx),	
	s_aux(D,Rx,Rx2,R),!.

%s_aux(deck,lista de d(P1,jogador n,numero de cartas que pode receber),maos vazias onde se vai colocar as cartas,retorna o anterior)
%P1->valor pelo qual se pode ordenar caso se queira uma divisao mais justa das cartas
%caso se queira uma divisao mais "equilibrada" pode se alterar onde esta 'Nx is N' e fazer sort a lista de d(_,_,_)
s_aux([],_,R,R):-!.
s_aux(L,[d(_,_,0)|Dl],R,R2):-s_aux(L,Dl,R,R2),!.				%caso um jogador nao possa receber mais cartas
s_aux([card(A de B)|L],[d(N,D,K)|Dl],R,R2):-Kx is K-1,
	Nx is N,insert_a(card(A de B),D,R,Rx),s_aux(L,[d(Nx,D,Kx)|Dl],Rx,R2),!. 

%create(n de jogadores,lista de d(P1,jogador n,numero de cartas que pode receber),maos vazias onde se vai colocar as cartas,K)
%K->numero de cartas max por jogador
create(1,[d(0,1,K)],[[]],K):-!.
create(N,R,R2,K):-Nx is N-1,create(Nx,Rx,Rx2,K),R=[d(0,N,K)|Rx],R2=[[]|Rx2].

%insert_a(C,N,L,R)
%insere a carta C na mao N da lista L e retorna a lista R com a carta inserida
insert_a(C,1,[Rx|L],R):-insert(C,Rx,Rx2),R=[Rx2|L],!.
insert_a(C,N,[Rx|L],R):-Nx is N-1,insert_a(C,Nx,L,Rx2),R=[Rx|Rx2].

%insert(C,L,Lr)
%insere a carta C na lista L por ordem, separado por naipes e dentro do naipe de A a R, e retorna lista Lr
insert(C,[],[C]):-!.
insert(card(A de B),[card(A2 de B2)|L],[card(A2 de B2)|L2]):-B2@<B,insert(card(A de B),L,L2),!.
insert(card(A de B),[card(A2 de B)|L],[card(A2 de B)|L2]):-A2<A,insert(card(A de B),L,L2),!.
insert(card(A de B),[card(A2 de B2)|L],[card(A de B),card(A2 de B2)|L]).

%distribute_deck(D,N,Players,FirstNj)
%distribui os decks D,por N joagdores e cria lista de jogadores j(id,deck,burry,pontos) Players
%em FirstNj fica o id do jogador com 7 de espadas
distribute_deck([],_,[],_):-!.
distribute_deck([D|L],N,Players,FirstNj):-Players=[j(N,D,[],0)|P],N2 is N-1,distribute_deck(L,N2,P,Nt1),
	(member(card(7 de espadas),D),FirstNj=N,!;FirstNj=Nt1).

/****statistic***********************************/

%para contar quantos jogadores diferentes tiveram de fazer burry para uma certa carta na mesa (quantos jogadores nao tem uma certa carta na mao)
%bcheck(carta,lista de j,numero de j,V)
%V=0 se < de metade dos jogadores n tem a carta,0.001 se mais de metade mas nao todos,1 se todos
:-dynamic(bcheck/4).

%cria base de conhecimento,bcheck para cada carta
assertB:-deck(L),member(X,L),assert(bcheck(X,[],0,0)),fail.
assertB.

%limpa base de conhecimento,elimina todos bcheck
clearB:-retract(bcheck(_,_,_,_)),fail.
clearB.

%limpa resticios de um pograma mal terminado,e inicializa estatisticas
init_stat:-
	clearB,
	nb_setval(nc,52),%numero de cartas ainda a ser jogadas
	nb_setval(nby,0),%numero de cartas burried
	assertB.

%update_stats(Board,id do jogador)
%quando um jogador faz burry faz update ao numero de cartas que foram burry, e update ao bcheck/4 para essa carta
update_stats(Board,N):-
	nb_getval(nby,X),XX is X+1,nb_setval(nby,XX),
	getLB(Board,LB),
	updateLB(LB,N).

%getLB(Board,lista de cartas que podem ser jogadas)
%lista de cartas que podiam ser jogadas no tabuleiro
getLB([],[]):-!.
getLB([t([],_)|T],LB):-getLB(T,LB),!.
getLB([t([X|L],S)|T],LB):-getLB([t(L,S)|T],LBx),LB=[card(X de S)|LBx].

%updateLB(LB,N)
%para carta em LB,faz update a bcheck para essa carta e para jogador N
updateLB([],_).
updateLB([card(7 de _)|L],N):-!,updateLB(L,N).				%ha sempre alguem com 7 na mao, nunca pode estar no burry
updateLB([X|L],N):-bcheck(X,_,_,1),!,updateLB(L,N).			%carta ja com 1 nao se faz nada
updateLB([X|L],N):-bcheck(X,L2,_,_),member(N,L2),updateLB(L,N),!.	%jogador ja na lista
updateLB([X|L],N):-
	bcheck(X,L2,K,R),
	retract(bcheck(X,L2,K,R)),L3=[N|L2],K2 is K+1,                  %retira carta anterior da base de conhecimento
	nb_getval(npl,Nj),                                              %npl -> numero de jogadores
	(
	K2=Nj,assert(bcheck(X,L3,K2,1)),!,updateLB_b0(X),               %se nenhum jogador tem  carta na mao, e coloca todas as cartas dependentes dessa a 1
	!;
	Njx is Nj/2,K2>Njx,assert(bcheck(X,L3,K2,0.001)),!,updateLB_b0(X), %se mais de metade dos jogadores nao tem a carta na mao
	!;
	assert(bcheck(X,L3,K2,0))                                       %caso contrario
	),updateLB(L,N),!.

%updateLB_b0(C)
%faz update as cartas dependentes de C (e.g. jogar 1 e dependente de o 4 ser jogado)
updateLB_b0(card(A de S)):-A>7,A1 is A+1,!,updateLB_b1(card(A1 de S)),!.%nl,nl,write(card(A de S)),nl.
updateLB_b0(card(A de S)):-A<7,A1 is A-1,!,updateLB_b2(card(A1 de S)),!.%nl,nl,write(card(A de S)),nl.

%cartas > 7
updateLB_b1(card(14 de _)):-!.
updateLB_b1(card(A de S )):-%write(card(A de S)),nl,
	bcheck(card(A de S),L,K,R),retract(bcheck(card(A de S),L,K,R)),assert(bcheck(card(A de S),L,K,1)),
	A1 is A+1,updateLB_b1(card(A1 de S)).

%cartas <7
updateLB_b2(card(0 de _)):-!.
updateLB_b2(card(A de S )):-%write(card(A de S)),nl,
	bcheck(card(A de S),L,K,R),retract(bcheck(card(A de S),L,K,R)),assert(bcheck(card(A de S),L,K,1)),
	A1 is A-1,updateLB_b2(card(A1 de S)).	



/*** JOGO ************************************************************************************************************************************/ 

%permitted_play(C,B)
% check se a carta C pode ser jogada no tabuleiro B
permitted_play(card(A de copas),  [t(L,copas),t(_,espadas),t(_,ouros),t(_,paus)]):-
    member(A,L).
permitted_play(card(A de ouros),  [t(_,copas),t(_,espadas),t(L,ouros),t(_,paus)]):-
    member(A,L).
permitted_play(card(A de paus),   [t(_,copas),t(_,espadas),t(_,ouros),t(L,paus)]):-
    member(A,L).
permitted_play(card(A de espadas),[t(_,copas),t(L,espadas),t(_,ouros),t(_,paus)]):-
    member(A,L).  

%play_card(B,C,Br)
%Joga carta C no tabulerio B e retorna tabuleiro atualizado Br
play_card( [t([0],copas), t([7],espadas), t([0],ouros), t([0],paus)],
           card(7 de espadas),
           [t([7],copas), t([6,8],espadas), t([7],ouros), t([7],paus)]):-!.
play_card( [t(L,copas),T1,T2,T3],
           card(A de copas),
           [t(L2,copas),T1,T2,T3]):-
  	 play_card_aux(L,A,L2).
play_card( [T1,T3,t(L,ouros),T2],
           card(A de ouros),
           [T1,T3,t(L2,ouros),T2]):-
 	play_card_aux(L,A,L2).
play_card( [T1,T3,T2,t(L,paus)],
           card(A de paus),
           [T1,T3,T2,t(L2,paus)]):-
  	play_card_aux(L,A,L2).   
play_card( [T1,t(L,espadas),T2,T3],
           card(A de espadas),
           [T1,t(L2,espadas),T2,T3]):-
  	play_card_aux(L,A,L2).

%play_card_aux(L,C,Lr)
%retorna a lista de cartas que podem ser jogadas se jogar carta A em L
play_card_aux(L,A,L2):-
	(L=[7],A=7,L2=[6,8];
         L=[N],A=N,N<7,N2 is N-1,N2>0,L2=[N2];
         L=[N],A=N,N<7,N2 is N-1,not(N2>0),L2=[];
         L=[N],A=N,N>7,N2 is N+1,N2<14,L2=[N2];
         L=[N],A=N,N>7,N2 is N+1,not(N2<14),L2=[];
   	 L=[Min,Max],A=Min,Min2 is Min-1,Min2>0,L2=[Min2,Max ];
   	 L=[Min,Max],A=Min,Min2 is Min-1,not(Min2>0),L2=[Max ];
   	 L=[Min,Max],A=Max,Max2 is Max+1,Max2<14,L2=[Min,Max2];
    	 L=[Min,Max],A=Max,Max2 is Max+1,not(Max2<14),L2=[Min]).

play:-playX(X1,X2,X3),playloop(X1,X2,X3,0).
playloop(_,P,_,1):-show_ranking(P),!.
playloop(X1,X2,X3,0):-play_round(X1,X2,X3,X12,X22,X32,K,_),playloop(X12,X22,X32,K).

%inicializa um jogo, caso numero variavel de jogadores retirar % da 3 e 4 linha do play
playX(T,Players,FirstNj):-
	deck(Unshuffled_deck),
    	shuffle(Unshuffled_deck, Deck),
	%nl,write("Numero de Jogadores?"),nl,
	%read_n(N),
	%nl,write("Pressione Enter para comecar o jogo!"),nl,readln(_),	
	N=4,                      				%numero de jogadores
	nb_setval(npl,N),					%cria variavel global com numero de jogadores
    	separate_deck(Deck,N,Decks),!,
	distribute_deck(Decks,N,Players,FirstNj),!,
	fresh_board(T),!,
	init_stat,!.

%end(Players)
%verifica se jogo acabou,nenhum jogador de Players com cartas em mao
end([j(_,[],_,_)]):-!.
end([j(_,[],_,_)|j(_,[])]):-!.
end([j(_,[],_,_)|RestOfPlayers]):-end(RestOfPlayers).

playFinalCard(Card,Board,Players,NJ,New_board,Players2,NJ2):-
	nb_getval(npl,V),NJt is NJ+1,(NJt>V,NJ2=1,!;NJ2=NJt),
    getPlayer(Players,j(N,Hand,Burry,P),NJ),
	play_card(Board,Card, New_board),
	delete(Hand, Card, New_hand),!,N=1,
	updateJ(Players,j(N,New_hand,Burry,P),Players2),!.

burryFinalCard(Card,Board,Players,NJ,Board,Players2,NJ2):-
	nb_getval(npl,V),NJt is NJ+1,(NJt>V,NJ2=1,!;NJ2=NJt),
	getPlayer(Players,j(N,Hand,Burry,P),NJ),
	insert(Card,Burry,New_Burry),
	Card=card(A de _),
	P2 is P+A,
	delete(Hand, Card, New_hand),update_stats(Board,NJ),!,N=1,
	updateJ(Players,j(N,New_hand,New_Burry,P2),Players2),!.

%play_round(Board,Players,N)
play_round(Board,Players,NJ,Board,Players,NJ,1,_):-end(Players),!.

%Human a jogar se N=1
play_round(Board,Players,1,New_board,Players2,NJ2,K,_):-
    nb_getval(npl,V),(2>V,NJ2=1,!;NJ2=2),
    getPlayer(Players,j(N,Hand,Burry,P),1),
    writeSeparator,
    show_burry(Burry),
    show_board(Board),
    avaibleCard(Hand,Board,LegalMoves),
    nl,show_hand(Hand,LegalMoves),
    	(
    	 possiblePlays(Board,Hand),!,		% Ha jogadas possíveis 
    	 write("Jogador 1 joga: (A de B)"),nl,
	 read_card(Card,Hand,Board),
    	 play_card(Board,Card, New_board),
         P2=P,					%pontos iguais
    	 delete(Hand, Card, New_hand),!,
    	 New_Burry=Burry % Não adiciona nenhum card
    	 ;	
    	 write("Não tens cartas para jogar no tabuleiro..."),nl, % NAO ha jogadas possíveis
    	 nl,write("Escolhe uma carta para dar burry: (A de B)"),nl,
    	 read_card_burry(card(A de B),Hand),Card=card(A de B),
    	 insert(card(A de B),Burry,New_Burry),
	 P2 is P+A,				%aumenta pontos
    	 delete(Hand, Card, New_hand),!,update_stats(Board,1),
    	 New_board=Board % Sem mudança, envia o mesmo board
    	),
    updateJ(Players,j(N,New_hand,New_Burry,P2),Players2),!,(end(Players2),K=1,!;K=0).	%faz update a lista de players

%Bot 2 e 3 se N=2 ou 3
play_round(Board,Players,NJ,New_board,Players2,NJ2,K,Cardf):-NJ<4,!,
    nb_getval(npl,V),NJt is NJ+1,(NJt>V,NJ2=1,!;NJ2=NJt),
    getPlayer(Players,j(N,Hand,Burry,P),NJ),
    avaibleCard(Hand,Board,L),
    %writeSeparator,%show_board(Board),show_hand(Hand,L),
    	(
	 possiblePlays(Board,Hand),!,	% Ha jogadas possíveis 
	 holes(Hand,L,Holes),		% cartas que precisam ser jogadas para jogares todas as tuas cartas
	 bestplay(L,Card,Holes,Hand,Burry),Cardf=Card,
	 %nl,write("Jogador "),write(N),write(" joga: "),Card=card(K),write(K),nl,
	 play_card(Board,Card, New_board),
	 P2=P,				%pontos iguais
	 delete(Hand, Card, New_hand),!,
	 New_Burry=Burry
	 ;
	 update_stats(Board,N),
	 deck(Dx),avaibleCard(Dx,Board,Lx),insertAll(Hand,Lx,Handx),insert0e14(Handx,Handx2),holes(Handx2,Lx,Holesxx),insertAll(Holesxx,Lx,Holesx),
	 bestburry(Hand, Card, Burry,Holesx),Card=card(A de B),Cardf=a,
	 %nl,write("Jogador "),write(N),write(" da burry a uma carta!"),nl,%write(Card),nl,
	 insert(card(A de B),Burry,New_Burry),
         P2 is P+A,			%aumenta pontos
 	 delete(Hand, Card, New_hand),!,
	 New_board=Board
     	),
    updateJ(Players,j(N,New_hand,New_Burry,P2),Players2),!,(end(Players2),K=1,!;K=0).	%faz update a lista de players

%Bot 4 se N=4
play_round(Board,Players,NJ,New_board,Players2,NJ2,K,Cardf):-
    nb_getval(npl,V),NJt is NJ+1,(NJt>V,NJ2=1,!;NJ2=NJt),
    getPlayer(Players,j(N,Hand,Burry,P),NJ),
    avaibleCard(Hand,Board,L),
    %writeSeparator,%show_board(Board),show_hand(Hand,L),
    	(
	 possiblePlays(Board,Hand),!,	% Ha jogadas possíveis 
	 holes(Hand,L,Holes),		% cartas que precisam ser jogadas para jogares todas as tuas cartas
	 bestplay2(L,Card,Holes,Hand,Burry),Cardf=Card,
	 %nl,write("Jogador "),write(N),write(" joga: "),Card=card(K),write(K),nl,
	 play_card(Board,Card, New_board),
	 P2=P,				%pontos iguais
	 delete(Hand, Card, New_hand),!,
	 New_Burry=Burry
	 ;
	 update_stats(Board,N),
	 bestburry2(Hand, Card, Burry),Card=card(A de B),Cardf=a,
	 %nl,write("Jogador "),write(N),write(" da burry a uma carta!"),nl,%write(Card),nl,
	 New_Burry=[card(A de B)|Burry],
         P2 is P+A,			%aumenta pontos
 	 delete(Hand, Card, New_hand),!,
	 New_board=Board
     	),
    updateJ(Players,j(N,New_hand,New_Burry,P2),Players2),!,(end(Players2),K=1,!;K=0) .	%faz update a lista de players

%insertAll(L,Lx,Lr)
%insere cartas de Lx em L e retorna o resultado em Lr
insertAll(H,[],H):-!.
insertAll(H,[C|L],Hx):-insertAll(H,L,Hxx),insert(C,Hxx,Hx).

%insert0e14(L,Lr)
%insere 0 e 14 de todos os naipes em L e retorn aresultado em Lr
insert0e14(H,Hx):-
	insert(card(0 de copas),H,H1),insert(card(0 de ouros),H1,H2),insert(card(0 de paus),H2,H3),insert(card(0 de espadas),H3,H4),
	insert(card(14 de copas),H4,H5),insert(card(14 de ouros),H5,H6),insert(card(14 de paus),H6,H7),insert(card(14 de espadas),H7,Hx),!.

%getPlayer(Players,JN,N)
%devolve o jogador N da lista de jogadores (Players), em JN
getPlayer((j(1,Hand,Burry,P)),j(1,Hand,Burry,P),1):-!.
getPlayer([(j(N,Hand,Burry,P))|L],Player,N2):-
	(N=N2,Player=(j(N,Hand,Burry,P)),!;getPlayer(L,Player,N2)).

%updateJ(P,N,Pr)
%faz update do jogador N, na lista P e retorna P atualizado em Pr
updateJ([],_,[]).
updateJ((j(N,_,_,_)),j(N,New_hand,New_burry,New_P),(j(N,New_hand,New_burry,New_P))):-!.
updateJ([(j(N,_,_,_))|L],j(N,New_hand,New_burry,New_P),[(j(N,New_hand,New_burry,New_P))|L]):-!.
updateJ([J|L],Js,[J|L2]):-updateJ(L,Js,L2).

%avaibleCard(H,B,L)
%retorna em L as cartas de H que podem ser jogadas no board B
avaibleCard([Card],Board,L):-
	(permitted_play(Card,Board),L=[Card],!
	;
	L=[]),!.
avaibleCard([Card|Cs],Board,L):-avaibleCard(Cs,Board,Ls),
	(permitted_play(Card,Board),L=[Card|Ls],!
	;
	L=Ls),!.

%possiblePlays(B,H)
%verifica se alguma carta em H pode ser jogada no tabuleiro B
possiblePlays(Board,Hand):-
	member(X,Hand),
	permitted_play(X,Board), !.

%holes(hand,permitted play,holes)
%holes tem cartas que faltam ser jogadas no tabuleiro que n tens na hand
holes([],_,[]).
holes([_],_,[]).
holes([card(A de B)|L2],[card(A de B)|L],R):-A<7,holes(L2,L,R),!.
holes([card(A1 de B),card(A2 de B)|L2],[card(A de B)|L],R):-
	(
	A=<7,A1<A,A2=<A,A1 is A2-1,holes([card(A2 de B)|L2],[card(A de B)|L],R),!
	;
	A=<7,A1<A,A2=<A,Ax is A1+1,holes([card(Ax de B),card(A2 de B)|L2],[card(A de B)|L],Rx),R=[card(Ax de B)|Rx],!
	;
	A1<A,A2>7,holes([card(A2 de B)|L2],[card(A de B)|L],R),!
	;
	A2 is A1+1,holes([card(A2 de B)|L2],[card(A de B)|L],R),!
	;
	Ax is A1+1,holes([card(Ax de B),card(A2 de B)|L2],[card(A de B)|L],Rx),R=[card(Ax de B)|Rx]	
	),!.
holes([card(_ de B)|L2],[card(_ de B)|L],R):-holes(L2,L,R),!.
holes([_|L2],L,R):-holes(L2,L,R).


/*** INPUT ***********************************************************************************************************************************/
legal_play_card(Card,Hand,Board):-member(Card, Hand),permitted_play(Card,Board).
legal_burry_card(Card,Hand):-member(Card, Hand).

%read_card(C,H,B)
%lê uma carta C do console e verifica se esta na mao H e pode ser jogada no tabulerio B
read_card(CardF,Hand,Board):-
	read_card_aux(Card),
	(Card=card([A,de,B|_]),translate(Cardxl,A de B),Cardx=card(Cardxl),member(Cardx, Hand),permitted_play(Cardx,Board),CardF=Cardx,!;
	writeln("Invalido."),read_card(CardF,Hand,Board)).

%read_card_burry(C,H)
%lê uma carta C e verifica se esta na mao H
read_card_burry(CardF, Hand):-
	read_card_aux(Card),
	(Card=card([A,de,B|_]),translate(Cardxl,A de B),Cardx=card(Cardxl),member(Cardx, Hand),CardF=Cardx,!;
	writeln("Invalido."),read_card_burry(CardF,Hand)).

%le carta
read_card_aux(card(Card)):-
    readln(Card). 

%read_n(N)
%le numero de jogadores N e verifica se e um numero
read_n(N):-
	read_n_aux(X),
	(X=[N|_],number(N),!;
	writeln("Invalido."),read_n(N) ).

%le numero de jogadores
read_n_aux(N):-
    readln(N). 
 
/*** OUTPUT **********************************************************************************************************************************/

%render das cartas na mao
show_hand(Hand,LegalMoves):-writeln("Cartas na mao:"),ww(Hand,LegalMoves),nl.

%render das cartas no board
show_board(B):-nl,writeln("Tabuleiro:"),show_board_aux(B).
show_board_aux([t(L,S)]):-write(S),write(": "),show_between_cards(L),nl,!.
show_board_aux([t(L,S)|T]):-write(S),write(": "),show_between_cards(L),nl,show_board_aux(T).

%auxiliar para mostrar cartas no board a partir das que podem ser jogadas
show_between_cards([7]):-write("").
show_between_cards([0]):-write("").
show_between_cards([]):-show_between_cards([0,14]),!.
show_between_cards([N]):-N>7,show_between_cards([0,N]),!.
show_between_cards([N]):-N<7,show_between_cards([N,14]),!.
show_between_cards([X,Y]):-X2 is X+1,Y2 is Y-1,show_between_cards_aux([X2,Y2]).
show_between_cards_aux([X,X]):-translate(X de _,Xk de _),write(Xk),!.
show_between_cards_aux([X,Y]):-not(X=Y),translate(X de _,Xk de _),write(Xk),write(" "),X2 is X+1,show_between_cards_aux([X2,Y]).

%Mostra as cartas no burry
show_burry(Burry):-
	nl, write("Burry: "),
	write_translated_burry(Burry),nl.

write_translated_burry([]).
write_translated_burry([card(B1)]):-
	translate(B1,T1),
	write(T1)	.
write_translated_burry([card(B1)|Burry]):-
	translate(B1,T1),
	write(T1), write(' | '),
	write_translated_burry(Burry).

%clear screen
clear :- write('\e[2J').

%escreve uma linha de asteriscos
writeSeparator:-
	nl,writeln("**********************************").

%escreve lista de cartas, e da highlight as que podem ser jogadas
ww([],_).
ww([X|L],LM):-(member(X,LM),X=card(Y),translate(Y,Yl),ansi_format([fg(cyan)],'~w',[Yl]),nl,!;X=card(Y),translate(Y,Yl),writeln(Yl)),ww(L,LM).

%print the order of winners (ranking)
show_ranking(Players2):-
	get_list_result(Players2,ListResult),
	msort(ListResult,ListRanking),
	print_ranking(ListRanking,1),nl.

rank(Players,Lrank):-
	get_list_result(Players,ListResult),
	msort(ListResult,Lrank).

print_ranking([],_):-!.
print_ranking([r(B,1)|Rest], N):-
	nl,ansi_format([fg(cyan)],'#~w Jogador: 1 -> ~w',[N,B]),
	N2 is N+1,
	print_ranking(Rest,N2),!.
print_ranking([r(B,Player)|Rest], N):-
	nl,write("#"),write(N),write(" Jogador: "),write(Player),write(" -> "),write(B),
	N2 is N+1,
	print_ranking(Rest,N2).

%ordena players por pontos
get_list_result([],[]).
get_list_result([j(N,_,_,P)|j(N1,_,_,P1)], [r(P,N),r(P1,N1)]):-!.
get_list_result(j(N,_,_,P), r(P,N)).
get_list_result([j(N,_,_,P)|RestOfPlayers],[r(P,N)|RestOfListResult]):-
	get_list_result(RestOfPlayers,RestOfListResult).

%printEnd
print_end(B):-writeSeparator,nl,write("O jogo acabou!"),nl,show_board(B).

%traduz simb para numero (e.g. A para 1)
translate(1 de S,X de S):- (X='A';X=a),!.
translate(11 de S,X de S):- (X='J';X=j),!.
translate(12 de S,X de S):- (X='Q';X=q),!.
translate(13 de S,X de S):- (X='K';X=k),!.
translate(X,X).

/*** IA **********************************************************************************************************************************/

%somatorio de A1 a B
sum(A, A, 0):-!.
sum(A1, B, Value):- A1 =< B, A2 is A1 + 1, sum(A2,B,Val1), Value is Val1 + A1.

%compara a carta1 da lista com a melhor carta e devolve a a que tiver maior value
betterof(Card1, Val1, _, Val2, Card1, Val1) :- Val1 >= Val2, !.
betterof(_, Val1, Card2, Val2, Card2, Val2) :- Val1 < Val2, !.

%lowerEnd(Hand, LE, A, B)
%LE e a carta mais baixa que A do naipe B que esta em Hand
lowerEnd([],A,A,_):-!.
lowerEnd([card(_ de Y)|L],LE,A,B) :- not(Y == B) , lowerEnd(L,LE,A,B),!.
lowerEnd([card(X de B)|L],LE,A,B) :- X >= A, lowerEnd(L,LE,A,B),!.
lowerEnd([card(X de B)|_],LE,A,B) :- X =< A, LE = X,!.

%highEnd(Hand, HE, A, B)
%HE e a carta mais alta que A do naipe B que esta em Hand
highEnd([],A,A1,_):- A is A1 + 1,!.
highEnd([card(_ de Y)|L],LE,A,B) :- not(Y == B) , highEnd(L,LE,A,B),!.
highEnd([card(X de B)|L],LE,A,B) :- X =< A, highEnd(L,LE,A,B),!.
highEnd([card(X de B),card(C de B)|L],LE,A,B) :- X >= A, highEnd([card(C de B)|L],LE,A,B),!.
highEnd([card(X de B)|_],LE,A,B) :- X >= A, LE is X+1,!.

%SumNaipe(Hand, B, S, SC)
%S sao os pontos das cartas em Hand do naipe B, e SC o numero de cartas
sumNaipe([],_,0,0):-!.
sumNaipe([card(A de B)|L],B,S,SC) :- sumNaipe(L,B,S1,SC1), S is S1 + A, SC is SC1 + 1,!.
sumNaipe([card(_ de C)|L],B,S,SC) :- not(C == B), sumNaipe(L,B,S,SC),!.

%SumNaipeL(Hand, B, S, SC,A)
%S sao os pontos das cartas em Hand do naipe B e abaixo de A, e SC o numero de cartas
sumNaipeL([],_,0,0,_):-!.
sumNaipeL([card(A de B)|L],B,S,SC,A2) :- A2 > A, sumNaipeL(L,B,S1,SC1,A2), S is S1 + A, SC is SC1 + 1,!.
sumNaipeL([card(A de B)|L],B,S,SC,A2) :- A2 =< A, sumNaipeL(L,B,S,SC,A2).
sumNaipeL([card(_ de C)|L],B,S,SC,A2) :- not(C == B), sumNaipeL(L,B,S,SC,A2),!.

%SumNaipeH(Hand, B, S, SC,A)
%S sao os pontos das cartas em Hand do naipe B e acima de A, e SC o numero de cartas
sumNaipeH([],_,0,0,_):-!.
sumNaipeH([card(A de B)|L],B,S,SC,A2) :- A2 < A, sumNaipeH(L,B,S1,SC1,A2), S is S1 + A, SC is SC1 + 1,!.
sumNaipeH([card(A de B)|L],B,S,SC,A2) :- A2 >= A, sumNaipeH(L,B,S,SC,A2).
sumNaipeH([card(_ de C)|L],B,S,SC,A2) :- not(C == B), sumNaipeH(L,B,S,SC,A2),!.

%getNaipe(C,L,Lr)
%dada uma lista de listas de cartas separadas por naipes L, Lr tem a lista do naipe da carta C
getNaipe(card(_ de copas),  [L1,_,_,_],L1):-!.
getNaipe(card(_ de espadas),[_,L2,_,_],L2):-!.
getNaipe(card(_ de ouros),  [_,_,L3,_],L3):-!.
getNaipe(card(_ de paus),   [_,_,_,L4],L4):-!.

%Hand - lista de cartas do jogador
%EHand - lista das cartas extremas de cada naipe do jogador
getHandExtremes(Hand,EHand):- handSuitSplit(Hand, SHand), extremeSuit(SHand, EHandC), flatten(EHandC,EHand1),list_to_set(EHand1,EHand). 

%handSuitSplit(Hand,SHand)
%Hand - lista de cartas do jogador
%EHand - lista de cartas do jogador dividas por naipe
handSuitSplit([],[[],[],[],[]]):-!.
handSuitSplit([card(A de copas)|L],[[card(A de copas)|Heart],Spades,Diamonds,Clubs]) :- handSuitSplit(L,[Heart,Spades,Diamonds,Clubs]),!.
handSuitSplit([card(A de espadas)|L],[Heart,[card(A de espadas)|Spades],Diamonds,Clubs]) :- handSuitSplit(L,[Heart,Spades,Diamonds,Clubs]),!.
handSuitSplit([card(A de ouros)|L],[Heart,Spades,[card(A de ouros)|Diamonds],Clubs]) :- handSuitSplit(L,[Heart,Spades,Diamonds,Clubs]),!.
handSuitSplit([card(A de paus)|L],[Heart,Spades,Diamonds,[card(A de paus)|Clubs]]) :- handSuitSplit(L,[Heart,Spades,Diamonds,Clubs]),!.

%extremeSuit(EHand,EHandC)
%EHand - lista de cartas do jogador dividas por naipe
%EHandC - lista de pares carta extrema do jogador dividas por naipe
extremeSuit([Heart,Spades,Diamonds,Clubs],[A,B,C,D]) :-	
	(last(Heart,A2),A2=card(A2x de _),first(Heart,A1),A1=card(A1x de _),(A1x=A2x,A=[A1,A2];A1x=<7,A2x>=7,A = [A1,A2];A1x=<7,A=[A1];A=[A2]);A = []),
	(last(Spades,B2),B2=card(B2x de _),first(Spades,B1),B1=card(B1x de _),(B1x=B2x,B=[B1,B2];B1x=<7,B2x>=7,B = [B1,B2];B1x=<7,B=[B1];B=[B2]);B = []),
	(last(Diamonds,C2),C2=card(C2x de _),first(Diamonds,C1),C1=card(C1x de _),(C1x=C2x,C=[C1,C2];C1x=<7,C2x>=7,C = [C1,C2];C1x=<7,C=[C1];C=[C2]);C = []),
	(last(Clubs,D2),D2=card(D2x de _),first(Clubs,D1),D1=card(D1x de _),(D1x=D2x,D=[D1,D2];D1x=<7,D2x>=7,D = [D1,D2];D1x=<7,D=[D1];D=[D2]);D = []), !.

%funcao auxliar para tirar a primeiro da lista	
first([X|_],X).

/*** IA1 **********************************************************************************************************************************/

%equacao que calcula o Value, parametros explicados no utility bom
funcaoPlay(S,NH,NB,X):-X is ( (S*NH*20) * (( (NB/(NH+10))^10 ) +10) ).

%equacao que calcula o value para o burry,parametros explicados no burry_utility
funcaoBurry(X,Y,Z,W,Value):-X1 is ((W+10)*20)/(Z+10),Value is (((X1+10)*(Y+10)^20/(Y+10))^10*20*(Y+10)/(X+10)).

%utility_Mau(C, Value, Hand, Burried)
%Value tem o valor da carta C
%maior valor se impossibilitar os outros jogadores de jogar
utility_Mau(card(13 de _), 12, _, _).
utility_Mau(card(1 de _), 12, _, _).
utility_Mau(card(A de B), 12, Hand, Burried) :- 
	A < 7,
	A1 is A-1, 
	(member(card(A1 de B), Hand);member(card(A1 de B), Burried)),!.
utility_Mau(card(A de B), 12, Hand, Burried) :- 
	A > 7,
	A1 is A+1, 
	(member(card(A1 de B), Hand);member(card(A1 de B), Burried)),!.
utility_Mau(card(2 de _), 11, _, _).
utility_Mau(card(3 de _), 10, _, _).
utility_Mau(card(4 de _), 9, _, _).
utility_Mau(card(5 de _), 8, _, _).
utility_Mau(card(6 de _), 7, _, _).
utility_Mau(card(12 de _), 6, _, _).
utility_Mau(card(11 de _), 5, _, _).
utility_Mau(card(10 de _), 4, _, _).
utility_Mau(card(9 de _), 3, _, _).
utility_Mau(card(8 de _), 2, _, _).
utility_Mau(card(7 de _), 1, _, _).

%utility_Bom(C, Value, Hand, Burried)
%Value tem o valor da carta C
%Valor calculado pela funcaoPlay em que:
%S e numero de pontos de cartas dependentes de C que tem na mao
%NH e o numero de cartas que faltam jogar que nao tem na mao
%NB e o numero total de cartas que ja foram burryed
utility_Bom(card(A de B), X, Hand) :- 
	A == 7, 
	getHandExtremes(Hand, EHand), 
	lowerEnd(EHand,LE,A,B), highEnd(EHand,HE,A,B), 
	sum(LE,HE,S1), 
	sumNaipe(Hand,B,S,SC),               				
	NH is ((HE - LE - 1) - SC),							
	nb_getval(nby,NB),									
	((S1 == S,X = 0);(S1 > S,funcaoPlay(S,NH,NB,X))),!.	
	
utility_Bom(card(A de B), X, Hand) :- 
	A > 7, 
	getHandExtremes(Hand, EHand), 
	highEnd(EHand,HE,A,B), 	
	sum(A,HE,S1), 
	sumNaipeH(Hand,B,S,SC,A),               				
	NH is ((HE - A - 1) - SC),							
	nb_getval(nby,NB),									
	((S1 == S,X = 0);(S1 > S,funcaoPlay(S,NH,NB,X))),!.	
	
utility_Bom(card(A de B), X, Hand) :- 
	A < 7, 
	A1 is A + 1,
	getHandExtremes(Hand, EHand), 
	lowerEnd(EHand,LE,A,B),
	sum(LE,A1,S1), 
	sumNaipeL(Hand,B,S,SC,A),               				
	NH is ((A-LE) - SC),								
	nb_getval(nby,NB),								
	((S1 == S,X = 0);(S1 > S,funcaoPlay(S,NH,NB,X))),!.	

%bestplay(PossiblePlays, C, Holes, Hand, Burried)
%retorna C, carta em PossiblePlays com value mais alto
%caso holes esteja vazio joga para impossibilitar jogadas dos outros jogadores
%caso contrario utiliza funcaoPlay
bestplay(PossiblePlays, Card, [], Hand, Burried) :- bestplay_Mau(PossiblePlays, Card, _, Hand, Burried),!.
bestplay(PossiblePlays, Card, _, Hand, _) :- bestplay_Bom(PossiblePlays, Card, _, Hand).%,nl,write(Card),nl,write(Val),nl.

%bestplay_Mau(PossiblePlays, Card, Value, Holes, Hand)
%retorna C, carta em PossiblePlays com value mais alto
%escolhe carta que impossibilita mais os outros jogadores de jogar
bestplay_Mau([Card], Card, Val, Hand, Burried) :-
	utility_Mau(Card, Val, Hand, Burried), !.
	
bestplay_Mau([Card1 | L], BestCard, BestVal, Hand, Burried):-
	utility_Mau(Card1, Val1, Hand, Burried),
	bestplay_Mau(L, Card2, Val2, Hand, Burried),
	betterof(Card1, Val1, Card2, Val2, BestCard, BestVal).

%bestplay_Bom(PossiblePlays, Card, Holes, Hand, Value)
%retorna C, carta em PossiblePlays com value mais alto
%escolhe carta a partir da funcaoPlay
bestplay_Bom([Card], Card, Val, Hand) :-
	utility_Bom(Card, Val, Hand), !.
	
bestplay_Bom([Card1 | L], BestCard, BestVal, Hand):-
	utility_Bom(Card1, Val1, Hand),
	bestplay_Bom(L, Card2, Val2, Hand),
	betterof(Card1, Val1, Card2, Val2, BestCard, BestVal).

%adiciona ao value um X consoante a probabilidade da a carta ja n estar na mao de nenhum jogador
burry_utilityX(X,V,B,Holes,H):-bcheck(X,_,_,R),burry_utility(X,Vx,B,Holes,H),V is R*2000+Vx.

%burry_utility(C, Value, Burried, Holes, Hand)
%Value tem o valor da carta C
%Valor calculado pela funcaoBurry em que:
%X e numero de cartas que tem de ser jogadas para C ser jogado que estao na mao
%Y e numero de cartas que tem de ser jogadas para C ser jogado que nao estao na mao
%Z pontos dependentes de C que os outros jogadores teriam de baixar
%W pontos da carta
burry_utility(card(A de B), Value, Burried,Holes,H) :- 
	getPb(card(A de B),Holes,Y,_),
	getPb2(A,Wx),
	getPb(card(A de B),Burried,_,Zx),
	Z is A,W is Wx-Zx,W>=0,
	getPb(card(A de B),H,X,_),
	funcaoBurry(X,Y,Z,W,Value),!.

%calcula pontos </> que A
getPb2(A,W):-A<7,sum(1,A,W).
getPb2(A,W):-A>7,Ax is A+1,sum(Ax,14,W).

%getPb(C,L,N,S)
%calcula soma (S) de carta </> (consoante C) que 7 que pertencem a L, e numero de cartas (N)
getPb(_,[],0,0):-!.
getPb(card(A de B),[card(A2 de _)|L],Y,W):-
	(
	A<7,A2>7,Y=0,W=0,!;
	A<7,getPb(card(A de B),L,Yx,Wx),Y is Yx+1,W is Wx+A2,!;
	A2<7,getPb(card(A de B),L,Y,W),!;
	getPb(card(A de B),L,Yx,Wx),Y is Yx+1,W is Wx+A2,!
	).

%bestburry(Hand, bestcard, Burried, Holes)
%prepara argumentos para bestburry_aux que ve qual a melhor carta para fazer burry
bestburry(Hand, Card,Burried,Holes) :- getHandExtremes(Hand, EHand),
	handSuitSplit(Holes,HolesSpli),handSuitSplit(Hand,HandSpli),handSuitSplit(Burried,BurriedSpli),
	bestburry_aux(EHand, Card, _, BurriedSpli,HolesSpli,HandSpli).%,nl,write(Card),nl,write(Val),nl,!.

%bestburry_aux(Hand, bestcard, value, Burried, Holes, H)
%retorna C, carta em Hand com value mais alto
%escolhe carta a partir da funcaoBurry
bestburry_aux([Card], Card, Val, Burried,Holes,H):-
	getNaipe(Card,Holes,HolesX),getNaipe(Card,H,Hx),getNaipe(Card,Burried,Burriedx),
	burry_utilityX(Card, Val, Burriedx,HolesX,Hx), !.
	
bestburry_aux([Card1 | L], BestCard, BestVal, Burried,Holes,H):-
	getNaipe(Card1,Holes,HolesX),getNaipe(Card1,H,Hx),getNaipe(Card1,Burried,Burriedx),
	burry_utilityX(Card1, Val1, Burriedx,HolesX,Hx),
	bestburry_aux(L, Card2, Val2, Burried,Holes,H),
	betterof(Card1, Val1, Card2, Val2, BestCard, BestVal).

/*** IA2 **********************************************************************************************************************************/

%equacao que calcula o Value, parametros explicados no utility bom
funcaoPlay2(S,NH,NB,X):-X is ( (S*NH*2) * (( (NB/(NH+0.8))^2 ) +0.6) ).

%utility_Mau2(C, Value, Hand, Burried)
%Value tem o valor da carta C
%maior valor se impossibilitar os outros jogadores de jogar
utility_Mau2(card(13 de _), 12, _, _).
utility_Mau2(card(1 de _), 12, _, _).
utility_Mau2(card(A de B), 12, Hand, Burried) :- 
	A < 7,
	A1 is A-1, 
	(member(card(A1 de B), Hand);member(card(A1 de B), Burried)),!.	
utility_Mau2(card(A de B), 12, Hand, Burried) :- 
	A > 7,
	A1 is A+1, 
	(member(card(A1 de B), Hand);member(card(A1 de B), Burried)),!.
utility_Mau2(card(2 de _), 11, _, _).
utility_Mau2(card(3 de _), 10, _, _).
utility_Mau2(card(4 de _), 9, _, _).
utility_Mau2(card(5 de _), 8, _, _).
utility_Mau2(card(6 de _), 7, _, _).
utility_Mau2(card(12 de _), 6, _, _).
utility_Mau2(card(11 de _), 5, _, _).
utility_Mau2(card(10 de _), 4, _, _).
utility_Mau2(card(9 de _), 3, _, _).
utility_Mau2(card(8 de _), 2, _, _).
utility_Mau2(card(7 de _), 1, _, _).

%utility_Bom2(C, Value, Hand, Burried)
%Value tem o valor da carta C
%Valor calculado pela funcaoPlay em que:
%S e numero de pontos de cartas dependentes de C que tem na mao
%NH e o numero de cartas que faltam jogar que nao tem na mao
%NB e o numero total de cartas que ja foram burryed
utility_Bom2(card(A de B), X, Hand) :- 
	A == 7, 
	getHandExtremes(Hand, EHand), 
	lowerEnd(EHand,LE,A,B), highEnd(EHand,HE,A,B), 
	sum(LE,HE,S1), 
	sumNaipe(Hand,B,S,SC),               				%S 	e o x da equacao
	NH is ((HE - LE - 1) - SC),							%NH e o y da equacao
	nb_getval(nby,NB),									%NB e o z da equacao
	((S1 == S,X = 0);(S1 > S,funcaoPlay2(S,NH,NB,X))),!.	
	
utility_Bom2(card(A de B), X, Hand) :- 
	A > 7, 
	getHandExtremes(Hand, EHand), 
	highEnd(EHand,HE,A,B), 	
	sum(A,HE,S1), 
	sumNaipeH(Hand,B,S,SC,A),               				%S 	e o x da equacao
	NH is ((HE - A - 1) - SC),							%NH e o y da equacao
	nb_getval(nby,NB),									%NB e o z da equacao
	((S1 == S,X = 0);(S1 > S,funcaoPlay2(S,NH,NB,X))),!.	
	
utility_Bom2(card(A de B), X, Hand) :- 
	A < 7, 
	A1 is A + 1,
	getHandExtremes(Hand, EHand), 
	lowerEnd(EHand,LE,A,B),
	sum(LE,A1,S1), 
	sumNaipeL(Hand,B,S,SC,A),               				%S 	e o x da equacao
	NH is ((A-LE) - SC),								%NH e o y da equacao
	nb_getval(nby,NB),									%NB e o z da equacao
	((S1 == S,X = 0);(S1 > S,funcaoPlay2(S,NH,NB,X))),!.	
	
%bestplay2(PossiblePlays, C, Holes, Hand, Burried)
%retorna C, carta em PossiblePlays com value mais alto
%caso holes esteja vazio joga para impossibilitar jogadas dos outros jogadores
%caso contrario utiliza funcaoPlay
bestplay2(PossiblePlays, Card, [], Hand, Burried) :- bestplay_Mau2(PossiblePlays, Card, _, Hand, Burried),!.
bestplay2(PossiblePlays, Card, _, Hand, _) :- bestplay_Bom2(PossiblePlays, Card, _, Hand).

%bestplay_Mau2(PossiblePlays, Card, Value, Holes, Hand)
%retorna C, carta em PossiblePlays com value mais alto
%escolhe carta que impossibilita mais os outros jogadores de jogar
bestplay_Mau2([Card], Card, Val, Hand, Burried) :-
	utility_Mau2(Card, Val, Hand, Burried), !.
	
bestplay_Mau2([Card1 | L], BestCard, BestVal, Hand, Burried):-
	utility_Mau2(Card1, Val1, Hand, Burried),
	bestplay_Mau2(L, Card2, Val2, Hand, Burried),
	betterof(Card1, Val1, Card2, Val2, BestCard, BestVal).

%bestplay_Bom2(PossiblePlays, Card, Holes, Hand, Value)
%retorna C, carta em PossiblePlays com value mais alto
%escolhe carta a partir da funcaoPlay
bestplay_Bom2([Card], Card, Val, Hand) :-
	utility_Bom2(Card, Val, Hand), !.
	
bestplay_Bom2([Card1 | L], BestCard, BestVal, Hand):-
	utility_Bom2(Card1, Val1, Hand),
	bestplay_Bom2(L, Card2, Val2, Hand),
	betterof(Card1, Val1, Card2, Val2, BestCard, BestVal).
	
%adiciona ao value um X consoante a probabilidade da a carta ja n estar na mao de nenhum jogador
burry_utilityX2(X,V,B):-bcheck(X,_,_,R),burry_utility2(X,Vx,B),V is R*2000+Vx.

%burry_utility2(C,V,B)
%retorna o valor da carta C em V
burry_utility2(card(1 de _), -1, _):-!.
burry_utility2(card(13 de _), -13, _):-!.
burry_utility2(card(A de B), Value, Burried) :- 
	A > 7,
	sum_aux2(A, 14, Value2),
	minusBurried1(card(A de B), Value2, Burried, Value),!.	
burry_utility2(card(A de B), Value, Burried) :- 
	A < 7,
	sum(1, A, Value2),
	minusBurried2(card(A de B), Value2, Burried, Value),!.

%soma pontos das cartas de A1 a B e retorna o resultado em Value
sum_aux2(A1, B, Value) :- A2 is A1 + 1, sum(A2,B,Value).

%minusBurried(Card, V, B, V2)
%para cada cada carta X em B do mesmo naipe que A, multiplica V por const e divide por X*const, recursivamente ate nao ter mais cartas do mesmo naipe em B
minusBurried1(_,Value,[],Value):-!.
minusBurried1(card(A de B), Value, [card(C de B)|L], Value2):- A < C, Value3 is Value*11 / (C*1.7+1), minusBurried1(card(A de B), Value3, L, Value2),!.
minusBurried1(card(A de B), Value, [card(C de D)|L], Value2):- (not(B == D);A > C), minusBurried1(card(A de B), Value, L, Value2),!.

minusBurried2(_,Value,[],Value):-!.
minusBurried2(card(A de B), Value, [card(C de B)|L], Value2):- A > C, Value3 is Value*11 / (C*1.7+1), minusBurried2(card(A de B), Value3, L, Value2),!.
minusBurried2(card(A de B), Value, [card(C de D)|L], Value2):- (not(B == D);A < C), minusBurried2(card(A de B), Value, L, Value2),!.

%bestburry2(Hand, bestcard, Burried, Holes)
%prepara argumentos para bestburry_aux2 que ve qual a melhor carta para fazer burry
bestburry2(Hand, Card,Burried) :- getHandExtremes(Hand, EHand), bestburry_aux2(EHand, Card, _, Burried),!.

%bestburry_aux2(Hand, bestcard, value, Burried, Holes, H)
%retorna C, carta em Hand com value mais alto
%escolhe carta a partir da funcaoBurry
bestburry_aux2([Card], Card, Val, Burried):-
	burry_utilityX2(Card, Val, Burried), !.	
bestburry_aux2([Card1 | L], BestCard, BestVal, Burried):-
	burry_utilityX2(Card1, Val1, Burried),
	bestburry_aux2(L, Card2, Val2, Burried),
	betterof(Card1, Val1, Card2, Val2, BestCard, BestVal).





/******Some debug rules******************/

%(Hand=[],play_round(Board,Players,NJ2),!;	%pq no inicio os jogadores podem nao ter as mesmo n de cartas

ww2([]).
ww2([X|L]):-show_hand(X,[]),ww2(L).

a:- deck(D),shuffle(D,Ds),separate_deck(Ds,4,Dl),ww2(Dl).
b(0):-!.
b(N):-play,Nx is N-1,b(Nx).

suml([],0).
suml([r(B,_)|Rest], N):-suml(Rest,Nx),N is Nx+B,!.
