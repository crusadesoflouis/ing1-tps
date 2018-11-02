!classDefinition: #TerniLapilliTest category: #TerniLapilli!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:03:22'!
test01NewGameIsNotFinished

	|game|
	
	game := TerniLapilli new.
	
	self deny: game finished.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:03:55'!
test02NewGameIsInInitialPhase

	|game|
	game := TerniLapilli new.
	self assert: game inInitialPhase.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:10:31'!
test03OCannotPlayFirst

	|game|
	game := TerniLapilli new.
	self should: [game setO: 1@1] raise: Exception withExceptionDo: [ :exception |
		self assert:  (exception messageText ) equals: (TerniLapilli invalidTurnErrorDescription)
	].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:05:14'!
test04CanPlayXAtSomePosition

	|game position|
	position := 1@1.
	game := TerniLapilli new.
	game setX: position.
	self assert: (game hasX: position).
	self deny: (game  hasO: position).
	self deny: (game  isEmpty: position).
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:05:54'!
test05AnUnusedPositionIsEmpty
	|game position anotherPosition|
	position := 1@1.
	anotherPosition  := position+1.	
	game := TerniLapilli new.
	game setX: position.
	self assert: (game  isEmpty: anotherPosition).
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:10:23'!
test06XCannotPlayTwiceInARow
	|game position anotherPosition|
	position := 1@1.
	anotherPosition  := position+1.	
	game := TerniLapilli new.
	game setX: position.
	self should: [game setX: anotherPosition ] raise: Exception withExceptionDo: [ :exception |
		self assert:  (exception messageText ) equals: (TerniLapilli invalidTurnErrorDescription)
	].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:18:09'!
test07CannotPlayAtInvalidPosition
	|game aPosition |
	
	aPosition := 0@1.
	
	game := TerniLapilli new.
	
	self should: [game setX: aPosition ] raise: Exception withExceptionDo: [ :exception |
		self assert:  (exception messageText ) equals: (TerniLapilli invalidPositionErrorDescription)
	].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:22:29'!
test08CannotPlayAtAnOccupiedPosition
	
	| aPosition game |
	
	game := TerniLapilli new.
	aPosition := 2@2.
	
	game setX: aPosition.
	
	self should: [ game setO: aPosition ] raise: Error withExceptionDo: [ :anException |
		self assert: anException messageText equals: TerniLapilli occupiedPositionErrorDescription
	].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:30:28'!
test09WonGameDuringInitialPhaseIsFinished
	
	| game |
	
	game := TerniLapilli new.
	
	game setX: 1@1.
	game setO: 2@1.
	game setX: 1@2.
	game setO: 2@2.
	
	self deny: game finished.
	game setX: 1@3.
	self assert: game finished.
	
	self should: [ game setO: 3@3 ] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli finishedGameErrorDescription
	].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:57:58'!
test10InitiallyWonGameForRowIsFinished
	
	| game |
	
	game := TerniLapilli new.
	
	game setX: 1@1.
	game setO: 2@2.
	game setX: 2@1.
	game setO: 3@3.
	
	self deny: game finished.
	game setX: 3@1.
	self assert: game finished.
	
	self should: [ game setO: 1@3 ] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli finishedGameErrorDescription
	].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:58:43'!
test11InitiallyWonGameForDiagonalIsFinished
	
	| game |
	
	game := TerniLapilli new.
	
	game setX: 1@1.
	game setO: 1@3.
	game setX: 2@2.
	game setO: 3@1.
	
	self deny: game finished.
	game setX: 3@3.
	self assert: game finished.
	
	self should: [ game setO: 2@3 ] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli finishedGameErrorDescription
	].! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board isXturn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:55:39'!
anyColumnIsFullOf: aPiece
	
	 ^ #(1 2 3) anySatisfy: [ :col | self col: col isFullOf: aPiece ]! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 21:02:02'!
anyDiagonalIsFullOf: aPiece
	
	^ (self leftDiagonalIsFullOf: aPiece) or: [ self rightDiagonalIsFullOf: aPiece ]! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:51:52'!
anyRowIsFullOf: aPiece
	
	^ #(1 2 3) anySatisfy: [ :row | self row: row isFullOf: aPiece ]! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:56:05'!
col: col isFullOf: aPiece
	
	^ #(1 2 3) allSatisfy: [ :row | self has: aPiece at: col@row ]! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:43:38'!
finished
	
	^ self wonForX or: [ self wonForO]! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:52:31'!
has: aPiece at: aPosition
	
	^ (board includesKey: aPosition) and: [ (board at: aPosition) = aPiece ]! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 19:43:40'!
hasO: aPoint 
	
	^false! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 19:43:28'!
hasX: aPoint 
	
	^true! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 19:23:01'!
inInitialPhase
	
	^true! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 19:53:42'!
initialize

	board := Dictionary new.	
	isXturn:= true.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 19:57:05'!
isEmpty: aPosition 

	^(board includesKey: aPosition) not! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:16:41'!
isValidCoordinate: aCoordinate
	
	^ aCoordinate between: 1 and: 3! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:17:49'!
isValidPosition: aPosition
	
	^ (self isValidCoordinate: aPosition x) and: [ self isValidCoordinate: aPosition y ]! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 21:07:34'!
leftDiagonalIsFullOf: aPiece
	
	^ (Array with: 1@1 with: 2@2 with: 3@3) allSatisfy: [ :pos | self has: aPiece at: pos ]! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 21:08:09'!
rightDiagonalIsFullOf: aPiece
	
	^ (Array with: 1@3 with: 2@2 with: 3@1) allSatisfy: [ :pos | self has: aPiece at: pos ]! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:48:18'!
row: row isFullOf: aPiece
	
	^ #(1 2 3) allSatisfy: [ :col | self has: aPiece at: col@row ]! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:34:11'!
set: aPiece at: aPosition
	(self finished) ifTrue: [ self error: self class finishedGameErrorDescription ].
	(self isValidPosition: aPosition) ifFalse: [ self error: self class invalidPositionErrorDescription ].	
	(self isEmpty: aPosition) ifFalse: [ self error: self class occupiedPositionErrorDescription ].
	
	board at: aPosition put: aPiece.
	
	isXturn := isXturn not.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:11:54'!
setO: aPosition

	isXturn ifTrue: [self error: self class invalidTurnErrorDescription].
	
	self set: $O at: aPosition.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:13:26'!
setX: aPosition

	isXturn ifFalse: [self error: self class invalidTurnErrorDescription].
	
	self set: $X at: aPosition.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:54:37'!
wonForO
	
	^ (self anyRowIsFullOf: $O) or: [ (self anyColumnIsFullOf: $O) or: [ self anyDiagonalIsFullOf: $O ] ]! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:54:01'!
wonForX
	
	^ (self anyRowIsFullOf: $X) or: [ (self anyColumnIsFullOf: $X) or: [ self anyDiagonalIsFullOf: $X ] ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'la 11/1/2018 20:09:56'!
invalidPositionErrorDescription

	^ 'invalid position'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'la 11/1/2018 20:09:31'!
invalidTurnErrorDescription

	^'turno invalido'! !


!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:34:33'!
finishedGameErrorDescription
	
	^ 'game is finished'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'la 11/1/2018 20:24:14'!
occupiedPositionErrorDescription
	
	^ 'occupied position'! !
