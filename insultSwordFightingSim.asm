;Clint Gundersen
;Final project
;An LC3 implementation of the Insult Sword Fighting
;from the LucasArts classic Game, The Secret of Monkey Island
;

						.ORIG x3000
;===============================================================================
;Call subroutine to initialize scores
FIGHT1			JSR					INIT

;Fight stinking pirate
						LD					R0, PGREET1 			;print pirate greeting
						PUTS

						JSR					GUYBRUSH					;print Guybrush greeting

						LD					R0, PIRATE1				;pirate attacks
						PUTS
						LD					R0,	INSULT11
						PUTS

						JSR					COMEBACK					;counterattack
						ADD					R3, R3, #5				;store correct answer in R3

						JSR					USERIN						;get selection from the user
						JSR					COMPARE

						BRz					FIGHT2						;if 0 move on to next fight
						LD					R0, GB						;otherwise we lose
						PUTS
						LD					R0, LOSE1
						PUTS

						JSR					RETRY							;check if player wants to try again

;fight bloodthirsty pirate
FIGHT2			JSR					INIT
						LD					R0, WIN
						PUTS

						LD					R0, PGREET2				;print pirate greeting
						PUTS

						JSR					GUYBRUSH					;print guybrush greeting

						LD					R0, PIRATE2				;pirate attacks
						PUTS
						LD					R0, INSULT12
						PUTS

						JSR					COMEBACK					;counterattack
						ADD					R3, R3, #2
						JSR					USERIN
						JSR					COMPARE

						BRz					FIGHT3						;if 0 move on to next fight
						LD					R0, GB						;otherwise we lose
						PUTS
						LD					R0, LOSE2
						PUTS

						JSR					RETRY							;check if player wants to try again

;fight ugly pirate
FIGHT3			JSR					INIT
						LD					R0, WIN
						PUTS

						LD					R0, PGREET3				;print pirate greeting
						PUTS

						JSR					GUYBRUSH					;print guybrush greeting

						LD					R0, PIRATE3				;pirate attacks
						PUTS
						LD					R0, INSULT4
						PUTS

						JSR					COMEBACK					;counterattack
						ADD					R3, R3, #4

						JSR					USERIN
						JSR					COMPARE

						BRz					FIGHT4						;if 0 move on to next fight
						LD					R0, GB						;otherwise we lose
						PUTS
						LD					R0, LOSE3
						PUTS

						JSR					RETRY							;check if player wants to try again

;fight dirty rotten pirate
FIGHT4			JSR					INIT
						LD					R0, WIN
						PUTS

						LD					R0, PGREET4				;print pirate greeting
						PUTS

						JSR					GUYBRUSH					;print guybrush greeting

						LD					R0, PIRATE4				;pirate attacks
						PUTS
						LD					R0, INSULT3
						PUTS
						JSR					COMEBACK					;counterattack

						ADD					R3, R3, #3
						JSR					USERIN
						JSR					COMPARE

						BRz					FIGHTSM						;if 0 move on to next fight
						LD					R0, GB						;otherwise we lose
						PUTS
						LD					R0, LOSE3
						PUTS

						JSR					RETRY							;check if player wants to try again

;fight carla the swordmaster
FIGHTSM			JSR					INIT
						LD					R0, WINSM
						PUTS

						LD					R0, SMGREET				;print sword master greeting
						PUTS

						JSR					GUYBRUSH					;print guybrush greeting

						LD					R0, SM						;sm attacks
						PUTS
						LD					R0, SMINSULT1
						PUTS

						JSR					COMEBACK
						ADD					R3, R3, #3
						JSR					USERIN
						JSR					COMPARE

						BRz					SM2								;if 0 move on to next fight
						LD					R0, GB						;otherwise we lose
						PUTS
						LD					R0, LOSE4
						PUTS

						JSR					RETRY							;check if player wants to try again

