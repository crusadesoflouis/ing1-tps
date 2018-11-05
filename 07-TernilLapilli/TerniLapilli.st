!classDefinition: #TerniLapilliTest category: #TerniLapilli!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/5/2018 18:47:09'!
test04CanSetPiecesAtSomePositions

	| game positionX positionO |
	
	positionX := 1@1.
	positionO := 2@2.

	game := TerniLapilli new.
	game playAt: positionX.
	game playAt: positionO.
	
	self assert: (game hasX: positionX).
	self deny: (game hasO: positionX).
	self deny: (game isEmpty: positionX).
	
	self deny: (game hasX: positionO).
	self assert: (game hasO: positionO).
	self deny: (game isEmpty: positionO).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/5/2018 18:51:19'!
test05AnUnusedPositionIsEmpty
	
	| game position anotherPosition |
	
	position := 1@1.
	anotherPosition  := position+1.
	"TODO chequear el resto del tablero"
	game := TerniLapilli new.
	game playAt: position.

	self assert: (game  isEmpty: anotherPosition).
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/5/2018 18:52:09'!
test07CannotPlayAtInvalidPosition
	|game anInvalidPosition |
	
	anInvalidPosition := 0@1.
	
	game := TerniLapilli new.
	
	self should: [game playAt: anInvalidPosition ] raise: Exception withExceptionDo: [ :exception |
		self assert:  (exception messageText ) equals: (TerniLapilli invalidPositionErrorDescription)
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/5/2018 18:52:30'!
test08CannotPlayAtAnOccupiedPosition
	
	| aPosition game |
	
	game := TerniLapilli new.
	aPosition := 2@2.
	
	game playAt: aPosition.
	
	self should: [ game playAt: aPosition ] raise: Error withExceptionDo: [ :anException |
		self assert: anException messageText equals: TerniLapilli occupiedPositionErrorDescription.
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/5/2018 18:53:06'!
test09WonGameDuringInitialPhaseIsFinished
	
	| game |
	
	game := TerniLapilli new.
	
	game playAt: 1@1.
	game playAt: 2@1.
	game playAt: 1@2.
	game playAt: 2@2.
	game playAt: 1@3.
	
	self assert: game finished.
	
	self should: [ game playAt: 3@3 ] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli finishedGameErrorDescription
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/5/2018 18:53:27'!
test10InitiallyWonGameForRowIsFinished
	
	| game |
	
	game := TerniLapilli new.
	
	game playAt: 1@1.
	game playAt: 2@2.
	game playAt: 2@1.
	game playAt: 3@3.
	game playAt: 3@1.
	
	self assert: game finished.
	
	self should: [ game playAt: 1@3 ] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli finishedGameErrorDescription
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/5/2018 18:53:58'!
test11InitiallyWonGameForDiagonalIsFinished
	
	| game |
	
	game := TerniLapilli new.
	
	game playAt: 1@1.
	game playAt: 1@3.
	game playAt: 2@2.
	game playAt: 3@1.
	game playAt: 3@3.
	
	self assert: game finished.
	
	self should: [ game playAt: 2@3 ] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli finishedGameErrorDescription
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/5/2018 18:54:14'!
test12InitiallyWonGameForColumnsIsFinished
	
	| game |
	
	game := TerniLapilli new.
	
	game playAt: 1@1.
	game playAt: 2@2.
	game playAt: 1@2.
	game playAt: 3@3.
	game playAt: 1@3.
	
	self assert: game finished.
	
	self should: [ game playAt: 2@3 ] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli finishedGameErrorDescription
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/5/2018 18:54:30'!
test13gameInitialPhaseFinishedWhitoutWinner
	
	| game |
	
	game := TerniLapilli new.
	
	game playAt: 1@1.
	game playAt: 2@1.
	game playAt: 1@2.
	game playAt: 2@2.
	game playAt: 2@3.
	game playAt: 1@3.
	
	self deny: game finished.
	self deny: game inInitialPhase.
	
	self should: [ game playAt: 3@3 ] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli cannotAddMorePieces
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/5/2018 18:54:39'!
test14gameInitialPhaseNotFinished
	
	| game |
	
	game := TerniLapilli new.
	game playAt: 1@1.
	
	self deny: game finished.
	self assert: game inInitialPhase.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/5/2018 18:55:11'!
test15InvalidMovementBecauseOfInvalidPositions
	
	| game |
	
	game := TerniLapilli new.
	
	game playAt: 1@1.
	game playAt: 3@1.
	game playAt: 1@2.
	game playAt: 3@2.
	game playAt: 3@3.
	game playAt: 1@3.
	
	self should: [game moveFrom: 1@1 to: 0@0] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli invalidPositionErrorDescription
	].
	
	self should: [game moveFrom: 4@3 to: 2@2] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli invalidPositionErrorDescription
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/5/2018 18:56:00'!
test16InvalidMovementBecauseOfMissingPiece
	
	| game |
	
	game := TerniLapilli new.
	
	game playAt: 1@1.
	game playAt: 3@1.
	game playAt: 1@2.
	game playAt: 3@2.
	game playAt: 3@3.
	game playAt: 1@3.
	
	self should: [game moveFrom: 3@1 to: 2@1 ] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli missingPieceErrorDescription
	].
	
	self should: [game moveFrom: 2@2 to: 2@1] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli missingPieceErrorDescription
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/5/2018 18:56:35'!
test17InvalidMovementBecauseOfUnconnectedPositions
	
	| game |
	
	game := TerniLapilli new.
	
	game playAt: 1@1.
	game playAt: 3@1.
	game playAt: 1@2.
	game playAt: 3@2.
	game playAt: 3@3.
	game playAt: 1@3.
	
	self should: [ game moveFrom: 1@2 to: 2@1 ] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli invalidMoveErrorDescription
	].
	
	self should: [ game moveFrom: 1@1 to: 2@3 ] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli invalidMoveErrorDescription
	].! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board isXturn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'playing' stamp: 'jml 11/5/2018 18:59:36'!
