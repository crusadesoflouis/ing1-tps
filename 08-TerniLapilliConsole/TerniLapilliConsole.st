!classDefinition: #TerniLapilliBoardViewTest category: #TerniLapilliConsole!
TestCase subclass: #TerniLapilliBoardViewTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!TerniLapilliBoardViewTest methodsFor: 'testing' stamp: 'jml 11/9/2018 12:24:06'!
test01EmptyBoard
	
	| game boardView |
	
	game _ TerniLapilli new.
	
	boardView _ TerniLapilliBoardView for: game.
	
	self assert: 
' | | 
-----
 | | 
-----
 | | '
	equals: boardView output.! !

!TerniLapilliBoardViewTest methodsFor: 'testing' stamp: 'jml 11/9/2018 12:24:10'!
test02XPlacing
	
	| game boardView |
	
	game _ TerniLapilli new.
	
	boardView _ TerniLapilliBoardView for: game.
	
	game putXAt: 2@2.
	
	self assert: 
' | | 
-----
 |X| 
-----
 | | '
	equals: boardView output.! !


!classDefinition: #TerniLapilliConsoleTest category: #TerniLapilliConsole!
TestCase subclass: #TerniLapilliConsoleTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!TerniLapilliConsoleTest methodsFor: 'assertion - private' stamp: 'jml 11/9/2018 12:51:29'!
skip: aNumberOfLines in: aStream
	
	aNumberOfLines timesRepeat: [ aStream next ].! !


!TerniLapilliConsoleTest methodsFor: 'assertions' stamp: 'jml 11/9/2018 12:49:28'!
assertLinesIn: aStream equals: lines
	
	lines do: [ :line | self assert: line equals: aStream next ].
	
	self assert: aStream atEnd.! !

!TerniLapilliConsoleTest methodsFor: 'assertions' stamp: 'jml 11/9/2018 12:51:22'!
assertLinesIn: aStream skipping: aNumberOfLines equals: lines
	
	self skip: aNumberOfLines in: aStream.
	
	self assertLinesIn: aStream equals: lines.! !


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

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'jml 11/9/2018 13:00:18'!
test05XWinsByPlacing
	
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
	}.
	
	"
	self assert: 'X marcó en 2@2' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.
	self assert: 'O marcó en 1@1' equals: outputStream next.
	self assert: 'Estado: Jugando X' equals: outputStream next.
	self assert: 'X marcó en 1@2' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.
	self assert: 'O marcó en 3@3' equals: outputStream next.
	self assert: 'Estado: Jugando X' equals: outputStream next.
	"! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'jml 11/9/2018 13:00:40'!
test06OWinsByPlacing
	
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
	}.
	
	
	"
	self assert: 'X marcó en 2@2' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.
	
	self assert: 'O marcó en 1@1' equals: outputStream next.
	self assert: 'Estado: Jugando X' equals: outputStream next.
	
	self assert: 'X marcó en 1@2' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.
	
	self assert: 'O marcó en 2@1' equals: outputStream next.
	self assert: 'Estado: Jugando X' equals: outputStream next.
	
	self assert: 'X marcó en 3@3' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.
	"
	! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'jml 11/9/2018 13:01:00'!
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
	}.
	
	"
	self assert: 'X marcó en 2@2' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.
	
	self assert: 'O marcó en 1@1' equals: outputStream next.
	self assert: 'Estado: Jugando X' equals: outputStream next.
	
	self assert: 'X marcó en 1@2' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.
	
	self assert: 'O marcó en 2@1' equals: outputStream next.
	self assert: 'Estado: Jugando X' equals: outputStream next.
	
	self assert: 'X marcó en 3@3' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.
	
	self assert: 'O marcó en 3@2' equals: outputStream next.
	"! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'jml 11/9/2018 13:01:23'!
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
	}.
	
	"
	self assert: 'X marcó en 2@2' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.
	
	self assert: 'O marcó en 1@1' equals: outputStream next.
	self assert: 'Estado: Jugando X' equals: outputStream next.
	
	self assert: 'X marcó en 1@2' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.
	
	self assert: 'O marcó en 2@1' equals: outputStream next.
	self assert: 'Estado: Jugando X' equals: outputStream next.
	
	self assert: 'X marcó en 3@3' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.
	
	self assert: 'O marcó en 3@2' equals: outputStream next.
	self assert: 'Estado: Jugando X' equals: outputStream next.
	"! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'jml 11/9/2018 13:01:53'!
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
	}.
	
	"
	self assert: 'X marcó en 2@2' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.
	
	self assert: 'O marcó en 1@1' equals: outputStream next.
	self assert: 'Estado: Jugando X' equals: outputStream next.
	
	self assert: 'X marcó en 1@2' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.
	
	self assert: 'O marcó en 2@1' equals: outputStream next.
	self assert: 'Estado: Jugando X' equals: outputStream next.
	
	self assert: 'X marcó en 3@3' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.
	
	self assert: 'O marcó en 3@2' equals: outputStream next.
	self assert: 'Estado: Jugando X' equals: outputStream next.
	
	self assert: 'X deslizó hasta 2@3 desde 3@3' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.
	"! !


!classDefinition: #TerniLapilliBoardView category: #TerniLapilliConsole!
Object subclass: #TerniLapilliBoardView
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!TerniLapilliBoardView methodsFor: 'initialization' stamp: 'la 11/9/2018 03:26:58'!
initializeFor: aGame 
	
	game _ aGame.! !


