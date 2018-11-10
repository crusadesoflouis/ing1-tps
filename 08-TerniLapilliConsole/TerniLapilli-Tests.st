!classDefinition: #StreamTest category: #'TerniLapilli-Tests'!
TestCase subclass: #StreamTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Tests'!

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


!classDefinition: #TerniLapilliConsoleTest category: #'TerniLapilli-Tests'!
StreamTest subclass: #TerniLapilliConsoleTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Tests'!

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


!classDefinition: #TerniLapilliBoardViewTest category: #'TerniLapilli-Tests'!
TestCase subclass: #TerniLapilliBoardViewTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Tests'!

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


!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Tests'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Tests'!

!TerniLapilliTest methodsFor: 'assertions' stamp: 'HAW 11/8/2018 09:51:39'!
assertCanNotMarkAt: aPosition
	self assertCanNotMarkUsing: [ game putXAt: aPosition ].
	self assertCanNotMarkUsing: [ game putOAt: aPosition ].! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 20:12:53'!
assertCanNotMarkUsing: aMarkingClosure
	self
		should: aMarkingClosure 
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli positionOutsideBoardErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{}
				andOOn:
					{} ].! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:53:12'!
assertGameIsNotOver
	self deny: game isOver.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 08:20:23'!
assertGameIsOver
	self assert: game isOver.
	self deny: game isPlayingX.
	self deny: game isPlayingO.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:59:35'!
assertIsPlayingO
	self assert: game isPlayingO.
	self deny: game isPlayingX.
	self assertGameIsNotOver.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:52:33'!
assertIsPlayingX
	self assert: game isPlayingX.
	self deny: game isPlayingO.
	self assertGameIsNotOver.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:56:00'!
assertOIsMarkedOn: oPositions
	self
		assert: oPositions size
		equals: game playerOPositions size.
	self assert: (game playerOPositions difference: oPositions ) isEmpty.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 08:38:50'!
assertOWon
	self assertGameIsOver.
	self assert: game hasPlayerOWon.
	self deny: game hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:50:53'!
assertXIsMarkedOn: xPositions
	self
		assert: xPositions size
		equals: game playerXPositions size.
	self assert: (game playerXPositions difference: xPositions ) isEmpty.! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 07:48:39'!
assertXIsMarkedOn: xPositions andOOn: oPositions
	self assertXIsMarkedOn: xPositions .
	self assertOIsMarkedOn: oPositions .! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'JG 11/6/2018 08:20:00'!
assertXWon
	self assertGameIsOver.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !


!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 07:25:01'!
functionalException
	^ Error - MessageNotUnderstood.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 09:31:31'!
test01aGameStartsWithAnEmptyBoardAndPlayingX

	game _ TerniLapilli new.

	self assertXIsMarkedOn: {} andOOn: {}.
	self assertIsPlayingX.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 09:33:14'!
test01bGameStartsWithAnEmptyBoardButOCanNotPlayFirst
	
	| oPosition |
	
	game _ TerniLapilli new.
	oPosition _ 2@2.
	
	self should: [ game putOAt: oPosition]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli notOTurnErrorMessage 
				equals: anError messageText.
			self deny: (game isTaken: oPosition) ].			
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:54:38'!
test02AfterMarkingWithXGameKeepsMarkAndNextPlayerIsO
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	self
		assertXIsMarkedOn:
			{1 @ 1}
		andOOn:
			{}.
	self assertIsPlayingO.
	
	
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:04:28'!
test03AfterMarkingWithOGameKeepsMarkAndNextPlayerIsX
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		assertXIsMarkedOn:
			{1 @ 1}
		andOOn:
			{2 @ 2}.
	self assertIsPlayingX.	
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:07:30'!
test04CanNotMarkWithXWhenLastMarkWasX
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	self
		should: [ game putXAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli notXTurnErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{} ].	
				
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:09:21'!
test05CanNotMarkWithOWhenLastMarkWasO
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		should: [ game putOAt: 3 @ 3 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli notOTurnErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{2 @ 2} ].
				
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:11:07'!
test06CanNotMarkWithXAnAlreadyMarkedPositionWithX
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		should: [ game putXAt: 1 @ 1. ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli positionTakenErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{2 @ 2} ].
				
				
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:13:58'!
test07CanNotMarkWithXAnAlreadyMarkedPositionWithO
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	self
		should: [ game putXAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli positionTakenErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{2 @ 2} ].
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:16:06'!
test08CanNotMarkWithOAnAlreadyMarkedPositionWithX
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	self
		should: [ game putOAt: 1 @ 1 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli positionTakenErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{} ].	
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:18:11'!
test09CanNotMarkWithOAnAlreadyMarkedPositionWithO
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	game putXAt: 3 @ 3.
	self
		should: [ game putOAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli positionTakenErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1. 3 @ 3}
				andOOn:
					{2 @ 2} ].
				
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/8/2018 13:11:55'!
test10AssertThereIsNotWinner
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 3 @ 2.
	
	self assertGameIsNotOver ! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:22:01'!