playAt: aPosition
	
	self set: self currentPiece at: aPosition.! !


!TerniLapilli methodsFor: 'testing' stamp: 'la 11/5/2018 16:34:31'!
finished
	
	^ self wonForX or: [ self wonForO]! !

!TerniLapilli methodsFor: 'testing' stamp: 'jml 11/5/2018 17:38:14'!
hasO: aPosition

	^ self has: $O at: aPosition! !

!TerniLapilli methodsFor: 'testing' stamp: 'jml 11/5/2018 17:38:02'!
hasX: aPosition
	
	^ self has: $X at: aPosition! !

!TerniLapilli methodsFor: 'testing' stamp: 'jml 11/5/2018 17:05:43'!
inInitialPhase
	
	^ board size < 6! !

!TerniLapilli methodsFor: 'testing' stamp: 'la 11/1/2018 19:57:05'!
isEmpty: aPosition 

	^(board includesKey: aPosition) not! !

!TerniLapilli methodsFor: 'testing' stamp: 'la 11/1/2018 20:54:37'!
wonForO
	
	^ (self anyRowIsFullOf: $O) or: [ (self anyColumnIsFullOf: $O) or: [ self anyDiagonalIsFullOf: $O ] ]! !

!TerniLapilli methodsFor: 'testing' stamp: 'la 11/1/2018 20:54:01'!
wonForX
	
	^ (self anyRowIsFullOf: $X) or: [ (self anyColumnIsFullOf: $X) or: [ self anyDiagonalIsFullOf: $X ] ]! !


!TerniLapilli methodsFor: 'testing - private' stamp: 'la 11/1/2018 20:55:39'!
anyColumnIsFullOf: aPiece
	
	 ^ #(1 2 3) anySatisfy: [ :col | self col: col isFullOf: aPiece ]! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'la 11/1/2018 21:02:02'!
anyDiagonalIsFullOf: aPiece
	
	^ (self leftDiagonalIsFullOf: aPiece) or: [ self rightDiagonalIsFullOf: aPiece ]! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'la 11/1/2018 20:51:52'!
anyRowIsFullOf: aPiece
	
	^ #(1 2 3) anySatisfy: [ :row | self row: row isFullOf: aPiece ]! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'la 11/1/2018 20:56:05'!
col: col isFullOf: aPiece
	
	^ #(1 2 3) allSatisfy: [ :row | self has: aPiece at: col@row ]! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'la 11/1/2018 20:52:31'!
has: aPiece at: aPosition
	
	^ (board includesKey: aPosition) and: [ (board at: aPosition) = aPiece ]! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'jml 11/5/2018 18:09:25'!
horizontalDistanceBetween: fromPosition and: toPosition
	
	^ (fromPosition x - toPosition x) abs! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'jml 11/5/2018 18:13:37'!
isNotDiamondPosition: aPosition
	
	^ (aPosition x + aPosition y) even! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'la 11/1/2018 20:16:41'!
isValidCoordinate: aCoordinate
	
	^ aCoordinate between: 1 and: 3! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'la 11/1/2018 20:17:49'!
