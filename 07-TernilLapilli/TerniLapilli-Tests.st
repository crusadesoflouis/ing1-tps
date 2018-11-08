!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Tests'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: 'xWinGame emptyGame moveGame oWinGame'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Tests'!

!TerniLapilliTest methodsFor: 'tests' stamp: 'la 11/7/2018 14:34:46'!
setUp

	moveGame := TerniLapilli new.
	moveGame placePieceAt: 1@1.
	moveGame placePieceAt: 3@1.
	moveGame placePieceAt: 1@2.
	moveGame placePieceAt: 3@2.
	moveGame placePieceAt: 3@3.
	moveGame placePieceAt: 1@3.
	
	emptyGame := TerniLapilli new.
	
	
	xWinGame := TerniLapilli new.
	xWinGame placePieceAt: 1@1.
	xWinGame placePieceAt: 1@2.
	xWinGame placePieceAt: 2@1.
	xWinGame placePieceAt: 2@2.
	xWinGame placePieceAt: 3@1.
	
	
	oWinGame := TerniLapilli new.	
	oWinGame placePieceAt: 1@2.
	oWinGame placePieceAt: 1@1.
	oWinGame placePieceAt: 2@1.
	oWinGame placePieceAt: 2@2.
	oWinGame placePieceAt: 1@3.
	oWinGame placePieceAt: 3@3.
		! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'la 11/7/2018 03:03:47'!
test01BoardIsInitiallyEmpty

	self assert: (self boardIsEmpty: emptyGame).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:08:02'!
test02XHasPosition

	| game position |
	
	position := 1@1.
	game := TerniLapilli new.
	game placePieceAt: position.
	
	self assert: (game hasXAt: position).
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:20:52'!
test02_02XhasntPositionAt

	| game position |
	
	position := 1@1.
	game := TerniLapilli new.
	game placePieceAt: position.
	
	self deny: (game hasOAt: position).
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:08:51'!
test04PositionIsNotEmpty

	| game position |
	
	position := 1@1.
	game := TerniLapilli new.
	game placePieceAt: position.

	self deny: (game positionIsEmpty: position).	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:09:06'!
test05RestOfPositionAreEmpty

	| game position restOfPositions |
	
	position := 1@1.
	restOfPositions := self allPositions.
	restOfPositions remove: position.
	game := TerniLapilli new.
	game placePieceAt: position.

	self assert: (restOfPositions allSatisfy: [ :aPosition | game positionIsEmpty: aPosition ]).
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:09:16'!
test06OCannotPlayFirst

	| game position |
	
	position := 1@1.

	game := TerniLapilli new.
	game placePieceAt: position.

	self deny: (game hasOAt: position).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:09:25'!