test11XWinsWhenCompletesRowNumber1
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	self assertXWon.
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:30:21'!
test12XWinsWhenCompletesRowNumber2
	game _ TerniLapilli new.
	game putXAt: 2 @ 1.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 2 @ 3.
	self assertXWon.

! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:31:38'!
test13XWinsWhenCompletesRowNumber3
	
	game _ TerniLapilli new.

	game putXAt: 3 @ 1.
	game putOAt: 1 @ 1.
	game putXAt: 3 @ 2.
	game putOAt: 2 @ 1.
	game putXAt: 3 @ 3.
	self assertXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:35:10'!
test14XWinsWhenCompletesAColumn
	
	game _ TerniLapilli new.

	game putXAt: 1 @ 1.
	game putOAt: 2 @ 2.
	game putXAt: 2 @ 1.
	game putOAt: 3 @ 3.
	game putXAt: 3 @ 1.
	self assertXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:36:18'!
test15XWinsWhenCompletesDiagonalGoingDown
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 1 @ 2.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 3.
	game putXAt: 3 @ 3.
	self assertXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:37:09'!
test16XWinsWhenCompletesDiagonalGoingUp
	game _ TerniLapilli new.

	game putXAt: 1 @ 3.
	game putOAt: 1 @ 2.
	game putXAt: 2 @ 2.
	game putOAt: 2 @ 1.
	game putXAt: 3 @ 1.
	self assertXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 08:38:20'!
test17OWinsWhenCompletesARow
	
	game _ TerniLapilli new.
	game putXAt: 2 @ 1.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 2.
	game putXAt: 3 @ 1.
	game putOAt: 1 @ 3.
	self assertOWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 09:24:09'!
test18OCanNotMarkWhenXWon
	game _ TerniLapilli new.
	game putXAt: 1 @ 1.
	game putOAt: 2 @ 1.
	game putXAt: 1 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	self
		should: [ game putOAt: 3 @ 1 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli canNotPlayWhenGameIsOverErrorMessage
				equals: anError messageText.
			self assertOIsMarkedOn:
				{2 @ 1. 3 @ 1} ].
			
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 19:29:18'!
test19XCanNotMarkWhenXWon
	game _ TerniLapilli new.
	game putXAt: 2 @ 1.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 2.
	game putOAt: 3 @ 1.
	game putXAt: 2 @ 3.

	self 
		should: [ game  putXAt: 2 @ 3 ] 
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
				{2 @ 1. 2 @ 2. 2@3}
			 ]
		! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 19:29:30'!
test20XCanNotPlaceMoreThanThreePieces
	game _ TerniLapilli new.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 1 @ 2.
	game putXAt: 3 @ 1.
	game putOAt: 2 @ 3.
	self
		should: [ game putXAt: 3 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TerniLapilli playerXHasPlacedThreePieces
				equals: anError messageText.
			self assertXIsMarkedOn:
				{2 @ 2. 2 @ 1. 3 @ 1} ].
			
			! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:20'!
