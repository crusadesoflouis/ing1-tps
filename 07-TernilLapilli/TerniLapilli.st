!classDefinition: #TerniLapilliTest category: #TerniLapilli!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/5/2018 19:23:17'!
test01BoardIsInitiallyEmpty
	
	| game |
	
	game := TerniLapilli new.
	
	self assert: (self boardIsEmpty: game).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/6/2018 15:09:55'!
test02OCanPlayAtSomePosition

	| game positionX positionO restOfPositions |
	
	positionX := 1@1.
	positionO:= 1@2.
	restOfPositions := self allPositions.
	restOfPositions remove: positionX.

	game := TerniLapilli new.
	game placePieceAt: positionX.
	game placePieceAt: positionO.
	
	self assert: (game hasOAt: positionO).
	self deny: (game hasXAt: positionO).
	self deny: (game positionIsEmpty: positionO).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/6/2018 15:09:55'!
test02XCanPlayAtSomePosition

	| game position restOfPositions |
	
	position := 1@1.
	restOfPositions := self allPositions.
	restOfPositions remove: position.
	game := TerniLapilli new.
	game placePieceAt: position.
	
	self assert: (game hasXAt: position).
	self deny: (game hasOAt: position).
	self deny: (game positionIsEmpty: position).	
	self assert: (restOfPositions allSatisfy: [ :aPosition | game positionIsEmpty: aPosition ]).
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/6/2018 15:09:55'!
test03OCanPlayAfterX

	| game xPosition oPosition |
	
	xPosition := 1@1.
	oPosition := 1@3.
	
	game := TerniLapilli new.
	game placePieceAt: xPosition.
	game placePieceAt: oPosition.

	self assert: (game hasOAt: oPosition).
	self deny: (game hasXAt: oPosition).
	self deny: (game positionIsEmpty: oPosition).
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/6/2018 15:00:01'!
test07CannotPlayAtInvalidPosition
	|game anInvalidPosition |
	
	"TODO hacer cuatro tests separados"
	
	anInvalidPosition := 0@1.
	
	game := TerniLapilli new.
	
	self should: [game placePieceAt: anInvalidPosition ] raise: Exception withExceptionDo: [ :exception |
		self assert:  (exception messageText ) equals: (TerniLapilli invalidPositionErrorDescription).
		self assert: (self boardIsEmpty: game).
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/6/2018 15:09:55'!
test08CannotPlayAtAnOccupiedPosition
	
	| aPosition game |
	
	game := TerniLapilli new.
	aPosition := 2@2.
	
	game placePieceAt: aPosition.
	
	self should: [ game placePieceAt: aPosition ] raise: Error withExceptionDo: [ :anException |
		self assert: anException messageText equals: TerniLapilli occupiedPositionErrorDescription.
		self assert: (game hasXAt: aPosition).
		self deny: (game hasOAt: aPosition).
		self deny: (game positionIsEmpty: aPosition).
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/7/2018 00:49:44'!
test09InitiallyWonGameForColumnsIsFinished
	
	| game |
	
	game := TerniLapilli new.
	
	game placePieceAt: 1@1.
	game placePieceAt: 2@2.
	game placePieceAt: 1@2.
	game placePieceAt: 3@3.
	game placePieceAt: 1@3.
	
	self assert: game isFinished.
	self assert: game isWonForX.
	self deny: game isWonForO.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/7/2018 00:49:44'!
test10InitiallyWonGameForRowIsFinished
	
	| game |
	
	game := TerniLapilli new.
	
	game placePieceAt: 1@1.
	game placePieceAt: 2@2.
	game placePieceAt: 2@1.
	game placePieceAt: 3@3.
	game placePieceAt: 3@1.

	self assert: game isFinished.
	self assert: game isWonForX.
	self deny: game isWonForO.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/7/2018 00:49:44'!
test11InitiallyWonGameForDiagonalIsFinished
	
	| game |
	
	game := TerniLapilli new.
	
	game placePieceAt: 1@1.
	game placePieceAt: 1@3.
	game placePieceAt: 2@2.
	game placePieceAt: 3@1.
	game placePieceAt: 3@3.
	
	self assert: game isFinished.
	self assert: game isWonForX.
	self deny: game isWonForO.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/6/2018 15:07:36'!
test12CannotPlayWhenGameIsFinished
	| game |
	
	game := TerniLapilli new.
	
	game placePieceAt: 1@1.
	game placePieceAt: 2@1.
	game placePieceAt: 1@2.
	game placePieceAt: 2@2.
	game placePieceAt: 1@3.
	
	self should: [ game placePieceAt: 2@3 ] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli finishedGameErrorDescription.
		self assert: (game positionIsEmpty: 2@3).
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/6/2018 15:14:50'!
test13GameInitialPhaseFinishedWhitoutWinner
	
	| game |
	
	game := TerniLapilli new.
	
	game placePieceAt: 1@1.
	game placePieceAt: 2@1.
	game placePieceAt: 1@2.
	game placePieceAt: 2@2.
	game placePieceAt: 2@3.
	game placePieceAt: 1@3.
	
	self deny: game isFinished.
	
	self should: [ game placePieceAt: 3@3 ] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli cannotAddMorePieces.
		self assert: (game positionIsEmpty: 3@3).
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/6/2018 15:15:01'!
test14gameInitialPhaseNotFinished
	
	| game |
	
	game := TerniLapilli new.
	game placePieceAt: 1@1.
	
	self deny: game isFinished.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/6/2018 15:09:45'!
test15InvalidMovementBecauseOfInvalidPositions
	
	| game |
	
	game := TerniLapilli new.
	
	game placePieceAt: 1@1.
	game placePieceAt: 3@1.
	game placePieceAt: 1@2.
	game placePieceAt: 3@2.
	game placePieceAt: 3@3.
	game placePieceAt: 1@3.
	
	self should: [game moveFrom: 1@1 to: 0@0] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli invalidPositionErrorDescription.
		self assert: (game hasXAt: 1@1).
	].
	
	self should: [game moveFrom: 4@3 to: 2@2] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli invalidPositionErrorDescription.
		self assert: (game positionIsEmpty: 2@2).	
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/6/2018 15:09:55'!
test16InvalidMovementBecauseOfMissingPiece
	
	| game |
	
	game := TerniLapilli new.
	
	game placePieceAt: 1@1.
	game placePieceAt: 3@1.
	game placePieceAt: 1@2.
	game placePieceAt: 3@2.
	game placePieceAt: 3@3.
	game placePieceAt: 1@3.
	
	self should: [game moveFrom: 3@1 to: 2@1 ] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli missingPieceErrorDescription.
		self assert: (game hasOAt: 3@1).
		self assert: (game positionIsEmpty: 2@1).
	].
	
	self should: [game moveFrom: 2@2 to: 2@1] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli missingPieceErrorDescription.
		self assert: (game positionIsEmpty: 2@2).
		self assert: (game positionIsEmpty: 2@1)
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/6/2018 15:09:45'!
test17InvalidMovementBecauseOfUnconnectedPositions
	
	| game |
	
	game := TerniLapilli new.
	
	game placePieceAt: 1@1.
	game placePieceAt: 3@1.
	game placePieceAt: 1@2.
	game placePieceAt: 3@2.
	game placePieceAt: 3@3.
	game placePieceAt: 1@3.
	
	self should: [ game moveFrom: 1@2 to: 2@1 ] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli invalidMoveErrorDescription.
		self assert: (game hasXAt: 1@2).
		self assert: (game positionIsEmpty: 2@1)
	].
	
	self should: [ game moveFrom: 1@1 to: 2@3 ] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli invalidMoveErrorDescription.
		self assert: (game hasXAt: 1@1).
		self assert: (game positionIsEmpty: 2@3)	
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/7/2018 00:08:03'!
test17_02InvalidMovementBecauseOfOccupiedDestination
	
	| game |
	
	game := TerniLapilli new.
	
	game placePieceAt: 1@1.
	game placePieceAt: 3@1.
	game placePieceAt: 1@2.
	game placePieceAt: 3@2.
	game placePieceAt: 3@3.
	game placePieceAt: 2@3.
	
	self should: [ game moveFrom: 3@3 to: 2@3 ] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli occupiedPositionErrorDescription.
		self assert: (game hasXAt: 3@3).
		self assert: (game hasOAt: 2@3).
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/6/2018 15:09:45'!
test18CanMove
	
	| game |
	
	game := TerniLapilli new.
	
	game placePieceAt: 1@1.
	game placePieceAt: 3@1.
	game placePieceAt: 1@2.
	game placePieceAt: 3@2.
	game placePieceAt: 3@3.
	game placePieceAt: 1@3.
	game moveFrom: 1@1 to: 2@2.

	self assert: (game positionIsEmpty: 1@1).
	self assert: (game hasXAt: 2@2).
	self deny: game isFinished
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/6/2018 15:09:55'!
test19OCanMoveAfterX
	
	| game |
	
	game := TerniLapilli new.
	
	game placePieceAt: 1@1.
	game placePieceAt: 3@1.
	game placePieceAt: 1@2.
	game placePieceAt: 3@2.
	game placePieceAt: 3@3.
	game placePieceAt: 1@3.
	game moveFrom: 1@1 to: 2@2.
	game moveFrom: 1@3 to: 2@3.

	self assert: (game positionIsEmpty: 1@3).
	self assert: (game hasOAt: 2@3).
	self deny: game isFinished.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/6/2018 15:00:01'!
