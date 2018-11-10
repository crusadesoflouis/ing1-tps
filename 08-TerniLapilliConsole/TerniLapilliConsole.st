!classDefinition: #StreamTest category: #TerniLapilliConsole!
TestCase subclass: #StreamTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!StreamTest methodsFor: 'assertion - private' stamp: 'jml 11/9/2018 16:06:10'!
skip: aNumberOfLines in: aStream
	
	aNumberOfLines timesRepeat: [ aStream next ].! !


!StreamTest methodsFor: 'assertions' stamp: 'jml 11/9/2018 16:06:10'!
assertLinesIn: aStream equals: lines
	
	lines do: [ :line | self assert: line equals: aStream next ].
	
	self assert: aStream atEnd.! !

!StreamTest methodsFor: 'assertions' stamp: 'jml 11/9/2018 16:06:10'!
assertLinesIn: aStream skipping: aNumberOfLines equals: lines
	
	self skip: aNumberOfLines in: aStream.
	
	self assertLinesIn: aStream equals: lines.! !


!classDefinition: #TerniLapilliConsoleTest category: #TerniLapilliConsole!
StreamTest subclass: #TerniLapilliConsoleTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'jml 11/9/2018 12:49:28'!
test01XPlacing
	
	| game console |
	
	game _ TerniLapilli new.
	
	console _ TerniLapilliConsole for: game.
	
	game putXAt: 2@2.
	
	self assertLinesIn: console output equals: {
		'X marcó en 2@2'.
		'Estado: Jugando O'
	}.
	! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'jml 11/9/2018 12:59:24'!
test02OPlacing
	
	| game console |
	
	game _ TerniLapilli new.
	
	console _ TerniLapilliConsole for: game.
	
	game
		putXAt: 2@2;
		putOAt: 1@1.
	
	self assertLinesIn: console output equals: {
		'X marcó en 2@2'.
		'Estado: Jugando O'.
		'O marcó en 1@1'.
		'Estado: Jugando X'.
	}.
	! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'jml 11/9/2018 12:59:50'!
test03XPlacingAtDifferentPositions
	
	| game console |
	
	game _ TerniLapilli new.
	
	console _ TerniLapilliConsole for: game.
	
	game
		putXAt: 2@2;
		putOAt: 1@1;
		putXAt: 1@2.
	
	self assertLinesIn: console output equals: {
		'X marcó en 2@2'.
		'Estado: Jugando O'.
		'O marcó en 1@1'.
		'Estado: Jugando X'.
		'X marcó en 1@2'.
		'Estado: Jugando O'.
	}.
	! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'jml 11/9/2018 13:00:02'!
test04OPlacingAtDifferentPositions
	
	| game console |
	
	game _ TerniLapilli new.
	
	console _ TerniLapilliConsole for: game.
	
	game
		putXAt: 2@2;
		putOAt: 1@1;
		putXAt: 1@2;
		putOAt: 3@3.
	
	self assertLinesIn: console output equals: {
		'X marcó en 2@2'.
		'Estado: Jugando O'.
		'O marcó en 1@1'.
		'Estado: Jugando X'.
		'X marcó en 1@2'.
		'Estado: Jugando O'.
		'O marcó en 3@3'.
		'Estado: Jugando X'.
	}.
	! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'jml 11/10/2018 06:29:42'!
test05XWins
	
	| game console |
	
	game _ TerniLapilli new.
	
	console _ TerniLapilliConsole for: game.
	
	game
		putXAt: 2@2;
		putOAt: 1@1;
		putXAt: 1@2;
		putOAt: 3@3;
		putXAt: 3@2.
	
	self assertLinesIn: console output skipping: 8 equals: {
		'X marcó en 3@2'.
		'Estado: Juego terminado - ¡Ganó X!!'.
	}.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'jml 11/10/2018 06:29:48'!
test06OWins
	
	| game console |
	
	game _ TerniLapilli new.
	
	console _ TerniLapilliConsole for: game.
	
	game
		putXAt: 2@2;
		putOAt: 1@1;
		putXAt: 1@2;
		putOAt: 2@1;
		putXAt: 3@3;
		putOAt: 3@1.
	
	self assertLinesIn: console output skipping: 10 equals: {
		'O marcó en 3@1'.
		'Estado: Juego terminado - ¡Ganó O!!'
	}.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'jml 11/10/2018 06:29:53'!