SM2					JSR					INIT

						LD					R0, SM						;sm attacks
						PUTS
						LD					R0, SMINSULT2
						PUTS

						JSR					COMEBACK
						ADD					R3, R3, #2
						JSR					USERIN
						JSR					COMPARE

						BRz					SM3 							;if 0 move on to next fight
						LD					R0, GB						;otherwise we lose
						PUTS
						LD					R0, LOSE4
						PUTS

						JSR					RETRY							;check if player wants to try again

SM3					JSR					INIT

						LD					R0, SM						;sm attacks
						PUTS
						LD					R0, SMINSULT3
						PUTS

						JSR					COMEBACK
						ADD					R3, R3, #6
						JSR					USERIN
						JSR					COMPARE

						BRz					FINALWIN					;if 0 move on to next fight
						LD					R0, GB						;otherwise we lose
						PUTS
						LD					R0, LOSE4
						PUTS

						JSR					RETRY							;check if player wants to try again

FINALWIN		LD					R0, WINEND				;print ending message
						PUTS

FIN					HALT
;===============================================================================
;subroutine to initialize score registers
INIT				AND					R1, R1, #0
						AND					R2, R2, #0
						AND					R3, R3, #0				;R3 will hold the value of the correct answer
						RET

;subroutine to print guybrush greeting
GUYBRUSH		LD					R0, GGREET
						AND					R6, R6, #0				;hold address for RET
						ADD					R6, R6, R7
						PUTS
						AND					R7, R7, #0				;put address back
						ADD					R7, R6, R7
						RET

;subroutine to print prompt and get user input
USERIN			LD					R0, PROMPT
						AND					R6, R6, #0
						ADD					R6, R6, R7
						PUTS
						IN
						AND					R7, R7, #0
						ADD					R7, R6, R7
						RET

;subroutine to compare user choice to correct choice
COMPARE			NOT					R3, R3							;switch to negative
						ADD					R3, R3, #1					;add 1
						LD					R4, XTHIRTY
						NOT					R4, R4
						ADD					R4, R4, #1

						ADD					R0, R0, R4					;switch from char to num
						ADD					R3, R3, R0
						RET

;subroutine to ask if player wants to try again, if so loop to begin
RETRY				LD					R0, LSTITLE					;tell player they lost
						PUTS
						LD					R0, TRY							;print try again message
						PUTS
						IN

						LD					R4, YCHAR						;load a 'y' to compare against
						AND					R3, R3, #0
						ADD					R3, R3, R4
						NOT					R3, R3							;switch to negative
						ADD					R3, R3, #1					;add 1
						ADD					R3, R3, R0

						BRz					FIGHT1							;if input is 'y' restart
						LD					R0, GOODBYE
						PUTS
						LEA					R1,	FIN
						JMP					R1
;subroutine to print the list of comebacks
COMEBACK		AND					R6, R6, #0					;hold address for ret
						ADD					R6, R6, R7

						LD					R0, PROMPT				;prompt
						PUTS

						LD					R0, ONE
						PUTS
						LD					R0, CB1
						PUTS
						LD					R0, TWO
						PUTS
						LD					R0, CB12
						PUTS
						LD					R0, THREE
						PUTS
						LD					R0, CB3
						PUTS
						LD					R0, FOUR
						PUTS
						LD					R0, CB4
						PUTS
						LD					R0, FIVE
						PUTS
						LD					R0, CB11
						PUTS
						LD					R0, SIX
						PUTS
						LD					R0, CB9
						PUTS

						AND					R7, R7, #0				;put address back
						ADD					R7, R6, R7

						RET

;===============================================================================
;get pointers to all of our strings
XTHIRTY			.FILL				x30
YCHAR 			.FILL				X0079

PIRATE1			.FILL				SPIRATE1
PIRATE2			.FILL				SPIRATE2
PIRATE3			.FILL				SPIRATE3
PIRATE4			.FILL				SPIRATE4
SM					.FILL				SSM
GB					.FILL				SGB

GGREET			.FILL				SGGREET
PGREET1			.FILL				SPGREET1
PGREET2			.FILL				SPGREET2
PGREET3			.FILL				SPGREET3
PGREET4			.FILL				SPGREET4
SMGREET			.FILL				SSMGREET