test07OCanPlayAtSomePosition

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:09:56'!
test08CannotPlayAtLeftInvalidPosition

	|game anInvalidPosition |
	
	anInvalidPosition := 0@1.
	
	game := TerniLapilli new.
	
	self should: [game placePieceAt: anInvalidPosition ] raise: Exception withExceptionDo: [ :exception |
		self assert:  (exception messageText ) equals: (TerniLapilli invalidPositionErrorDescription).
		self assert: (self boardIsEmpty: game).
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:10:04'!
test09CannotPlayAtRightInvalidPosition

	|game anInvalidPosition |
	
	anInvalidPosition := 5@1.
	
	game := TerniLapilli new.
	
	self should: [game placePieceAt: anInvalidPosition ] raise: Exception withExceptionDo: [ :exception |
		self assert:  (exception messageText ) equals: (TerniLapilli invalidPositionErrorDescription).
		self assert: (self boardIsEmpty: game).
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:10:08'!
test10CannotPlayAtLowerInvalidPosition

	|game anInvalidPosition |
	
	anInvalidPosition := 1@5.
	
	game := TerniLapilli new.
	
	self should: [game placePieceAt: anInvalidPosition ] raise: Exception withExceptionDo: [ :exception |
		self assert:  (exception messageText ) equals: (TerniLapilli invalidPositionErrorDescription).
		self assert: (self boardIsEmpty: game).
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:11:08'!
test11CannotPlayAtUpperInvalidPosition

	|game anInvalidPosition |
	
	anInvalidPosition := 1@0.
	
	game := TerniLapilli new.
	
	self should: [game placePieceAt: anInvalidPosition ] raise: Exception withExceptionDo: [ :exception |
		self assert:  (exception messageText ) equals: (TerniLapilli invalidPositionErrorDescription).
		self assert: (self boardIsEmpty: game).
	].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:12:11'!
test12CannotPlayAtAnOccupiedPosition
	
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:12:26'!
test13InitiallyWonGameForColumnsIsFinished
	
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:12:39'!
test14InitiallyWonGameForRowIsFinished
	
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:13:32'!
test15InitiallyWonGameForDiagonalIsFinished
	
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:13:48'!
test16InitiallyWonGameForColumnsIsFinished
	
	self assert: xWinGame isFinished.
	self assert: xWinGame isWonForX.
	self deny: xWinGame isWonForO.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:13:59'!
test17OcanWin
	
	self assert: oWinGame isFinished.
	self assert: oWinGame isWonForO.! !

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:14:27'!
test19GameInitialPhaseFinishedWhitoutWinner
	
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:14:42'!
test20gameInitialPhaseNotFinished
	
	| game |
	
	game := TerniLapilli new.
	game placePieceAt: 1@1.
	
	self deny: game isFinished.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:14:54'!
test21InvalidMovementBecauseOfInvalidPositions
	
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:15:02'!
test22InvalidMovementBecauseOfMissingPiece
	
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:15:14'!
test23InvalidMovementBecauseOfUnconnectedPositions
	
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:15:35'!
test24InvalidMovementBecauseOfOccupiedDestination
	
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:15:53'!
test25CannotPlayWhenGameIsFinished

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:16:18'!
test26OCanMoveAfterX
	
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:16:28'!
test27WonAfterAMove
	
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

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:16:40'!
test28CannotMoveWhenGameIsFinished

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

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:17:54'!
test29XHasWinInMovePhase

	| game |
	
	game := TerniLapilli new.
	
	game placePieceAt: 1@1.
	game placePieceAt: 3@1.
	game placePieceAt: 1@2.
	game placePieceAt: 3@2.
	game placePieceAt: 3@3.
	game placePieceAt: 1@3.
	game moveFrom: 1@2 to: 2@2.
	
	self assert:  game isWonForX.
	self deny: game isWonForO.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:18:02'!
test30OHasWinInMovePhase
	
	| game |
	
	game := TerniLapilli new.
	
	game placePieceAt: 1@1.
	game placePieceAt: 1@2.
	game placePieceAt: 1@3.
	game placePieceAt: 2@2.
	game placePieceAt: 2@1.
	game placePieceAt: 3@3.
	game moveFrom: 2@1 to: 3@1.
	game moveFrom: 3@3 to: 3@2.

	self assert:  game isWonForO.
	self deny: game isWonForX.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:18:16'!
test31CannontMoveDuringInitialPhase

	| game |
	
	game := TerniLapilli new.
	game placePieceAt: 1@1.
	game placePieceAt: 1@2.
	
	self should: [ game moveFrom: 1@1 to: 2@1. ] raise: Error withExceptionDo: [ :anException |
		self assert: anException messageText equals: TerniLapilli cannotMoveYetErrorDescription.
	].
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:18:27'!
test32PutXTurn

	| game |	
	
	game := TerniLapilli new.
	
	self assert: TerniLapilli xPlayer equals: game turn.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:18:32'!
test33PutOTurn

	| game |	

	game := TerniLapilli new.
	game placePieceAt: 1@1.	
	
	self assert: TerniLapilli oPlayer equals: game turn.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:18:53'!
test34MoveXTurn

	self assert: TerniLapilli xPlayer equals: moveGame turn.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:19:01'!
test35MoveOTurn

	moveGame moveFrom: 1@1 to: 2@2.
	
	self assert: TerniLapilli oPlayer equals: moveGame turn.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:19:13'!
test36CanAddMorePiecesInAEmptyBoard
	
	self assert: emptyGame canAddMorePieces.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:19:17'!
test37CanAddMorePiecesInANotEmptyBoard
	
	emptyGame placePieceAt: 1@1.

	self assert: emptyGame canAddMorePieces.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:19:22'!
test38CannotAddMorePiecesInACompleteBoard
	
	self deny: moveGame canAddMorePieces.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:19:28'!
test39CannotAddMorePiecesInACompleteBoardAfterAMove
	
	moveGame moveFrom: 1@1 to: 2@2.
	
	self deny: moveGame canAddMorePieces.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:19:36'!
test40XwinTurn
	
	self should: [ xWinGame turn ] raise: Error withExceptionDo: [ :exception |
		self assert: exception messageText = TerniLapilli finishedGameErrorDescription
	].
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'jml 11/8/2018 17:19:43'!
test41OwinTurn
	
	self should: [ oWinGame turn ] raise: Error withExceptionDo: [ :exception |
		self assert: exception messageText = TerniLapilli finishedGameErrorDescription
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
