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

!TerniLapilliConsoleTest methodsFor: 'Testing' stamp: 'jml 11/8/2018 20:58:43'!
test07ConsoleLogsASlidingOfX
	
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

!TerniLapilliConsole methodsFor: 'logging - private' stamp: 'jml 11/8/2018 20:40:59'!
addStateLine
	
	game isOver
		ifTrue: [ self addWonLine ]
		ifFalse: [ self addTurnLine ].! !

!TerniLapilliConsole methodsFor: 'logging - private' stamp: 'jml 11/8/2018 20:41:27'!
addTurnLine

	game isPlacingX
		ifTrue: [ lines add: 'Estado: Jugando X'. ]
		ifFalse: [ lines add: 'Estado: Jugando O'. ].! !

!TerniLapilliConsole methodsFor: 'logging - private' stamp: 'jml 11/8/2018 20:40:34'!
addWonLine

	game hasPlayerXWon
		ifTrue: [ lines add: 'Estado: Juego terminado - ¡Ganó X!!' ]
		ifFalse: [ lines add: 'Estado: Juego terminado - ¡Ganó O!!' ]! !

!TerniLapilliConsole methodsFor: 'logging - private' stamp: 'jml 11/8/2018 20:46:36'!
player: aPlayer hasPlacedAt: aPosition
	
	self addMarkingLineFor: aPlayer at: aPosition.
	self addStateLine.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliConsole class' category: #TerniLapilliConsole!
TerniLapilliConsole class
	instanceVariableNames: ''!

!TerniLapilliConsole class methodsFor: 'instance creation' stamp: 'jml 11/8/2018 19:37:53'!
for: aGame
	
	^ self new initializeFor: aGame! !