INSULT11		.FILL				SINSULT11
INSULT12		.FILL				SINSULT12
INSULT3			.FILL				SINSULT3
INSULT4			.FILL				SINSULT4
SMINSULT1		.FILL				SSMINSULT1
SMINSULT2		.FILL				SSMINSULT2
SMINSULT3		.FILL				SSMINSULT3

CB1					.FILL				SCB1
CB2					.FILL				SCB2
CB3					.FILL				SCB3
CB4					.FILL				SCB4
CB5					.FILL				SCB5
CB6					.FILL				SCB6
CB7					.FILL				SCB7
CB8					.FILL				SCB8
CB9					.FILL				SCB9
CB10				.FILL				SCB10
CB11				.FILL				SCB11
CB12				.FILL				SCB12
CB13				.FILL				SCB13
CB14				.FILL				SCB14
CB15				.FILL				SCB15
CB16				.FILL				SCB16

BASICCB1		.FILL				SBASICCB1
BASICCB2		.FILL				SBASICCB2
BASICCB3		.FILL				SBASICCB3

PROMPT			.FILL				SPROMPT
TRY					.FILL				STRY
GOODBYE			.FILL				SGOODBYE
ONE					.FILL				SONE
TWO					.FILL				STWO
THREE				.FILL				STHREE
FOUR				.FILL				SFOUR
FIVE				.FILL				SFIVE
SIX					.FILL				SSIX

LOSE1				.FILL				SLOSE1
LOSE2				.FILL				SLOSE2
LOSE3				.FILL				SLOSE3
LOSE4				.FILL				SLOSE4
LSTITLE			.FILL				SLSTITLE

WIN					.FILL				SWIN
WINSM				.FILL				SWINSM
WINEND			.FILL				SWINEND
;===============================================================================

;options
SPROMPT			.STRINGZ		"\nSelect your comeback.\n"
SONE				.STRINGZ		"1.  "
STWO				.STRINGZ		"2.  "
STHREE			.STRINGZ		"3.  "
SFOUR				.STRINGZ		"4.  "
SFIVE				.STRINGZ		"5.  "
SSIX				.STRINGZ		"6.  "
STRY				.STRINGZ		"\n\nTry again?  'y' to continue...\n"
SGOODBYE		.STRINGZ		"Thanks for playing.  Try the real Monkey Island, it's more fun."
SWIN				.STRINGZ		"\n\n\nYou are victorious!  But Melee Island holds other foes!\n"
SWINSM			.STRINGZ		"\n\n\nYou have defeated many pirates, now you have earned the right to face the legendary Sword Master in combat.\n"
SWINEND			.STRINGZ		"\n\n\nYou have defeated the Sword Master.\nYou have been awarded with a 100% cotton T-shirt which states: \n\t\t'I defeated the swordmaster.'\n\n\t\t\tYou Win!  Game Over"
;===============================================================================
;pirate names
SPIRATE1		.STRINGZ		"\nStinking Pirate:  "
SPIRATE2		.STRINGZ		"\nUgly Pirate:  "
SPIRATE3		.STRINGZ		"\nBloodthirsty Pirate:  "
SPIRATE4		.STRINGZ		"\nDirty Rotten Pirate:  "
SSM					.STRINGZ		"\nCarla:  "
SGB					.STRINGZ		"\nGuybrush:  "

;pirate greetings
SPGREET1		.STRINGZ		"\n\n\nStinking Pirate:  Stoppin a pirate can be dangerous to your health.\n"
SPGREET2		.STRINGZ		"\nUgly Pirate:  Move outa my way or I cuts my way through.\n"
SPGREET3		.STRINGZ		"\nBloodthirsty Pirate:  Aye, this better be important.\n"
SPGREET4		.STRINGZ		"\nDirty Rotten Pirate:  What are ya wantin ya scurvy lubber?\n"

