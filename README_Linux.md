# Sevens-card-game
Sevens card game written in prolog with IA and a java swing UI

Requirements:
------------------------------------------------------------------
. java version 9: "sudo apt-get install oracle-java9-installer" <br />
. swipl: "sudo apt-get install swi-prolog"<br />
. jpl: "sudo apt-get install swi-prolog-java"<br />
(to remove previous versions of java: "sudo apt-get remove java*")



Sevens_alpha.zip should contain:
------------------------------------------------------------------
. Sevens_alpha.jar	(the game jar executable file)<br />
. run.sh			(executable with the environment configurations)<br />
. Sevens.pl			(the prolog source code for the game)<br />
. README.md			(this file)<br />
. Relatório - Final.pdf	(report of the game Sevens)<br />
. demo.mkv			(gameplay video)<br />



Intructions for running the game:
------------------------------------------------------------------
. unzip the file Sevens_alpha.zip<br />
. open a terminal in the folder<br />
. execute: ./run.sh<br />



Some description about the game:
------------------------------------------------------------------
 Rules:<br />
  . The objective of the game is to end with the lesser points burried<br />
	. The points are given from the cards as A->1p,2->2p,...,K->13p<br />
	. A burried card is a card that you put down when you dont have possible moves<br />
	. The person who starts is the one with the 7 de espadas and has to play this card<br />
	. A playable card is a seven or a card immiddiate bellow or above a card in the board,of the same naipe <br />
	. In each round, if you hava a playable card, you have to play a card in the board<br />
	. If you do not have a playable card you have to burry a card, and the card is no longer playable in the board<br />
	. The game ends when no one have more cards in the hand

Explanation about the game ui:
------------------------------------------------------------------
  . On the left pannel will appear the previous plays.<br />
	. On the middle pannel will be the board<br />
	. On the right pannel will be the cards you have in the hand<br />
	. To start a game you have to click in the button "Novo jogo"<br />
	. To play/burry a card you click the card you want and then in the button "Jogar carta"<br />
	. The cards current in the hand will be the ones in white or green<br />
	. The cards playable will be in green<br />
	. The cards played will be in gray<br />
	. The cards Burried will be in red<br />
	. At the end the rank will appear in the left pannel

Afonso das Neves Fernandes 	(afonsofernandes@netcabo.pt)<br />
Daniel Zheng Dong		(daniel.zheng.dong@gmail.com)<br />
Rodrigo de Farias Giglio	(rodrigofgiglio@gmail.com)<br />
January 2018