test07IsXTurnAfterLastPiece
	
	| game console |
	
	game _ TerniLapilli new.
	
	console _ TerniLapilliConsole for: game.
	
	game
		putXAt: 2@2;
		putOAt: 1@1;
		putXAt: 1@2;
		putOAt: 2@1;
		putXAt: 3@3;
		putOAt: 3@2.
	
	self assertLinesIn: console output skipping: 11 equals: {
		'Estado: Jugando X'
	}.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'jml 11/10/2018 06:29:58'!
test08XSliding
	
	| game console |
	
	game _ TerniLapilli new.
	
	console _ TerniLapilliConsole for: game.
	
	game
		putXAt: 2@2;
		putOAt: 1@1;
		putXAt: 1@2;
		putOAt: 2@1;
		putXAt: 3@3;
		putOAt: 3@2;
		slideXFrom: 3@3 to: 2@3.
	
	self assertLinesIn: console output skipping: 12 equals: {
		'X deslizó hasta 2@3 desde 3@3'.
		'Estado: Jugando O'.
	}.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'jml 11/10/2018 06:30:07'!
test09OSliding
	
	| game console |
	
	game _ TerniLapilli new.
	
	console _ TerniLapilliConsole for: game.
	
	game
		putXAt: 2@2;
		putOAt: 1@1;
		putXAt: 1@2;
		putOAt: 2@1;
		putXAt: 3@3;
		putOAt: 3@2;
		slideXFrom: 3@3 to: 2@3;
		slideOFrom: 3@2 to: 3@3.	
	
	self assertLinesIn: console output skipping: 14 equals: {
		'O deslizó hasta 3@3 desde 3@2'.
		'Estado: Jugando X'.
	}.! !


!classDefinition: #TerniLapilliBoardViewTest category: #TerniLapilliConsole!
TestCase subclass: #TerniLapilliBoardViewTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!TerniLapilliBoardViewTest methodsFor: 'testing' stamp: 'jml 11/9/2018 16:28:38'!
test01EmptyBoard
	
	| game boardView |
	
	game _ TerniLapilli new.
	
	boardView _ TerniLapilliBoardView for: game.
	
	self assert: boardView output equals: 
' | | 
-----
 | | 
-----
 | | 
Playing X'.! !

!TerniLapilliBoardViewTest methodsFor: 'testing' stamp: 'jml 11/9/2018 16:30:33'!
test02XPlacing
	
	| game boardView |
	
	game _ TerniLapilli new.
	
	boardView _ TerniLapilliBoardView for: game.
	
	game putXAt: 3@1.
	
	self assert: boardView output equals:
' | | 
-----
 | | 
-----
X| | 
Playing O'.! !

!TerniLapilliBoardViewTest methodsFor: 'testing' stamp: 'jml 11/9/2018 16:52:10'!
test03OPlacing
	
	| game boardView |
	
	game _ TerniLapilli new.
	
	boardView _ TerniLapilliBoardView for: game.
	
	game 
		putXAt: 3@1;
		putOAt: 3@2.
	
	self assert: boardView output equals:
' | | 
-----
 | | 
-----
X|O| 
Playing X'.! !

!TerniLapilliBoardViewTest methodsFor: 'testing' stamp: 'jml 11/9/2018 16:55:47'!
test04XWins
	
	| game boardView |
	
	game _ TerniLapilli new.
	
	boardView _ TerniLapilliBoardView for: game.
	
	game
		putXAt: 2@2;
		putOAt: 1@1;
		putXAt: 1@2;
		putOAt: 3@3;
		putXAt: 3@2.
		
	self assert: boardView output equals:
'O|X| 
-----
 |X| 
-----
 |X|O
X Won!!'.! !

!TerniLapilliBoardViewTest methodsFor: 'testing' stamp: 'jml 11/9/2018 16:57:28'!
test05OWins
	
	| game boardView |
	
	game _ TerniLapilli new.
	
	boardView _ TerniLapilliBoardView for: game.
	
	game
		putXAt: 2@2;
		putOAt: 1@1;
		putXAt: 1@2;
		putOAt: 2@1;
		putXAt: 3@3;
		putOAt: 3@1.
		
	self assert: boardView output equals:
'O|X| 
-----
O|X| 
-----
O| |X
O Won!!'.! !

!TerniLapilliBoardViewTest methodsFor: 'testing' stamp: 'la 11/9/2018 22:50:29'!
test06XSliding
	
	| game boardView |
	
	game _ TerniLapilli new.
	
	boardView _ TerniLapilliBoardView for: game.
	
	game
		putXAt: 2@2;
		putOAt: 1@1;
		putXAt: 1@2;
		putOAt: 2@1;
		putXAt: 3@3;
		putOAt: 3@2;
		slideXFrom: 3@3 to: 2@3.
		
	self assert: boardView output equals:
