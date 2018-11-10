!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'state playerOPositions playerXPositions console observers lastPlay'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'assertions' stamp: 'JG 10/28/2018 15:11:39'!
assertAllPiecesOPlaced

	(self playerOPositions size = 3 ) ifFalse: [ self error: self class playerOHasPiecesToPlace ].
! !

!TerniLapilli methodsFor: 'assertions' stamp: 'JG 10/28/2018 15:11:20'!
assertAllPiecesXPlaced

	(self playerXPositions size = 3 ) ifFalse: [ self error: self class playerXHasPiecesToPlace ].
! !

!TerniLapilli methodsFor: 'assertions' stamp: 'HAW 10/25/2017 15:35:08'!
assertIsFree: aPosition

	(self isTaken: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
! !

!TerniLapilli methodsFor: 'assertions' stamp: 'HAW 11/8/2018 10:47:35'!
assertIsInBoardBounds: aPosition

	(self isInBoardBounds: aPosition) ifFalse: [ self error: self class positionOutsideBoardErrorMessage ]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'HAW 11/8/2018 09:55:12'!
assertIsLegalMovementFrom: aPosition to: anotherPosition

	(self moveLegalFrom: aPosition to: anotherPosition) ifFalse: [ self error: self class illegalMovement ].
! !

!TerniLapilli methodsFor: 'assertions' stamp: 'JG 11/6/2018 22:31:24'!
assertThereIsAnOPieceIn: aPosition

	(self playerOPositions includes: aPosition) ifFalse: [ self error: self class playersCanOnlySlideTheirOwnPieces ]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'JG 11/6/2018 22:30:17'!
assertThereIsAnXPieceIn: aPosition

	(self playerXPositions includes: aPosition) ifFalse: [ self error: self class playersCanOnlySlideTheirOwnPieces ]! !


!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:10:30'!
has: positions threeOf: aPositionComponent

	^positions size >= 3 and: [ (positions collect: aPositionComponent) asBag contents values includes: 3 ]
	! !

!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 11/8/2018 10:58:20'!
hasCompletedColumn: positions

	^ self has: positions threeOf: [ :aPosition | aPosition y ].! !

!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 11/8/2018 10:58:36'!
hasCompletedRow: positions
	
	^ self has: positions threeOf: [ :aPosition | aPosition x ].! !

!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:15:47'!
hasDownDiagonal: positions

	^ (1 to: 3) allSatisfy: [ :n | positions includes: n @ (4-n) ].! !

!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:15:59'!
hasUpDiagonal: positions

	^ (1 to: 3) allSatisfy: [ :n | positions includes: n @ n ].! !

!TerniLapilli methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:16:26'!
hasWin: positions

	^ (self hasCompletedRow: positions) 
		or: [ (self hasCompletedColumn: positions) 
		or: [ (self hasUpDiagonal: positions) 
		or: [ self hasDownDiagonal: positions ]]].! !


!TerniLapilli methodsFor: 'initialization' stamp: 'jml 11/10/2018 05:03:21'!
initialize

	playerXPositions _ OrderedCollection new.
	playerOPositions _ OrderedCollection new.
	observers _ OrderedCollection new.
	
	state _ PlacingX new initializeFor: self.
	lastPlay _ NoPlay new.
	
	
	! !


!TerniLapilli methodsFor: 'marking board' stamp: 'JG 11/6/2018 20:34:26'!
putOAt: aPosition

	self assertIsInBoardBounds: aPosition .
	state putOAt: aPosition! !

!TerniLapilli methodsFor: 'marking board' stamp: 'JG 11/6/2018 20:34:12'!
putXAt: aPosition

	self assertIsInBoardBounds: aPosition .
	state putXAt: aPosition! !


!TerniLapilli methodsFor: 'marking board - private' stamp: 'jml 11/10/2018 06:04:15'!
putOWhenPlacingOAt: aPosition

	self playerOHasPiecesToPlace.
	self assertIsFree: aPosition.
	
	lastPlay := OPlacement at: aPosition.
	
	playerOPositions add: aPosition.
	
	state _ TerniLapilliState for: self.
	
	observers do: [ :observer | observer stateChangedTo: state ].! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 12:39:41'!
putOWhenPlacingXAt: aPosition

	self error: self class notOTurnErrorMessage ! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 12:08:31'!
putOWhenSlidingOAt: aPoint 
	
	self error: self class eachPlayerOnlyHasThreePieces ! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 12:38:11'!
putOWhenSlidingXAt: aPosition

	self error: self class notOTurnErrorMessage ! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 12:39:23'!
putXWhenPlacingOAt: aPoint 
	
	self error: self class notXTurnErrorMessage! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'jml 11/10/2018 06:04:20'!
putXWhenPlacingXAt: aPosition

	self playerXHasPiecesToPlace.
	self assertIsFree: aPosition.
	
	lastPlay := XPlacement at: aPosition.
	
	playerXPositions add: aPosition.
	
	state _ TerniLapilliState for: self.
	
	observers do: [ :observer | observer stateChangedTo: state ].! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 12:38:49'!
putXWhenSlidingOAt: aPoint 
	
	self error: self class notXTurnErrorMessage! !

!TerniLapilli methodsFor: 'marking board - private' stamp: 'JG 10/28/2018 11:59:44'!
putXWhenSlidingXAt: aPoint 
	
	self error: self class eachPlayerOnlyHasThreePieces ! !


!TerniLapilli methodsFor: 'pieces' stamp: 'HAW 11/8/2018 09:58:58'!
playerOHasPiecesToPlace

	 self playerOPositions size < 3 ifFalse: [ self error: self class playerXHasPlacedThreePieces ].
	! !

!TerniLapilli methodsFor: 'pieces' stamp: 'HAW 11/8/2018 09:59:05'!
playerXHasPiecesToPlace

	 self playerXPositions size < 3 ifFalse: [ self error: self class playerXHasPlacedThreePieces ].
	! !


!TerniLapilli methodsFor: 'positions' stamp: 'HAW 11/8/2018 10:49:00'!
moveLegalFrom: aPosition to: anotherPosition
	
	^ (self is: aPosition adjacentTo: anotherPosition) and: [ self isInBoardBounds: anotherPosition ]! !

!TerniLapilli methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:16'!
playerOPositions
	^ playerOPositions copy.! !

!TerniLapilli methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:32'!
playerXPositions
	^ playerXPositions copy.! !


!TerniLapilli methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:39'!
slideOFrom: aPosition to: anotherPosition

	self assertThereIsAnOPieceIn: aPosition.
	state slideOFrom: aPosition to: anotherPosition! !

!TerniLapilli methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:21'!
slideXFrom: aPosition to: anotherPosition

	self assertThereIsAnXPieceIn: aPosition.
	state slideXFrom: aPosition to: anotherPosition! !


!TerniLapilli methodsFor: 'sliding - private' stamp: 'HAW 11/8/2018 11:41:03'!
slideOWhenPlacingOFrom: aPosition to: anotherPosition

	self error: self class playerOHasPiecesToPlace ! !

!TerniLapilli methodsFor: 'sliding - private' stamp: 'HAW 11/8/2018 11:46:55'!
slideOWhenPlayingXFrom: aPosition to: anotherPosition

	self error: self class notOTurnErrorMessage ! !

!TerniLapilli methodsFor: 'sliding - private' stamp: 'jml 11/10/2018 06:04:24'!
slideOWhenSlidingOFrom: origin to: destination
	
	self assertIsFree: destination .
	self assertIsLegalMovementFrom: origin to: destination.
	
	lastPlay := OMovement from: origin to: destination.
	
	playerOPositions
		remove: origin;
		add: destination.
	
	state _ TerniLapilliState for: self.
	
	observers do: [ :observer | observer stateChangedTo: state ].! !

!TerniLapilli methodsFor: 'sliding - private' stamp: 'HAW 11/8/2018 11:16:01'!
slideXWhenPlacingXFrom: aPosition to: anotherPosition

	self error: self class playerXHasPiecesToPlace ! !

!TerniLapilli methodsFor: 'sliding - private' stamp: 'HAW 11/8/2018 11:44:53'!
slideXWhenPlayingOFrom: aPosition to: anotherPosition

	self error: self class notXTurnErrorMessage! !

!TerniLapilli methodsFor: 'sliding - private' stamp: 'jml 11/10/2018 06:04:28'!
slideXWhenSlidingXFrom: origin to: destination
	
	self assertIsFree: destination.
	self assertIsLegalMovementFrom: origin to: destination.
	
	lastPlay := XMovement from: origin to: destination.
	
	playerXPositions
		remove: origin;
		add: destination.
	
	state _ TerniLapilliState for: self.
	
	observers do: [ :observer | observer stateChangedTo: state ].! !


!TerniLapilli methodsFor: 'testing board positions' stamp: 'HAW 11/8/2018 12:19:28'!
does: aNumber distanceOneTo: anotherNumber

	^ (aNumber - anotherNumber) abs < 2 ! !

!TerniLapilli methodsFor: 'testing board positions' stamp: 'HAW 11/8/2018 11:30:51'!
hasXMorePiecesToPlace
	
	^playerXPositions size < 3! !

!TerniLapilli methodsFor: 'testing board positions' stamp: 'HAW 11/8/2018 12:19:28'!
is: aPosition adjacentTo: anotherPosition

	^ (self does: aPosition x distanceOneTo: anotherPosition x) and: [ self does: aPosition y distanceOneTo: anotherPosition y ]
	! !

!TerniLapilli methodsFor: 'testing board positions' stamp: 'HAW 11/8/2018 10:47:53'!
isInBoardBounds: aPosition

	^aPosition between: 1@1 and: 3@3! !

!TerniLapilli methodsFor: 'testing board positions' stamp: 'HAW 5/31/2018 00:16:45'!
isTaken: aPosition

	^ (playerXPositions includes: aPosition) or: [ playerOPositions includes: aPosition ].! !


!TerniLapilli methodsFor: 'testing game result' stamp: 'HAW 11/8/2018 11:56:45'!
hasPlayerOWon

	^self hasWin: playerOPositions ! !

!TerniLapilli methodsFor: 'testing game result' stamp: 'HAW 11/8/2018 11:56:55'!
hasPlayerXWon
	
	^self hasWin: playerXPositions ! !

!TerniLapilli methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 13:32:14'!
isOver
	
	^state isOver! !


!TerniLapilli methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 12:19:47'!
isPlacingX
	
	^state isPlacingX ! !

!TerniLapilli methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:38'!
isPlayingO
	
	^state isPlayingO! !

!TerniLapilli methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:14'!
isPlayingX
	
	^state isPlayingX ! !

!TerniLapilli methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 11:29:16'!
isSlidingX
	
	^state isSlidingX! !


!TerniLapilli methodsFor: 'observing' stamp: 'jml 11/9/2018 16:14:22'!
addObserver: anObserver
	
	observers add: anObserver.! !


!TerniLapilli methodsFor: 'accessing' stamp: 'jml 11/10/2018 04:06:36'!
lastPlay
	
	^ lastPlay! !

!TerniLapilli methodsFor: 'accessing' stamp: 'jml 11/10/2018 14:17:52'!
state
	
	^ state! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error messages' stamp: 'HAW 10/24/2017 17:12:48'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 10/28/2018 11:12:02'!
eachPlayerOnlyHasThreePieces

	^ 'Each player only has three pieces'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'HAW 11/8/2018 09:55:12'!
illegalMovement
	
	^'Movement is not legal'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'HAW 10/24/2017 17:12:48'!
notOTurnErrorMessage
	
	^'Not O''s turn'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'HAW 10/24/2017 17:12:48'!
notXTurnErrorMessage
	
	^'Not X''s turn'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 11/6/2018 22:50:08'!
playerOHasPiecesToPlace

	^ 'Must place all pieces to slide'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 10/28/2018 15:02:06'!
playerOHasPlacedThreePieces

	^ 'Each player only has three pieces'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 11/6/2018 22:50:16'!
playerXHasPiecesToPlace

	^ 'Must place all pieces to slide'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 10/28/2018 15:01:23'!
playerXHasPlacedThreePieces

	^ 'Each player only has three pieces'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 11/6/2018 22:21:33'!
playersCanOnlySlideTheirOwnPieces

	^ 'Players can only slide their own pieces'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'JG 11/6/2018 20:07:12'!
positionOutsideBoardErrorMessage
	^ 'Position is outside board'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'HAW 10/24/2017 17:12:48'!
positionTakenErrorMessage
	
	^'Position taken'! !


!classDefinition: #TerniLapilliObserver category: #TerniLapilli!
Object subclass: #TerniLapilliObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliObserver methodsFor: 'state' stamp: 'jml 11/10/2018 06:15:03'!
stateChangedTo: aState
	
	self subclassResponsibility! !


!classDefinition: #TerniLapilliBoardView category: #TerniLapilli!
TerniLapilliObserver subclass: #TerniLapilliBoardView
	instanceVariableNames: 'game board currentState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliBoardView methodsFor: 'initialization' stamp: 'jml 11/10/2018 14:20:51'!
initializeFor: aGame 
	
	game _ aGame.
	
	aGame addObserver: self.
	
	currentState := self stateLineFor: game state.
	
	board := (1 to: 3) collect: [ :rowNumber | Array new: 3 withAll: ' ' ].! !


!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'jml 11/10/2018 14:09:50'!
output
	
	^ self boardDisplay, String newLineString, currentState! !


!TerniLapilliBoardView methodsFor: 'play visiting' stamp: 'jml 11/10/2018 13:50:05'!
visitOMovement: aMovement

	self move: 'O' from: aMovement origin to: aMovement destination.
	! !

!TerniLapilliBoardView methodsFor: 'play visiting' stamp: 'jml 11/10/2018 13:49:41'!
visitOPlacement: aPlacement
	
	self at: aPlacement position put: 'O'.! !

!TerniLapilliBoardView methodsFor: 'play visiting' stamp: 'jml 11/10/2018 13:50:00'!
visitXMovement: aMovement

	self move: 'X' from: aMovement origin to: aMovement destination.
	! !

!TerniLapilliBoardView methodsFor: 'play visiting' stamp: 'jml 11/10/2018 13:49:36'!
visitXPlacement: aPlacement
	
	self at: aPlacement position put: 'X'.! !


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


!TerniLapilliBoardView methodsFor: 'display' stamp: 'jml 11/10/2018 14:10:02'!
boardDisplay
	
	^ (self rowSeparator join: (board collect: [ :row | self cellSeparator join: row ]))! !

!TerniLapilliBoardView methodsFor: 'display' stamp: 'jml 11/10/2018 14:07:48'!
cellSeparator
	
	^ '|'! !

!TerniLapilliBoardView methodsFor: 'display' stamp: 'jml 11/10/2018 14:11:38'!
rowSeparator
	
	^ String newLineString, '-----', String newLineString! !


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

!classDefinition: 'TerniLapilliBoardView class' category: #TerniLapilli!
TerniLapilliBoardView class
	instanceVariableNames: ''!

!TerniLapilliBoardView class methodsFor: 'instance creation' stamp: 'jml 11/9/2018 12:25:51'!
for: aGame

	^ self new initializeFor: aGame! !


!classDefinition: #TerniLapilliConsole category: #TerniLapilli!
TerniLapilliObserver subclass: #TerniLapilliConsole
	instanceVariableNames: 'lines game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliConsole methodsFor: 'initialization' stamp: 'jml 11/9/2018 16:17:45'!
initializeFor: aGame
	
	game _ aGame.
	lines _ OrderedCollection new.
	
	aGame addObserver: self.! !


!TerniLapilliConsole methodsFor: 'accessing' stamp: 'jml 11/8/2018 19:54:55'!
output

	^ ReadStream on: lines! !


!TerniLapilliConsole methodsFor: 'play visiting' stamp: 'jml 11/10/2018 13:48:22'!
visitOMovement: aMovement
	
	self addLine: (self slidingLineFor: 'O' from: aMovement origin to: aMovement destination).! !

!TerniLapilliConsole methodsFor: 'play visiting' stamp: 'jml 11/10/2018 13:48:42'!
visitOPlacement: aPlacement
	
	self addLine: (self placingLineFor: 'O' at: aPlacement position).! !

!TerniLapilliConsole methodsFor: 'play visiting' stamp: 'jml 11/10/2018 13:49:09'!
visitXMovement: aMovement
	
	self addLine: (self slidingLineFor: 'X' from: aMovement origin to: aMovement destination).! !

!TerniLapilliConsole methodsFor: 'play visiting' stamp: 'jml 11/10/2018 13:48:53'!
visitXPlacement: aPlacement
	
	self addLine: (self placingLineFor: 'X' at: aPlacement position).! !


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

!classDefinition: 'TerniLapilliConsole class' category: #TerniLapilli!
TerniLapilliConsole class
	instanceVariableNames: ''!

!TerniLapilliConsole class methodsFor: 'instance creation' stamp: 'jml 11/8/2018 19:37:53'!
for: aGame
	
	^ self new initializeFor: aGame! !


!classDefinition: #TerniLapilliPlay category: #TerniLapilli!
Object subclass: #TerniLapilliPlay
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliPlay methodsFor: 'comparing' stamp: 'jml 11/10/2018 05:10:57'!
= anObject
	
	self subclassResponsibility! !

!TerniLapilliPlay methodsFor: 'comparing' stamp: 'jml 11/10/2018 05:24:05'!
hash
	
	self subclassResponsibility! !


!TerniLapilliPlay methodsFor: 'visiting' stamp: 'jml 11/10/2018 06:07:18'!
accept: aVisitor
	
	self subclassResponsibility! !


!classDefinition: #Movement category: #TerniLapilli!
TerniLapilliPlay subclass: #Movement
	instanceVariableNames: 'origin destination'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Movement methodsFor: 'initialization' stamp: 'jml 11/10/2018 05:19:15'!
initializeFrom: fromPosition to: toPosition
	
	origin _ fromPosition.
	destination _ toPosition.! !


!Movement methodsFor: 'accessing' stamp: 'jml 11/10/2018 05:19:15'!
destination
	
	^ destination! !

!Movement methodsFor: 'accessing' stamp: 'jml 11/10/2018 05:19:01'!
origin
	
	^ origin! !


!Movement methodsFor: 'comparing' stamp: 'jml 11/10/2018 05:19:15'!
= anObject
	
	^ self class = anObject class and: [ origin = anObject origin and: [ destination = anObject destination ] ]! !

!Movement methodsFor: 'comparing' stamp: 'jml 11/10/2018 05:23:44'!
hash
	
	^ self class hash bitXor: (self origin hash bitXor: self destination hash)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Movement class' category: #TerniLapilli!
Movement class
	instanceVariableNames: ''!

!Movement class methodsFor: 'instance creation' stamp: 'jml 11/10/2018 04:47:18'!
from: fromPosition to: toPosition
	
	^ self new initializeFrom: fromPosition to: toPosition! !


!classDefinition: #OMovement category: #TerniLapilli!
Movement subclass: #OMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!OMovement methodsFor: 'visiting' stamp: 'jml 11/10/2018 13:47:06'!
accept: aVisitor
	
	aVisitor visitOMovement: self! !


!classDefinition: #XMovement category: #TerniLapilli!
Movement subclass: #XMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!XMovement methodsFor: 'visiting' stamp: 'jml 11/10/2018 13:47:18'!
accept: aVisitor
	
	aVisitor visitXMovement: self! !


!classDefinition: #NoPlay category: #TerniLapilli!
TerniLapilliPlay subclass: #NoPlay
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!NoPlay methodsFor: 'comparing' stamp: 'jml 11/10/2018 05:26:20'!
= anObject
	
	^ self class = anObject class! !

!NoPlay methodsFor: 'comparing' stamp: 'jml 11/10/2018 05:26:52'!
hash
	
	^ self class hash! !


!classDefinition: #Placement category: #TerniLapilli!
TerniLapilliPlay subclass: #Placement
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Placement methodsFor: 'initialization' stamp: 'jml 11/10/2018 04:51:34'!
initializeAt: aPosition
	
	position _ aPosition.! !


!Placement methodsFor: 'accessing' stamp: 'jml 11/10/2018 05:25:20'!
position
	
	^ position! !


!Placement methodsFor: 'comparing' stamp: 'jml 11/10/2018 05:29:09'!
= anObject
	
	^ self class = anObject class and: [ position = anObject position ]! !

!Placement methodsFor: 'comparing' stamp: 'jml 11/10/2018 05:25:08'!
hash
	
	^ self class hash bitXor: self position hash! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Placement class' category: #TerniLapilli!
Placement class
	instanceVariableNames: ''!

!Placement class methodsFor: 'instance creation' stamp: 'jml 11/10/2018 04:51:14'!
at: aPosition
	
	^ self new initializeAt: aPosition.! !


!classDefinition: #OPlacement category: #TerniLapilli!
Placement subclass: #OPlacement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!OPlacement methodsFor: 'visiting' stamp: 'jml 11/10/2018 13:47:32'!
accept: aVisitor
	
	aVisitor visitOPlacement: self! !


!classDefinition: #XPlacement category: #TerniLapilli!
Placement subclass: #XPlacement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!XPlacement methodsFor: 'visiting' stamp: 'jml 11/10/2018 13:47:44'!
accept: aVisitor
	
	aVisitor visitXPlacement: self! !


!classDefinition: #TerniLapilliState category: #TerniLapilli!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliState methodsFor: 'testing game result' stamp: 'HAW 11/8/2018 12:13:16'!
areAllXsOnTheBoard
	
	^false! !

!TerniLapilliState methodsFor: 'testing game result' stamp: 'HAW 11/8/2018 12:13:10'!
isOver
	
	^false! !


!TerniLapilliState methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 12:06:17'!
isPlacingX
	
	^false! !

!TerniLapilliState methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 12:15:12'!
isPlayingO
	
	^false! !

!TerniLapilliState methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 12:14:00'!
isPlayingX
	
	^false! !

!TerniLapilliState methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 11:29:36'!
isSlidingX
	
	^false! !


!TerniLapilliState methodsFor: 'marking board' stamp: 'HAW 11/8/2018 11:03:55'!
putOAt: aPosition
	
	self subclassResponsibility! !

!TerniLapilliState methodsFor: 'marking board' stamp: 'HAW 11/8/2018 11:04:00'!
putXAt: aPosition
	
	self subclassResponsibility! !


!TerniLapilliState methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:38'!
slideOFrom: aPosition to: anotherPosition
	
	self subclassResponsibility! !

!TerniLapilliState methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:20'!
slideXFrom: aPosition to: anotherPosition
	
	self subclassResponsibility! !


!TerniLapilliState methodsFor: 'initialization' stamp: 'HAW 10/25/2017 13:05:13'!
initializeFor: aGame

	game := aGame ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: #TerniLapilli!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'instance creation' stamp: 'HAW 11/8/2018 11:21:36'!
for: aTerniLapilli 

	| stateClass |
	
	stateClass := self allSubclasses detect: [:anStateClass | anStateClass isFor: aTerniLapilli ].	
	^stateClass new initializeFor: aTerniLapilli ! !


!TerniLapilliState class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:21:46'!
isFor: aTerniLapilli 

	^self subclassResponsibility ! !


!classDefinition: #GameOverState category: #TerniLapilli!
TerniLapilliState subclass: #GameOverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!GameOverState methodsFor: 'testing game result' stamp: 'HAW 11/8/2018 12:15:43'!
isOver

	^ true.! !


!GameOverState methodsFor: 'marking board' stamp: 'HAW 11/8/2018 11:08:57'!
putOAt: aPosition

	game error: game class canNotPlayWhenGameIsOverErrorMessage ! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 11/8/2018 11:09:02'!
putXAt: aPosition

	game error: game class canNotPlayWhenGameIsOverErrorMessage ! !


!GameOverState methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:38'!
slideOFrom: aPosition to: anotherPostion

	game error: game class canNotPlayWhenGameIsOverErrorMessage ! !

!GameOverState methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:20'!
slideXFrom: aPosition to: anotherPostion

	game error: game class canNotPlayWhenGameIsOverErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOverState class' category: #TerniLapilli!
GameOverState class
	instanceVariableNames: ''!

!GameOverState class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 12:02:20'!
isFor: aTerniLapilli 

	^ aTerniLapilli hasPlayerXWon or: [ aTerniLapilli hasPlayerOWon ]! !


!classDefinition: #PlayingO category: #TerniLapilli!
TerniLapilliState subclass: #PlayingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:36'!
isPlayingO
	
	^true! !


!PlayingO methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:20'!
slideXFrom: aPosition to: anotherPostion

	game slideXWhenPlayingOFrom: aPosition to: anotherPostion .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayingO class' category: #TerniLapilli!
PlayingO class
	instanceVariableNames: ''!

!PlayingO class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:23:04'!
isFor: aTerniLapilli 

	^false! !


!classDefinition: #PlacingO category: #TerniLapilli!
PlayingO subclass: #PlacingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlacingO methodsFor: 'marking board' stamp: 'JG 10/28/2018 12:10:45'!
putOAt: aPosition

	game putOWhenPlacingOAt: aPosition ! !

!PlacingO methodsFor: 'marking board' stamp: 'JG 10/28/2018 13:05:38'!
putXAt: aPosition

	game putXWhenPlacingOAt: aPosition ! !


!PlacingO methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:38'!
slideOFrom: aPosition to: anotherPostion

	game slideOWhenPlacingOFrom: aPosition to: anotherPostion .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlacingO class' category: #TerniLapilli!
PlacingO class
	instanceVariableNames: ''!

!PlacingO class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 12:07:43'!
isFor: aTerniLapilli 

	^aTerniLapilli isPlacingX and: [ aTerniLapilli hasPlayerXWon not ] ! !


!classDefinition: #SlidingO category: #TerniLapilli!
PlayingO subclass: #SlidingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!SlidingO methodsFor: 'marking board' stamp: 'JG 10/28/2018 12:11:14'!
putOAt: aPosition

	game putOWhenSlidingOAt: aPosition ! !

!SlidingO methodsFor: 'marking board' stamp: 'JG 10/28/2018 12:04:38'!
putXAt: aPosition

	game putXWhenSlidingXAt: aPosition ! !


!SlidingO methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:38'!
slideOFrom: aPosition to: anotherPostion
 
	game slideOWhenSlidingOFrom: aPosition to: anotherPostion .! !


!SlidingO methodsFor: 'testing pieces placed' stamp: 'JG 10/28/2018 12:04:38'!
areAllXsOnTheBoard
	
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SlidingO class' category: #TerniLapilli!
SlidingO class
	instanceVariableNames: ''!

!SlidingO class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:57:15'!
isFor: aTerniLapilli 

	^aTerniLapilli isSlidingX and: [ aTerniLapilli hasPlayerXWon not ]! !


!classDefinition: #PlayingX category: #TerniLapilli!
TerniLapilliState subclass: #PlayingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:23'!
isPlayingX
	
	^true! !


!PlayingX methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:38'!
slideOFrom: aPosition to: anotherPostion
 
	game slideOWhenPlayingXFrom: aPosition to: anotherPostion .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayingX class' category: #TerniLapilli!
PlayingX class
	instanceVariableNames: ''!

!PlayingX class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:25:23'!
isFor: aTerniLapilli 

	^false! !


!classDefinition: #PlacingX category: #TerniLapilli!
PlayingX subclass: #PlacingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlacingX methodsFor: 'marking board' stamp: 'JG 10/28/2018 13:52:28'!
putOAt: aPosition

	game putOWhenPlacingXAt: aPosition ! !

!PlacingX methodsFor: 'marking board' stamp: 'JG 10/28/2018 11:58:08'!
putXAt: aPosition

	game putXWhenPlacingXAt: aPosition ! !


!PlacingX methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:20'!
slideXFrom: aPosition to: anotherPostion

	game slideXWhenPlacingXFrom: aPosition to: anotherPostion .! !


!PlacingX methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 12:06:28'!
isPlacingX

	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlacingX class' category: #TerniLapilli!
PlacingX class
	instanceVariableNames: ''!

!PlacingX class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:25:47'!
isFor: aTerniLapilli 

	^aTerniLapilli isPlayingO and: [ aTerniLapilli hasXMorePiecesToPlace]! !


!classDefinition: #SlidingX category: #TerniLapilli!
PlayingX subclass: #SlidingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!SlidingX methodsFor: 'marking board' stamp: 'JG 10/28/2018 14:51:46'!
putOAt: aPosition

	game putOWhenSlidingXAt: aPosition ! !

!SlidingX methodsFor: 'marking board' stamp: 'JG 10/28/2018 12:00:12'!
putXAt: aPosition

	game putXWhenSlidingXAt: aPosition ! !


!SlidingX methodsFor: 'sliding' stamp: 'HAW 11/8/2018 11:48:20'!
slideXFrom: aPosition to: anotherPostion
 
	game slideXWhenSlidingXFrom: aPosition to: anotherPostion .! !


!SlidingX methodsFor: 'testing pieces placed' stamp: 'JG 10/28/2018 11:30:43'!
areAllXsOnTheBoard
	
	^true! !


!SlidingX methodsFor: 'testing playing turn' stamp: 'HAW 11/8/2018 11:29:47'!
isSlidingX

	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SlidingX class' category: #TerniLapilli!
SlidingX class
	instanceVariableNames: ''!

!SlidingX class methodsFor: 'state selection' stamp: 'HAW 11/8/2018 11:57:36'!
isFor: aTerniLapilli 

	^aTerniLapilli isPlayingO and: [ aTerniLapilli hasXMorePiecesToPlace not and: [ aTerniLapilli hasPlayerOWon not ]]! !
