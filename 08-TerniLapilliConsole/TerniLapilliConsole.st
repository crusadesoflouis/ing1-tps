!classDefinition: #TerniLapilliBoardViewTest category: #TerniLapilliConsole!
TestCase subclass: #TerniLapilliBoardViewTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!TerniLapilliBoardViewTest methodsFor: 'Testing' stamp: 'jml 11/9/2018 12:07:41'!
test01BoardViewAMoveOfX
	
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
	equals: boardView view.! !


!classDefinition: #TerniLapilliConsoleTest category: #TerniLapilliConsole!
TestCase subclass: #TerniLapilliConsoleTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'jml 11/8/2018 20:31:19'!
test01ConsoleLogsAMoveOfX
	
	| game console outputStream |
	
	game _ TerniLapilli new.
	
	console _ TerniLapilliConsole for: game.
	
	game putXAt: 2@2.
	
	outputStream := console output.
	
	self assert: 'X marcó en 2@2' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.
	self assert: outputStream atEnd.
	! !

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'jml 11/8/2018 20:32:14'!
test02ConsoleLogsAMoveOfO
	
	| game console outputStream |
	
	game _ TerniLapilli new.
	
	console _ TerniLapilliConsole for: game.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	outputStream := console output.
	
	self assert: 'X marcó en 2@2' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.
	self assert: 'O marcó en 1@1' equals: outputStream next.
	self assert: 'Estado: Jugando X' equals: outputStream next.	
	self assert: outputStream atEnd.
	! !

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'jml 11/8/2018 20:33:02'!
test03ConsoleLogsXMovesAtDifferentPositions
	
	| game console outputStream |
	
	game _ TerniLapilli new.
	
	console _ TerniLapilliConsole for: game.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@2.
	
	outputStream := console output.
	
	self assert: 'X marcó en 2@2' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.
	self assert: 'O marcó en 1@1' equals: outputStream next.
	self assert: 'Estado: Jugando X' equals: outputStream next.	
	self assert: 'X marcó en 1@2' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.	
	self assert: outputStream atEnd.
	! !

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'jml 11/8/2018 20:32:54'!
test04ConsoleLogsOMovesAtDifferentPositions
	
	| game console outputStream |
	
	game _ TerniLapilli new.
	
	console _ TerniLapilliConsole for: game.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@2.
	game putOAt: 3@3.
	
	outputStream := console output.
	
	self assert: 'X marcó en 2@2' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.
	self assert: 'O marcó en 1@1' equals: outputStream next.
	self assert: 'Estado: Jugando X' equals: outputStream next.	
	self assert: 'X marcó en 1@2' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.	
	self assert: 'O marcó en 3@3' equals: outputStream next.
	self assert: 'Estado: Jugando X' equals: outputStream next.	
	self assert: outputStream atEnd.
	! !

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'jml 11/8/2018 20:39:02'!
test05ConsoleLogsThatXWon
	
	| game console outputStream |
	
	game _ TerniLapilli new.
	
	console _ TerniLapilliConsole for: game.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@2.
	game putOAt: 3@3.
	game putXAt: 3@2.
	
	outputStream := console output.
	
	self assert: 'X marcó en 2@2' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.
	self assert: 'O marcó en 1@1' equals: outputStream next.
	self assert: 'Estado: Jugando X' equals: outputStream next.	
	self assert: 'X marcó en 1@2' equals: outputStream next.
	self assert: 'Estado: Jugando O' equals: outputStream next.	
	self assert: 'O marcó en 3@3' equals: outputStream next.
	self assert: 'Estado: Jugando X' equals: outputStream next.	
	self assert: 'X marcó en 3@2' equals: outputStream next.
	self assert: 'Estado: Juego terminado - ¡Ganó X!!' equals: outputStream next.	
	self assert: outputStream atEnd.
	! !

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'jml 11/8/2018 20:39:10'!
test06ConsoleLogsThatOWon
	
	| game console outputStream |
	
	game _ TerniLapilli new.
	
	console _ TerniLapilliConsole for: game.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@2.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 3@1.
	
	outputStream := console output.
	
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
	
	self assert: 'O marcó en 3@1' equals: outputStream next.
	self assert: 'Estado: Juego terminado - ¡Ganó O!!' equals: outputStream next.
	
	self assert: outputStream atEnd.
	! !

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'la 11/9/2018 02:56:23'!
test07ConsoleLogsStateXAfterLastPiece
	
	| game console outputStream |
	
	game _ TerniLapilli new.
	
	console _ TerniLapilliConsole for: game.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@2.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 3@2.
	
	outputStream := console output.
	
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
	self assert: outputStream atEnd.
	! !

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'la 11/9/2018 03:00:57'!
test08ConsoleLogsASlidingOfX
	
	| game console outputStream |
	
	game _ TerniLapilli new.
	
	console _ TerniLapilliConsole for: game.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@2.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 3@2.
	game slideXFrom: 3@3 to: 2@3.
	
	outputStream := console output.
	
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
	
	self assert: outputStream atEnd.
	! !

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'la 11/9/2018 03:01:24'!
test09ConsoleLogsASlidingOfO
	
	| game console outputStream |
	
	game _ TerniLapilli new.
	
	console _ TerniLapilliConsole for: game.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@2.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 3@2.
	game slideXFrom: 3@3 to: 2@3.
	game slideOFrom: 3@2 to: 3@3.	
	outputStream := console output.
	
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
	
	self assert: 'O deslizó hasta 3@3 desde 3@2' equals: outputStream next.
	self assert: 'Estado: Jugando X' equals: outputStream next.
	
	self assert: outputStream atEnd.
	! !