test21XCanSlideWhenAllXPiecesWerePlaced
	game _ TerniLapilli new.
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 1 @ 3.
	game putOAt: 3 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 2 @ 3.
	game slideXFrom: 2 @ 2 to: 1 @ 2.
	
	self assertXIsMarkedOn: {1 @ 2. 1 @ 3. 2 @ 1}.
	self assertIsPlayingO.	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test22OCanSlideWhenAllOPiecesWerePlaced
	
	game _ TerniLapilli new.
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 1@1 to: 2@2.


	self assertXIsMarkedOn: {1 @ 2. 2 @ 1. 1 @ 3}.
	self assertOIsMarkedOn: {2 @ 2. 3 @ 1. 2 @ 3}.
	self assertIsPlayingX.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test23CanNotSlideWithXToAnAlreadyMarkedPositionWithX

	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 1@1 to: 2@2.
				
	self 
		should: [ game slideXFrom: 1@2 to: 1@3 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 2@1. 1@3}
				andOOn:
					{2@2. 3@1. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test24CanNotSlideWithXToAnAlreadyMarkedPositionWithO

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 1@1 to: 2@2.
				
	self 
		should: [ game slideXFrom: 2@1 to: 3@1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 2@1. 1@3}
				andOOn:
					{2@2. 3@1. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test25CanNotSlideWithOToAnAlreadyMarkedPositionWithO
	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 2@1 to: 3@1.
					
	self 
		should: [ game slideOFrom: 1@1 to: 2@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 3@1. 1@3}
				andOOn:
					{1@1. 2@2. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:38'!
test26CanNotSlideWithOToAnAlreadyMarkedPositionWithX
	
	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
					
	self 
		should: [ game slideOFrom: 1@1 to: 2@1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 2@1. 1@3}
				andOOn:
					{1@1. 3@1. 2@3} ].
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test27XWinsSliding

	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 2@1 to: 3@1.
	game slideOFrom: 2@2 to: 3@3.
	game slideXFrom: 1@2 to: 2@2.
					
	self assertXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:38'!
test28OWinsSliding

	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 2@1 to: 3@1.
	game slideOFrom: 1@1 to: 2@1.
					
	self assertOWon.
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:38'!
test29XCanNotSlideWhenOWon
	game _ TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 2@1 to: 3@1.
	game slideOFrom: 1@1 to: 2@1.
					
	self 
		should: [ game slideXFrom: 3@1 to: 3@2. ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2.     3@1. 1@3}
				andOOn:
					{2@1. 2@2. 2@3}  ]
			

! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test30OCanNotSlideWhenXWon
	game _ TerniLapilli new.	
	
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	game putOAt: 2 @ 3.
	
	game slideXFrom: 2 @ 2 to: 1 @ 2.
	game slideOFrom: 3 @ 1 to: 2 @ 2.
	game slideXFrom: 2 @ 1 to: 3 @ 1.
	game slideOFrom: 2 @ 2 to: 3 @ 3.
	game slideXFrom: 1 @ 2 to: 2 @ 2.
	
	self should: [game slideOFrom: 1 @ 1 to: 2 @ 1 ]
		raise: self functionalException
		withExceptionDo: [ :anError | self assert: TerniLapilli canNotPlayWhenGameIsOverErrorMessage
				equals: anError messageText.
		self assertXIsMarkedOn:
					{2@2.     3@1. 1@3}
				andOOn:
					{1@1. 3@3. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:20'!
test30_01CanNotSlideXToAnInvalidPosition

	game _ TerniLapilli new.	
	
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	game putOAt: 2 @ 3.
	
	self 
		should: [game slideXFrom: 1 @ 3 to: 0 @ 3]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli illegalMovement.
			self assertXIsMarkedOn: { 2@2. 2@1. 1@3 } ]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test30_02CanNotSlideOToAnInvalidPosition

	game _ TerniLapilli new.	
	
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 3 @ 1.
	game putXAt: 1 @ 3.
	game putOAt: 2 @ 3.
	
	game slideXFrom: 1 @ 3 to: 1@ 2.
	self 
		should: [ game slideOFrom: 1@1 to: 0@1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli illegalMovement.
			self assertOIsMarkedOn: { 1@1. 3@1. 2@3 } ]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:20'!
test31DifferenceBetweenPositionsShouldNotBeGreaterThanOneWhenSliding
	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 1@2.
	game putXAt: 3@1.	
	game putOAt: 2@3.

	self 
		should: [ game slideXFrom: 3@1 to: 3@3 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli illegalMovement equals: anError messageText.
			self assertXIsMarkedOn:
					{2@2. 2@1. 3@1}
				andOOn:
					{1@1. 1@2. 2@3}  ]
			
			

! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test32OnlyPermittedXSlidingsBetweenAdjacentsPositions

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
	
	game slideXFrom: 2@2 to: 1@2.
	game slideOFrom: 3@1 to: 2@2.
	game slideXFrom: 2@1 to: 3@1.
	game slideOFrom: 2@2 to: 3@3.	
					
		self 
		should: [ game slideXFrom: 1@2 to: 3@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli illegalMovement equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 3@1. 1@3}
				andOOn:
					{1@1. 3@3. 2@3}   ]
			
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test33OnlyPermittedOSlidingsBetweenAdjacentsPositions
game _ TerniLapilli new.	

	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 1@2.
	game putXAt: 3@1.	
	game putOAt: 2@3.
	
	game slideXFrom: 3@1 to: 3@2.

	self 
		should: [ game slideOFrom: 2@3 to: 3@1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli illegalMovement equals: anError messageText.
			self assertXIsMarkedOn:
					{2@2. 2@1. 3@2}
				andOOn:
					{1@1. 1@2. 2@3}  ]
			
			

! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'JG 11/6/2018 20:34:51'!
test34CanNotMarkOutsideBoard
	game _ TerniLapilli new.
	#(0 4 ) do: [ :aPositionComponent |
		self assertCanNotMarkAt: aPositionComponent @ 1.
		self assertCanNotMarkAt: 1 @ aPositionComponent ].
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:20'!
test35CanNotSlideWithXFromAPositionMarkedWithO

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.
			
	self 
		should: [ game slideXFrom: 3@1 to: 3@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli playersCanOnlySlideTheirOwnPieces equals: anError messageText.
			self assertXIsMarkedOn:
					{2@2. 2@1. 1@3}
				andOOn:
					{1@1. 3@1. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:48:39'!
test36CanNotSlideWithOFromAPositionMarkedWithX

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	
	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 1@3.	
	game putOAt: 2@3.

	game slideXFrom: 2@2 to: 1@2.
			
	self 
		should: [ game slideOFrom: 2@1 to: 2@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TerniLapilli playersCanOnlySlideTheirOwnPieces equals: anError messageText.
			self assertXIsMarkedOn:
					{1@2. 2@1. 1@3}
				andOOn:
					{1@1. 3@1. 2@3} ].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:49:16'!
test37CanNotSlideXWhenPutingX

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.	

	self 
		should: [ game slideXFrom: 2@2 to: 1@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli  playerXHasPiecesToPlace.
			self assertXIsMarkedOn: { 2@2 } ]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:49:30'!
test38CanNotSlideOWhenPuttingO

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@3.

	self 
		should: [ game slideOFrom: 1@1 to: 1@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli  playerOHasPiecesToPlace.
			self assertOIsMarkedOn: { 1@1 } ]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:49:49'!
test39CanNotSlideXWhenPlayingO

	game _ TerniLapilli new.	
	game putXAt: 2@2.

	self 
		should: [ game slideXFrom: 2@2 to: 1@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli  notXTurnErrorMessage.
			self assertXIsMarkedOn: { 2@2 } ]
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'HAW 11/8/2018 11:50:01'!
test40CanNotSlideOWhenPlayingX

	game _ TerniLapilli new.	
	game putXAt: 2@2.
	game putOAt: 1@1.

	self 
		should: [ game slideOFrom: 1@1 to: 1@2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TerniLapilli  notOTurnErrorMessage.
			self assertOIsMarkedOn: { 1@1 } ]
	! !


!TerniLapilliTest methodsFor: 'testingLastMove' stamp: 'jml 11/10/2018 05:33:31'!
test41ThereWasNoPlay

	game _ TerniLapilli new.	

	self assert: (NoPlay new) equals: game lastPlay.! !

!TerniLapilliTest methodsFor: 'testingLastMove' stamp: 'jml 11/10/2018 05:42:19'!
test42LastPlayIsAnXPlacement

	game _ TerniLapilli new.
	
	game putXAt: 1 @ 1.

	self assert: (XPlacement at: 1@1) equals: game lastPlay.! !

!TerniLapilliTest methodsFor: 'testingLastMove' stamp: 'jml 11/10/2018 05:42:22'!
test43LastPlayIsAnOPlacement

	game _ TerniLapilli new.
		
	game 
		putXAt: 1 @ 1;
		putOAt: 1 @ 3.
	
	self assert: (OPlacement at: 1@3) equals: game lastPlay.! !

!TerniLapilliTest methodsFor: 'testingLastMove' stamp: 'jml 11/10/2018 05:42:55'!
test44LastPlayIsAnXMovement

	game _ TerniLapilli new.
	
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 1 @ 3.
	game putOAt: 3 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 2 @ 3.
	game slideXFrom: 2 @ 2 to: 1 @ 2.
		
	self assert: (XMovement from: 2@2 to: 1@2) equals: game lastPlay.! !

!TerniLapilliTest methodsFor: 'testingLastMove' stamp: 'jml 11/10/2018 05:42:03'!
test45LastPlayIsAnOMovement

	game _ TerniLapilli new.
	
	game putXAt: 2 @ 2.
	game putOAt: 1 @ 1.
	game putXAt: 1 @ 3.
	game putOAt: 3 @ 1.
	game putXAt: 2 @ 1.
	game putOAt: 2 @ 3.
	game slideXFrom: 2 @ 2 to: 1 @ 2.
	game slideOFrom: 2 @ 3 to: 3 @ 3. 
	
	self assert: (OMovement from: 2@3 to: 3@3) equals: game lastPlay.! !