'O|X| 
-----
O|X|X
-----
 |O| 
Playing O'.! !

!TerniLapilliBoardViewTest methodsFor: 'testing' stamp: 'la 11/9/2018 23:15:44'!
test07OSliding
	
	| game boardView |
	
	game _ TerniLapilli new.
	
	boardView _ TerniLapilliBoardView for: game.

	game
		putXAt: 2@2;
		putOAt: 1@1;
		putXAt: 1@2;
		putOAt: 2@1;
		putXAt: 3@3;
		putOAt: 3@2;
		slideXFrom: 3@3 to: 2@3;
		slideOFrom: 3@2 to: 3@3.
		
	self assert: boardView output equals:
'O|X| 
-----
O|X|X
-----
 | |O
Playing X'.! !


!classDefinition: #TerniLapilliObserver category: #TerniLapilliConsole!
Object subclass: #TerniLapilliObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!TerniLapilliObserver methodsFor: 'state' stamp: 'jml 11/10/2018 06:15:03'!
stateChangedTo: aState
	
	self subclassResponsibility! !


!classDefinition: #TerniLapilliBoardView category: #TerniLapilliConsole!
TerniLapilliObserver subclass: #TerniLapilliBoardView
	instanceVariableNames: 'game board currentState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!TerniLapilliBoardView methodsFor: 'initialization' stamp: 'jml 11/9/2018 16:48:06'!
initializeFor: aGame 
	
	game _ aGame.
	
	aGame addObserver: self.
	
	" TODO check this"
	currentState := self turnLineFor: 'X'.
	
	board := Array
		with: (Array with: ' ' with: ' ' with: ' ')
		with: (Array with: ' ' with: ' ' with: ' ')
		with: (Array with: ' ' with: ' ' with: ' ')
	.! !


!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'jml 11/10/2018 06:23:17'!
output
	
	^ (self at: (1@1)), '|', (self at: (1@2)), '|', (self at: (1@3)), '
-----
', (self at: (2@1)), '|', (self at: (2@2)), '|', (self at: (2@3)), '
-----
', (self at: (3@1)), '|', (self at: (3@2)), '|', (self at: (3@3)), '
', currentState! !


!TerniLapilliBoardView methodsFor: 'play visiting' stamp: 'jml 11/10/2018 06:16:53'!
oHasPlacedAt: aPosition
	
	self at: aPosition put: 'O'.! !

!TerniLapilliBoardView methodsFor: 'play visiting' stamp: 'jml 11/10/2018 06:20:29'!
oHasSlidFrom: origin to: destination

	self move: 'O' from: origin to: destination.
	! !

!TerniLapilliBoardView methodsFor: 'play visiting' stamp: 'jml 11/10/2018 06:17:45'!
xHasPlacedAt: aPosition
	
	self at: aPosition put: 'X'.! !

!TerniLapilliBoardView methodsFor: 'play visiting' stamp: 'jml 11/10/2018 06:20:35'!
xHasSlidFrom: origin to: destination

	self move: 'X' from: origin to: destination.
	! !


!TerniLapilliBoardView methodsFor: 'board' stamp: 'jml 11/9/2018 16:40:06'!
at: aPosition
	
	^ (board at: aPosition x) at: aPosition y! !

!TerniLapilliBoardView methodsFor: 'board' stamp: 'jml 11/10/2018 06:17:24'!
at: aPosition put: aPlayer
	
	(board at: aPosition x) at: aPosition y put: aPlayer.! !

!TerniLapilliBoardView methodsFor: 'board' stamp: 'jml 11/10/2018 06:20:12'!
move: player from: origin to: destination
	
	self
		at: origin put: ' ';
		at: destination put: player.! !


!TerniLapilliBoardView methodsFor: 'messages' stamp: 'jml 11/9/2018 16:57:41'!
stateLineFor: aState
	
	(aState isKindOf: PlayingO) ifTrue: [ ^ self turnLineFor: 'O' ].
	(aState isKindOf: PlayingX) ifTrue: [ ^ self turnLineFor: 'X' ].
	
	(aState isKindOf: GameOverState) ifTrue: [
		^ self winningLineFor: (game hasPlayerXWon ifTrue: [ 'X' ] ifFalse: [ 'O' ])
	].
	
	self error: 'State not recognized'.
	! !

!TerniLapilliBoardView methodsFor: 'messages' stamp: 'jml 11/9/2018 16:46:29'!
turnLineFor: aPlayer
	
	^ 'Playing ', aPlayer! !