!classDefinition: #TerniLapilliBoardView category: #TerniLapilliConsole!
Object subclass: #TerniLapilliBoardView
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsole'!

!TerniLapilliBoardView methodsFor: 'instance creation' stamp: 'la 11/9/2018 03:26:58'!
initializeFor: aGame 
	
	game _ aGame.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliBoardView class' category: #TerniLapilliConsole!
TerniLapilliBoardView class
	instanceVariableNames: ''!

!TerniLapilliBoardView class methodsFor: 'instance creation' stamp: 'la 11/9/2018 03:26:20'!
for: aGame

	self new initializeFor: aGame 
	
	! !


!TerniLapilliBoardView class methodsFor: 'accessing' stamp: 'la 11/9/2018 03:27:18'!
view
	
	^' | | 
-----
 |X| 
-----
 | | '! !


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

!TerniLapilliConsole methodsFor: 'logging' stamp: 'jml 11/8/2018 20:48:09'!
xHasPlacedAt: aPosition
	
	self player: 'X' hasPlacedAt: aPosition.! !


!TerniLapilliConsole methodsFor: 'logging - private' stamp: 'jml 11/8/2018 20:43:49'!
addMarkingLineFor: aPlayer at: aPosition
	
	lines add: aPlayer, ' marcó en ', aPosition printString.! !

!TerniLapilliConsole methodsFor: 'logging - private' stamp: 'la 11/9/2018 03:09:19'!
addSlidingLIneFor: aPlayer at: aPosition to: anotherPosition 
	
	lines add: aPlayer , ' deslizó hasta ',anotherPosition printString, ' desde ', aPosition printString.! !

!TerniLapilliConsole methodsFor: 'logging - private' stamp: 'la 11/9/2018 03:12:49'!
addSlidingLine

	game isSlidingX 
		ifTrue:[lines add: 'Estado: Jugando X']
		ifFalse:[lines add: 'Estado: Jugando O']! !

!TerniLapilliConsole methodsFor: 'logging - private' stamp: 'jml 11/8/2018 20:40:59'!
addStateLine
	
	game isOver
		ifTrue: [ self addWonLine ]
		ifFalse: [ self addTurnLine ].! !

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

!TerniLapilliConsole methodsFor: 'logging - private' stamp: 'la 11/9/2018 03:14:59'!
player: aPlayer hasMovedFrom: aPosition to: anotherPosition 
	
	self addSlidingLIneFor: aPlayer at: aPosition to: anotherPosition.
	self addStateLine.! !

!TerniLapilliConsole methodsFor: 'logging - private' stamp: 'jml 11/8/2018 20:46:36'!
player: aPlayer hasPlacedAt: aPosition
	
	self addMarkingLineFor: aPlayer at: aPosition.
	self addStateLine.! !

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