;Guybrush Threepwood greeting
SGGREET			.STRINGZ		"Guybrush:  My name is Guybrush Threepwood.  Prepare to die!\n"

;Sword Master greeting
SSMGREET		.STRINGZ		"\nCarla:  How dare you approach The Sword Master without permission,\n\twhich I surely didnt give you.\n"

;"basic" comebacks
SBASICCB1		.STRINGZ		"I am rubber you are glue.\n"
SBASICCB2		.STRINGZ		"I am shaking.  I am shaking.\n"
SBASICCB3		.STRINGZ		"Oh yeah?\n"

;losing comments from Gubrush
SLOSE1			.STRINGZ		"Yikes nice moves.\n"
SLOSE2			.STRINGZ		"I give up!  You win!\n"
SLOSE3			.STRINGZ		"Where did my sword go?\n"
SLOSE4			.STRINGZ		"Look behind you!  A three headed monkey!\n"
SLSTITLE		.STRINGZ		"You have been defeated in combat.\n"

;insult/comback pairs
SINSULT1		.STRINGZ		"This is the END for you, you gutter-crawling cur!\n"
SCB1				.STRINGZ		"And I've got a little TIP for you, get the POINT?\n"

SINSULT2		.STRINGZ		"Soon you'll be wearing my sword like a shish kebab!\n"
SCB2				.STRINGZ		"First you better stop waiving it like a feather-duster.\n"

SINSULT3		.STRINGZ		"My handkerchief will wipe up your blood!\n"
SCB3				.STRINGZ		"So you got that job as janitor, after all.\n"

SINSULT4		.STRINGZ		"People fall at my feet when they see me coming.\n"
SCB4				.STRINGZ		"Even BEFORE they smell your breath?\n"

SINSULT5		.STRINGZ		"I once owned a dog that was smarter then you.\n"
SCB5				.STRINGZ		"He must have taught you everything you know.\n"

SINSULT6		.STRINGZ		"You make me want to puke.\n"
SCB6				.STRINGZ		"You make me think somebody already did.\n"

SINSULT7		.STRINGZ		"Nobody's ever drawn blood from me and nobody ever will.\n"
SCB7				.STRINGZ		"You run THAT fast?\n"

SINSULT8		.STRINGZ		"You fight like a dairy farmer.\n"
SCB8				.STRINGZ		"How appropriate. You fight like a cow.\n"

SINSULT9		.STRINGZ		"I got this scar on my face during a mighty struggle!\n"
SCB9				.STRINGZ		"I hope now you've learned to stop picking your nose.\n"

SINSULT10		.STRINGZ		"Have you stopped wearing diapers yet?\n"
SCB10				.STRINGZ		"Why, did you want to borrow one?\n"

SINSULT11		.STRINGZ		"I've heard you were a contemptible sneak.\n"
SCB11				.STRINGZ		"Too bad no one's ever heard of YOU at all.\n"

SINSULT12		.STRINGZ		"You're no match for my brains, you poor fool.\n"
SCB12				.STRINGZ		"I'd be in real trouble if you ever used them.\n"

SINSULT13		.STRINGZ		"You have the manners of a beggar.\n"
SCB13				.STRINGZ		"I wanted to make sure you'd feel comfortable with me.\n"

SINSULT14		.STRINGZ		"I'm not going to take your insolence sitting down!\n"
SCB14				.STRINGZ		"Your hemorrhoids are flaring up again, eh?\n"

SINSULT15		.STRINGZ		"There are no words for how disgusting you are.\n"
SCB15				.STRINGZ		"Yes there are. You just never learned them.\n"

SINSULT16		.STRINGZ		"I've spoken with apes more polite then you.\n"
SCB16				.STRINGZ		"I'm glad to hear you attended your family reunion.\n"

SSMINSULT1	.STRINGZ		"My name is feared in every dirty corner of this island!\n"
SSMINSULT2	.STRINGZ		"I've got the courage and skills of a master swordsman!\n"
SSMINSULT3	.STRINGZ		"My last fight ended with my hands covered with blood.\n"

						.END