isValidPosition: aPosition
	
	^ (self isValidCoordinate: aPosition x) and: [ self isValidCoordinate: aPosition y ]! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'la 11/1/2018 21:07:34'!
leftDiagonalIsFullOf: aPiece
	
	^ (Array with: 1@1 with: 2@2 with: 3@3) allSatisfy: [ :pos | self has: aPiece at: pos ]! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'jml 11/5/2018 18:09:43'!
positionsAreAdjacent: fromPosition and: toPosition
	
	| horizontalDistance verticalDistance |
	
	horizontalDistance := self horizontalDistanceBetween: fromPosition and: toPosition.
	verticalDistance := self verticalDistanceBetween: fromPosition and: toPosition.
	
	^ horizontalDistance + verticalDistance = 1! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'jml 11/5/2018 18:05:54'!
positionsAreConnected: fromPosition and: toPosition
	
	^ (self positionsAreAdjacent: fromPosition and: toPosition) or: [ self positionsAreDiagonallyConnected: fromPosition and: toPosition ]! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'jml 11/5/2018 18:11:01'!
positionsAreDiagonallyConnected: fromPosition and: toPosition
	
	| horizontalDistance verticalDistance |
	
	horizontalDistance := self horizontalDistanceBetween: fromPosition and: toPosition.
	verticalDistance := self verticalDistanceBetween: fromPosition and: toPosition.
	
	^ (horizontalDistance = 1) and: [ verticalDistance = 1 and: [ self isNotDiamondPosition: fromPosition ] ]! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'la 11/1/2018 21:08:09'!
rightDiagonalIsFullOf: aPiece
	
	^ (Array with: 1@3 with: 2@2 with: 3@1) allSatisfy: [ :pos | self has: aPiece at: pos ]! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'la 11/1/2018 20:48:18'!
row: row isFullOf: aPiece
	
	^ #(1 2 3) allSatisfy: [ :col | self has: aPiece at: col@row ]! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'jml 11/5/2018 18:09:34'!
verticalDistanceBetween: fromPosition and: toPosition
	
	^ (fromPosition y - toPosition y) abs! !


!TerniLapilli methodsFor: 'initialization' stamp: 'jml 11/5/2018 17:05:09'!
initialize

	board := Dictionary new.	
	isXturn:= true.! !


!TerniLapilli methodsFor: 'playing - private' stamp: 'jml 11/5/2018 18:58:54'!
moveFrom: fromPosition to: toPosition 
	
	((self isValidPosition: fromPosition) and: [ self isValidPosition: toPosition ]) ifFalse: [
		self error: self class invalidPositionErrorDescription
	].
	
	(self has: self currentPiece at: fromPosition) ifFalse: [
		self error: self class missingPieceErrorDescription
	].
	
	(self positionsAreConnected: fromPosition and: toPosition) ifFalse: [
		self error: self class invalidMoveErrorDescription
	].
	
	" TODO move "! !

!TerniLapilli methodsFor: 'playing - private' stamp: 'jml 11/5/2018 17:28:24'!
set: aPiece at: aPosition
	self finished ifTrue: [ self error: self class finishedGameErrorDescription ].
	self inInitialPhase ifFalse: [ self error: self class cannotAddMorePieces ].
	(self isValidPosition: aPosition) ifFalse: [ self error: self class invalidPositionErrorDescription ].	
	(self isEmpty: aPosition) ifFalse: [ self error: self class occupiedPositionErrorDescription ].
	
	board at: aPosition put: aPiece.
	
	isXturn := isXturn not.! !


!TerniLapilli methodsFor: 'accessing - private' stamp: 'jml 11/5/2018 18:59:53'!
currentPiece
	
	^ isXturn ifTrue: [ $X ] ifFalse: [ $O ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'jml 11/5/2018 17:26:23'!
cannotAddMorePieces
	
	^ 'cannot add more than 6 pieces'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'la 11/1/2018 20:34:33'!
finishedGameErrorDescription
	
	^ 'game is finished'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'jml 11/5/2018 17:25:45'!
invalidMoveErrorDescription

	^ 'invalid move'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'la 11/1/2018 20:09:56'!
invalidPositionErrorDescription

	^ 'invalid position'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'jml 11/5/2018 17:26:04'!
invalidTurnErrorDescription

	^ 'invalid turn'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'jml 11/5/2018 17:35:19'!
missingPieceErrorDescription
	
	^ 'piece not found'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'la 11/1/2018 20:24:14'!
occupiedPositionErrorDescription
	
	^ 'occupied position'! !