test20WonAfterAMove
	
	| game |
	
	game := TerniLapilli new.
	
	game placePieceAt: 1@1.
	game placePieceAt: 3@1.
	game placePieceAt: 1@2.
	game placePieceAt: 3@2.
	game placePieceAt: 3@3.
	game placePieceAt: 1@3.
	game moveFrom: 1@2 to: 2@2.
	
	self assert: game isFinished
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/6/2018 15:09:55'!
test21CannotMoveWhenGameIsFinished
	| game |
	game := TerniLapilli new.
	
	game placePieceAt: 1@1.
	game placePieceAt: 3@1.
	game placePieceAt: 1@2.
	game placePieceAt: 3@2.
	game placePieceAt: 3@3.
	game placePieceAt: 1@3.
	game moveFrom: 1@2 to: 2@2.
	
	self should: [ game moveFrom: 3@1 to: 2@1 ] raise: Error withExceptionDo: [ : anException |
		self assert: anException messageText equals: TerniLapilli finishedGameErrorDescription.
		self assert: (game hasOAt: 3@1).
		self assert: (game positionIsEmpty: 2@1).
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/6/2018 15:00:01'!
test22CannontMoveDuringInitialPhase

	| game |	
	game := TerniLapilli new.
	game placePieceAt: 1@1.
	game placePieceAt: 1@2.
	
	self should: [ game moveFrom: 1@1 to: 2@1. ] raise: Error withExceptionDo: [ :anException |
		self assert: anException messageText equals: TerniLapilli cannotMoveYetErrorDescription.
	].
	! !


!TerniLapilliTest methodsFor: 'positions' stamp: 'jml 11/5/2018 19:14:42'!
allPositions
	| positions |
	
	positions := Set new.
	
	(1 to: 3) do: [ :row |
		(1 to: 3) do: [ :col |
			positions add: (Point x: col y: row)
		]
	].
	
	^ positions! !


!TerniLapilliTest methodsFor: 'checking' stamp: 'jml 11/6/2018 15:07:35'!
boardIsEmpty: aGame
	
	^ self allPositions allSatisfy: [ :aPosition | aGame positionIsEmpty: aPosition ]! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'playing' stamp: 'jml 11/7/2018 00:33:28'!
moveFrom: fromPosition to: toPosition 
	
	state moveFrom: fromPosition to: toPosition! !

!TerniLapilli methodsFor: 'playing' stamp: 'jml 11/7/2018 00:33:35'!
placePieceAt: aPosition
	
	state placePieceAt: aPosition! !


!TerniLapilli methodsFor: 'testing' stamp: 'jml 11/7/2018 00:13:05'!
isFinished
	
	^ state isFinished ! !

!TerniLapilli methodsFor: 'testing' stamp: 'jml 11/7/2018 00:49:32'!
isWonForO
	
	^ state isWonForO! !

!TerniLapilli methodsFor: 'testing' stamp: 'jml 11/7/2018 00:49:44'!
isWonForX
	
	^ state isWonForX! !


!TerniLapilli methodsFor: 'board' stamp: 'jml 11/6/2018 15:09:55'!
hasOAt: aPosition

	^ self has: $O at: aPosition! !

!TerniLapilli methodsFor: 'board' stamp: 'jml 11/6/2018 15:09:45'!
hasXAt: aPosition
	
	^ self has: $X at: aPosition! !

!TerniLapilli methodsFor: 'board' stamp: 'jml 11/6/2018 15:07:35'!
positionIsEmpty: aPosition 

	^ (board includesKey: aPosition) not! !


!TerniLapilli methodsFor: 'initialization' stamp: 'jml 11/6/2018 14:33:16'!
initialize

	board := Dictionary new.	
	state := XIsPlacingState for: self.! !


!TerniLapilli methodsFor: 'playing - private' stamp: 'jml 11/7/2018 00:08:45'!
move: aPiece from: fromPosition to: toPosition
	
	(self isValidPosition: fromPosition) ifFalse: [
		self error: self class invalidPositionErrorDescription
	].
	
	(self isValidPosition: toPosition) ifFalse: [
		self error: self class invalidPositionErrorDescription
	].
	
	(self positionsAreConnected: fromPosition and: toPosition) ifFalse: [
		self error: self class invalidMoveErrorDescription
	].
	
	(self has: aPiece at: fromPosition) ifFalse: [
		self error: self class missingPieceErrorDescription
	].
	
	(self positionIsEmpty: toPosition) ifFalse: [
		self error: self class occupiedPositionErrorDescription
	].
	
	board removeKey: fromPosition.
	board at: toPosition put: aPiece.
	! !

!TerniLapilli methodsFor: 'playing - private' stamp: 'jml 11/7/2018 00:48:27'!
moveOFrom: fromPosition to: toPosition
	
	| newState |
	
	self move: $O from: fromPosition to: toPosition.
	
	newState := (self isWinning: $O)
		ifTrue: [ OHasWonState ]
		ifFalse: [ XIsMovingState ]
	.
	
	state := newState for: self.! !

!TerniLapilli methodsFor: 'playing - private' stamp: 'jml 11/7/2018 00:48:54'!
moveXFrom: fromPosition to: toPosition
	
	| newState |
	
	self move: $X from: fromPosition to: toPosition.
	
	newState := (self isWinning: $X)
		ifTrue: [ XHasWonState ]
		ifFalse: [ OIsMovingState ]
	.
	
	state := newState for: self.! !

!TerniLapilli methodsFor: 'playing - private' stamp: 'jml 11/7/2018 00:18:39'!
place: aPiece at: aPosition
	
	(self isValidPosition: aPosition) ifFalse: [
		self error: self class invalidPositionErrorDescription
	].

	(self positionIsEmpty: aPosition) ifFalse: [
		self error: self class occupiedPositionErrorDescription
	].
	
	board at: aPosition put: aPiece.! !

!TerniLapilli methodsFor: 'playing - private' stamp: 'jml 11/7/2018 00:46:19'!
placeOAt: aPosition 
	
	| newState |
	
	self place: $O at: aPosition.
	
	newState := (self isWinning: $O)
		ifTrue: [ OHasWonState ]
		ifFalse: [ board size = 6
			ifTrue: [ XIsMovingState ]
			ifFalse: [ XIsPlacingState ]
		]
	.
	
	state := newState for: self.! !

!TerniLapilli methodsFor: 'playing - private' stamp: 'jml 11/7/2018 00:46:34'!
placeXAt: aPosition 
	
	| newState |
	
	self place: $X at: aPosition.
	
	newState := (self isWinning: $X)
		ifTrue: [ XHasWonState ]
		ifFalse: [ OIsPlacingState ]
	.
	
	state := newState for: self.! !


!TerniLapilli methodsFor: 'board - private' stamp: 'la 11/1/2018 20:55:39'!
anyColumnIsFullOf: aPiece
	
	 ^ #(1 2 3) anySatisfy: [ :col | self col: col isFullOf: aPiece ]! !

!TerniLapilli methodsFor: 'board - private' stamp: 'la 11/1/2018 21:02:02'!
anyDiagonalIsFullOf: aPiece
	
	^ (self leftDiagonalIsFullOf: aPiece) or: [ self rightDiagonalIsFullOf: aPiece ]! !

!TerniLapilli methodsFor: 'board - private' stamp: 'la 11/1/2018 20:51:52'!
anyRowIsFullOf: aPiece
	
	^ #(1 2 3) anySatisfy: [ :row | self row: row isFullOf: aPiece ]! !

!TerniLapilli methodsFor: 'board - private' stamp: 'la 11/1/2018 20:56:05'!
col: col isFullOf: aPiece
	
	^ #(1 2 3) allSatisfy: [ :row | self has: aPiece at: col@row ]! !

!TerniLapilli methodsFor: 'board - private' stamp: 'la 11/1/2018 20:52:31'!
has: aPiece at: aPosition
	
	^ (board includesKey: aPosition) and: [ (board at: aPosition) = aPiece ]! !

!TerniLapilli methodsFor: 'board - private' stamp: 'jml 11/5/2018 18:09:25'!
horizontalDistanceBetween: fromPosition and: toPosition
	
	^ (fromPosition x - toPosition x) abs! !

!TerniLapilli methodsFor: 'board - private' stamp: 'jml 11/5/2018 18:13:37'!
isNotDiamondPosition: aPosition
	
	^ (aPosition x + aPosition y) even! !

!TerniLapilli methodsFor: 'board - private' stamp: 'la 11/1/2018 20:16:41'!
isValidCoordinate: aCoordinate
	
	^ aCoordinate between: 1 and: 3! !

!TerniLapilli methodsFor: 'board - private' stamp: 'la 11/1/2018 20:17:49'!
isValidPosition: aPosition
	
	^ (self isValidCoordinate: aPosition x) and: [ self isValidCoordinate: aPosition y ]! !

!TerniLapilli methodsFor: 'board - private' stamp: 'jml 11/7/2018 00:46:59'!
isWinning: aPlayer
	
	^ (self anyRowIsFullOf: aPlayer) or: [ (self anyColumnIsFullOf: aPlayer) or: [ self anyDiagonalIsFullOf: aPlayer ] ]! !

!TerniLapilli methodsFor: 'board - private' stamp: 'la 11/1/2018 21:07:34'!
leftDiagonalIsFullOf: aPiece
	
	^ (Array with: 1@1 with: 2@2 with: 3@3) allSatisfy: [ :pos | self has: aPiece at: pos ]! !

!TerniLapilli methodsFor: 'board - private' stamp: 'jml 11/5/2018 18:09:43'!
positionsAreAdjacent: fromPosition and: toPosition
	
	| horizontalDistance verticalDistance |
	
	horizontalDistance := self horizontalDistanceBetween: fromPosition and: toPosition.
	verticalDistance := self verticalDistanceBetween: fromPosition and: toPosition.
	
	^ horizontalDistance + verticalDistance = 1! !

!TerniLapilli methodsFor: 'board - private' stamp: 'jml 11/5/2018 18:05:54'!
positionsAreConnected: fromPosition and: toPosition
	
	^ (self positionsAreAdjacent: fromPosition and: toPosition) or: [ self positionsAreDiagonallyConnected: fromPosition and: toPosition ]! !

!TerniLapilli methodsFor: 'board - private' stamp: 'jml 11/5/2018 18:11:01'!
positionsAreDiagonallyConnected: fromPosition and: toPosition
	
	| horizontalDistance verticalDistance |
	
	horizontalDistance := self horizontalDistanceBetween: fromPosition and: toPosition.
	verticalDistance := self verticalDistanceBetween: fromPosition and: toPosition.
	
	^ (horizontalDistance = 1) and: [ verticalDistance = 1 and: [ self isNotDiamondPosition: fromPosition ] ]! !

!TerniLapilli methodsFor: 'board - private' stamp: 'la 11/1/2018 21:08:09'!
rightDiagonalIsFullOf: aPiece
	
	^ (Array with: 1@3 with: 2@2 with: 3@1) allSatisfy: [ :pos | self has: aPiece at: pos ]! !

!TerniLapilli methodsFor: 'board - private' stamp: 'la 11/1/2018 20:48:18'!
row: row isFullOf: aPiece
	
	^ #(1 2 3) allSatisfy: [ :col | self has: aPiece at: col@row ]! !

!TerniLapilli methodsFor: 'board - private' stamp: 'jml 11/5/2018 18:09:34'!
verticalDistanceBetween: fromPosition and: toPosition
	
	^ (fromPosition y - toPosition y) abs! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'jml 11/5/2018 17:26:23'!
cannotAddMorePieces
	
	^ 'cannot add more than 6 pieces'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'jml 11/5/2018 20:33:44'!
cannotMoveYetErrorDescription

	^ 'cannot move'! !

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


!classDefinition: #TerniLapilliState category: #TerniLapilli!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliState methodsFor: 'initialization' stamp: 'jml 11/6/2018 14:34:23'!
initializeFor: aGame

	game := aGame! !


!TerniLapilliState methodsFor: 'playing' stamp: 'jml 11/7/2018 00:52:28'!
moveFrom: fromPosition to: toPosition 

	self subclassResponsibility! !

!TerniLapilliState methodsFor: 'playing' stamp: 'jml 11/7/2018 00:52:43'!
placePieceAt: aPosition

	self subclassResponsibility! !


!TerniLapilliState methodsFor: 'testing' stamp: 'jml 11/7/2018 00:51:59'!
isFinished
	
	self subclassResponsibility! !

!TerniLapilliState methodsFor: 'testing' stamp: 'jml 11/7/2018 00:39:56'!
isWonForO
	
	self subclassResponsibility! !

!TerniLapilliState methodsFor: 'testing' stamp: 'jml 11/7/2018 00:39:52'!
isWonForX
	
	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: #TerniLapilli!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'instance creation' stamp: 'jml 11/6/2018 14:33:33'!
for: aTerniLapilli

	^ self new initializeFor: aTerniLapilli! !


!classDefinition: #GameOverState category: #TerniLapilli!
TerniLapilliState subclass: #GameOverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!GameOverState methodsFor: 'playing' stamp: 'jml 11/6/2018 14:55:59'!
moveFrom: fromPosition to: toPosition 

	^ self error: game class finishedGameErrorDescription! !

!GameOverState methodsFor: 'playing' stamp: 'jml 11/6/2018 14:55:32'!
placePieceAt: aPosition

	^ self error: game class finishedGameErrorDescription! !


!GameOverState methodsFor: 'testing' stamp: 'jml 11/6/2018 14:56:11'!
isFinished
	
	^ true! !


!classDefinition: #OHasWonState category: #TerniLapilli!
GameOverState subclass: #OHasWonState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!OHasWonState methodsFor: 'testing' stamp: 'jml 11/7/2018 00:40:41'!
isWonForO
	
	^ true! !

!OHasWonState methodsFor: 'testing' stamp: 'jml 11/7/2018 00:40:36'!
isWonForX
	
	^ false! !


!classDefinition: #XHasWonState category: #TerniLapilli!
GameOverState subclass: #XHasWonState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!XHasWonState methodsFor: 'testing' stamp: 'jml 11/7/2018 00:42:59'!
isWonForO
	
	^ false! !

!XHasWonState methodsFor: 'testing' stamp: 'jml 11/7/2018 00:42:54'!
isWonForX
	
	^ true! !


!classDefinition: #PlayingState category: #TerniLapilli!
TerniLapilliState subclass: #PlayingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlayingState methodsFor: 'testing' stamp: 'jml 11/6/2018 14:57:45'!
isFinished
	
	^ false! !

!PlayingState methodsFor: 'testing' stamp: 'jml 11/7/2018 00:43:13'!
isWonForO
	
	^ false! !

!PlayingState methodsFor: 'testing' stamp: 'jml 11/7/2018 00:43:12'!
isWonForX
	
	^ false! !


!classDefinition: #MovingState category: #TerniLapilli!
PlayingState subclass: #MovingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!MovingState methodsFor: 'playing' stamp: 'jml 11/6/2018 15:02:32'!
placePieceAt: aPosition
	
	^ self error: game class cannotAddMorePieces! !


!classDefinition: #OIsMovingState category: #TerniLapilli!
MovingState subclass: #OIsMovingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!OIsMovingState methodsFor: 'playing' stamp: 'jml 11/6/2018 23:36:10'!
moveFrom: fromPosition to: toPosition 
	
	game moveOFrom: fromPosition to: toPosition ! !


!classDefinition: #XIsMovingState category: #TerniLapilli!
MovingState subclass: #XIsMovingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!XIsMovingState methodsFor: 'playing' stamp: 'jml 11/6/2018 23:36:02'!
moveFrom: fromPosition to: toPosition 
	
	game moveXFrom: fromPosition to: toPosition! !


!classDefinition: #PlacingState category: #TerniLapilli!
PlayingState subclass: #PlacingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlacingState methodsFor: 'playing' stamp: 'jml 11/6/2018 14:49:35'!
moveFrom: fromPosition to: toPosition 

	^self error: game class cannotMoveYetErrorDescription! !


!classDefinition: #OIsPlacingState category: #TerniLapilli!
PlacingState subclass: #OIsPlacingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!OIsPlacingState methodsFor: 'playing' stamp: 'jml 11/6/2018 14:54:15'!
placePieceAt: aPosition

	game placeOAt: aPosition! !


!classDefinition: #XIsPlacingState category: #TerniLapilli!
PlacingState subclass: #XIsPlacingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!XIsPlacingState methodsFor: 'playing' stamp: 'jml 11/6/2018 14:55:17'!
placePieceAt: aPosition
	
	game placeXAt: aPosition! !