!TerniLapilliBoardView methodsFor: 'messages' stamp: 'jml 11/9/2018 16:54:37'!
winningLineFor: aPlayer
	
	^ aPlayer, ' Won!!'! !


!TerniLapilliBoardView methodsFor: 'state' stamp: 'jml 11/10/2018 06:15:47'!
stateChangedTo: aState
	
	game lastPlay accept: self.
	
	currentState := self stateLineFor: aState.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliBoardView class' category: #TerniLapilliConsole!
TerniLapilliBoardView class
	instanceVariableNames: ''!

!TerniLapilliBoardView class methodsFor: 'instance creation' stamp: 'jml 11/9/2018 12:25:51'!
for: aGame

	^ self new initializeFor: aGame! !


!classDefinition: #TerniLapilliConsole category: #TerniLapilliConsole!
TerniLapilliObserver subclass: #TerniLapilliConsole
	instanceVariableNames: 'lines game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!TerniLapilliConsole methodsFor: 'initialization' stamp: 'jml 11/9/2018 16:17:45'!
initializeFor: aGame
	
	game _ aGame.
	lines _ OrderedCollection new.
	
	aGame addObserver: self.! !


!TerniLapilliConsole methodsFor: 'accessing' stamp: 'jml 11/8/2018 19:54:55'!
output

	^ ReadStream on: lines! !


!TerniLapilliConsole methodsFor: 'play visiting' stamp: 'jml 11/10/2018 06:03:25'!
oHasPlacedAt: aPosition
	
	self addLine: (self placingLineFor: 'O' at: aPosition).! !

!TerniLapilliConsole methodsFor: 'play visiting' stamp: 'jml 11/10/2018 06:03:20'!
oHasSlidFrom: fromPosition to: toPosition
	
	self addLine: (self slidingLineFor: 'O' from: fromPosition to: toPosition).! !

!TerniLapilliConsole methodsFor: 'play visiting' stamp: 'jml 11/10/2018 06:03:15'!
xHasPlacedAt: aPosition
	
	self addLine: (self placingLineFor: 'X' at: aPosition).! !

!TerniLapilliConsole methodsFor: 'play visiting' stamp: 'jml 11/10/2018 05:59:42'!
xHasSlidFrom: fromPosition to: toPosition
	
	self addLine: (self slidingLineFor: 'X' from: fromPosition to: toPosition).! !


!TerniLapilliConsole methodsFor: 'logging - private' stamp: 'jml 11/9/2018 13:56:26'!
addLine: aLine
	
	lines add: aLine! !


!TerniLapilliConsole methodsFor: 'messages' stamp: 'jml 11/9/2018 13:59:56'!
placingLineFor: aPlayer at: aPosition
	
	^ aPlayer, ' marcó en ', aPosition printString.! !

!TerniLapilliConsole methodsFor: 'messages' stamp: 'jml 11/9/2018 14:06:48'!
slidingLineFor: aPlayer from: fromPosition to: toPosition 
	
	^ aPlayer , ' deslizó hasta ', toPosition printString, ' desde ', fromPosition printString! !

!TerniLapilliConsole methodsFor: 'messages' stamp: 'jml 11/9/2018 14:16:00'!
stateLineFor: newState
	
	(newState isKindOf: PlayingO) ifTrue: [ ^ self turnLineFor: 'O' ].
	(newState isKindOf: PlayingX) ifTrue: [ ^ self turnLineFor: 'X' ].
	
	(newState isKindOf: GameOverState) ifTrue: [
		^ self winningLineFor: (game hasPlayerXWon ifTrue: [ 'X' ] ifFalse: [ 'O' ])
	].
	
	self error: 'State not recognized'.! !

!TerniLapilliConsole methodsFor: 'messages' stamp: 'jml 11/9/2018 14:00:58'!
turnLineFor: aPlayer
	
	^ 'Estado: Jugando ', aPlayer! !

!TerniLapilliConsole methodsFor: 'messages' stamp: 'jml 11/9/2018 14:01:40'!
winningLineFor: aPlayer

	^ 'Estado: Juego terminado - ¡Ganó ', aPlayer, '!!'! !


!TerniLapilliConsole methodsFor: 'state' stamp: 'jml 11/10/2018 05:58:23'!
stateChangedTo: newState
	
	game lastPlay accept: self.
	
	self addLine: (self stateLineFor: newState)
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliConsole class' category: #TerniLapilliConsole!
TerniLapilliConsole class
	instanceVariableNames: ''!

!TerniLapilliConsole class methodsFor: 'instance creation' stamp: 'jml 11/8/2018 19:37:53'!
for: aGame
	
	^ self new initializeFor: aGame! !