!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'jml 11/9/2018 12:23:41'!
output
	
	^' | | 
-----
 | | 
-----
 | | '! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliBoardView class' category: #TerniLapilliConsole!
TerniLapilliBoardView class
	instanceVariableNames: ''!

!TerniLapilliBoardView class methodsFor: 'instance creation' stamp: 'jml 11/9/2018 12:25:51'!
for: aGame

	^ self new initializeFor: aGame! !


!classDefinition: #TerniLapilliConsole category: #TerniLapilliConsole!
Object subclass: #TerniLapilliConsole
	instanceVariableNames: 'lines game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!TerniLapilliConsole methodsFor: 'initialization' stamp: 'jml 11/8/2018 20:09:21'!
initializeFor: aGame
	
	game _ aGame.
	lines _ OrderedCollection new.
	
	aGame setConsole: self.! !


!TerniLapilliConsole methodsFor: 'accessing' stamp: 'jml 11/8/2018 19:54:55'!
output

	^ ReadStream on: lines! !


!TerniLapilliConsole methodsFor: 'logging' stamp: 'jml 11/8/2018 20:47:56'!
oHasPlacedAt: aPosition
	
	self player: 'O' hasPlacedAt: aPosition.! !

!TerniLapilliConsole methodsFor: 'logging' stamp: 'jml 11/9/2018 13:45:50'!
stateChangedTo: newState
	
	(newState isKindOf: PlacingO) ifTrue: [
		lines add: 'Estado: Jugando O'
	].
	
	(newState isKindOf: PlayingX) ifTrue: [
		lines add: 'Estado: Jugando X'
	].
	
	(newState isKindOf: GameOverState) ifTrue: [
		game hasPlayerXWon ifTrue: [
			lines add: 'Estado: Juego terminado - ¡Ganó X!!'.
		] ifFalse: [
			lines add: 'Estado: Juego terminado - ¡Ganó O!!'.
		].
	].
	! !

!TerniLapilliConsole methodsFor: 'logging' stamp: 'jml 11/8/2018 20:48:09'!
xHasPlacedAt: aPosition
	
	self player: 'X' hasPlacedAt: aPosition.! !


!TerniLapilliConsole methodsFor: 'logging - private' stamp: 'jml 11/9/2018 13:49:25'!
addPlacingLineFor: aPlayer at: aPosition
	
	lines add: aPlayer, ' marcó en ', aPosition printString.! !

!TerniLapilliConsole methodsFor: 'logging - private' stamp: 'la 11/9/2018 03:12:49'!
addSlidingLine

	game isSlidingX 
		ifTrue:[lines add: 'Estado: Jugando X']
		ifFalse:[lines add: 'Estado: Jugando O']! !

!TerniLapilliConsole methodsFor: 'logging - private' stamp: 'jml 11/9/2018 13:49:54'!
addSlidingLineFor: aPlayer at: aPosition to: anotherPosition 
	
	lines add: aPlayer , ' deslizó hasta ',anotherPosition printString, ' desde ', aPosition printString.! !

!TerniLapilliConsole methodsFor: 'logging - private' stamp: 'la 11/9/2018 03:12:49'!
addTurnLine

	game isPlacingX
		ifTrue: [ lines add: 'Estado: Jugando X'. ]
		ifFalse: [ game isSlidingX ifTrue: [self addSlidingLine] 
		ifFalse: [ lines add: 'Estado: Jugando O'. ]
		].! !

!TerniLapilliConsole methodsFor: 'logging - private' stamp: 'jml 11/8/2018 20:40:34'!
addWonLine

	game hasPlayerXWon
		ifTrue: [ lines add: 'Estado: Juego terminado - ¡Ganó X!!' ]
		ifFalse: [ lines add: 'Estado: Juego terminado - ¡Ganó O!!' ]! !

!TerniLapilliConsole methodsFor: 'logging - private' stamp: 'la 11/9/2018 03:15:19'!
oHasSlideFrom: aPosition to: anotherPosition 
	
	self player: 'O' hasMovedFrom: aPosition to:anotherPosition.! !

!TerniLapilliConsole methodsFor: 'logging - private' stamp: 'jml 11/9/2018 13:51:46'!
player: aPlayer hasMovedFrom: aPosition to: anotherPosition 
	
	self addSlidingLineFor: aPlayer at: aPosition to: anotherPosition.! !

!TerniLapilliConsole methodsFor: 'logging - private' stamp: 'jml 11/9/2018 13:51:56'!
player: aPlayer hasPlacedAt: aPosition

	self addPlacingLineFor: aPlayer at: aPosition.
! !

!TerniLapilliConsole methodsFor: 'logging - private' stamp: 'la 11/9/2018 03:14:21'!
xHasSlideFrom: aPosition to: anotherPosition 
	
	self player: 'X' hasMovedFrom: aPosition to:anotherPosition.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliConsole class' category: #TerniLapilliConsole!
TerniLapilliConsole class
	instanceVariableNames: ''!

!TerniLapilliConsole class methodsFor: 'instance creation' stamp: 'jml 11/8/2018 19:37:53'!
for: aGame
	
	^ self new initializeFor: aGame! !
