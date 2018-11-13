!classDefinition: #BookTest category: #TusLibros!
TestCase subclass: #BookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BookTest methodsFor: 'tests' stamp: 'instance  creation 11/12/2018 21:21:14'!
test01CannotGetABookThatIsNotInTheInventory
	
	| inventory |
	
	inventory _ BookInventory new.
	
	self should: [ inventory bookWith: '1234' ] raise: Error - MessageNotUnderstood withExceptionDo: [ :anException |
		self assert: BookInventory bookDoesNotExistErrorMessage equals: anException messageText.
	].! !

!BookTest methodsFor: 'tests' stamp: 'instance  creation 11/12/2018 21:21:28'!
test02CannGetABookThatIsInTheInventory
	
	| inventory anIsbn aTitle |
	
	inventory _ BookInventory new.
	anIsbn _ '1234'.
	aTitle _ 'Title'.
	inventory addBook: anIsbn titled: aTitle.
	
	self assert: anIsbn equals: (inventory bookWith: anIsbn) isbn.
	self assert: aTitle equals: (inventory bookWith: anIsbn) title.! !


!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'inventory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'setup' stamp: 'instance  creation 11/12/2018 21:23:36'!
setUp
	
	inventory _ BookInventory new.
	
	inventory addBook: '1234' titled: 'aTitle'.
	inventory addBook: '5678' titled: 'La vida de Carrió'.
	! !


!CartTest methodsFor: 'tests' stamp: 'instance  creation 11/12/2018 20:25:33'!
test01ANewCartIsEmpty

	| aCart |
	
	aCart := Cart new.
	
	self assert: aCart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'instance  creation 11/12/2018 21:18:23'!
test02ACartAfterAddingABookIsNotEmpty

	| aCart aBook |
	
	aCart _ Cart new.
	aBook _ inventory bookWith: '1234'.
	
	aCart add: 1 of: aBook.
	
	self deny: aCart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'instance  creation 11/12/2018 21:22:21'!
test03ACartHasTheAmountOfABookAdded

	| aCart aBook anAmount |
	
	aCart _ Cart new.
	aBook _ inventory bookWith: '1234'.
	anAmount _ 5.
	
	aCart add: anAmount of: aBook.
	
	self assert: anAmount equals: (aCart amountOf: aBook).! !

!CartTest methodsFor: 'tests' stamp: 'instance  creation 11/12/2018 21:22:31'!
test04ACartHasTheSumOfTheAmountsAddedForABook

	| aCart aBook amount1 amount2 |
	
	aCart _ Cart new.
	aBook _ inventory bookWith: '1234'.
	amount1 _ 10.
	amount2 _ 20.

	aCart add: amount1 of: aBook.
	aCart add: amount2 of: aBook.
	
	self assert: amount1 + amount2 equals: (aCart amountOf: aBook).! !

!CartTest methodsFor: 'tests' stamp: 'instance  creation 11/12/2018 21:22:43'!
test05ACartHasZeroAmountOfABookNotAdded

	| aCart aBook |
	
	aCart _ Cart new.
	aBook _ inventory bookWith: '1234'.
	
	self assert: 0 equals: (aCart amountOf: aBook).! !

!CartTest methodsFor: 'tests' stamp: 'instance  creation 11/12/2018 20:45:00'!
test06ContentsOfANewCartIsEmpty

	| aCart  |
	
	aCart _ Cart new.
	
	self assert: aCart contents isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'instance  creation 11/12/2018 21:23:16'!
test07ContentsOfACartIncludesBooksAdded
	
	| aCart book1 amount1 book2 amount2 expectedContents |
	
	aCart _ Cart new.
	book1 _ inventory bookWith: '1234'.
	book2 _ inventory bookWith: '5678'.
	
	amount1 _ 10.
	amount2 _ 20.
	
	aCart add: amount1 of: book1 .
	aCart add: amount2 of: book2.
	
	expectedContents _ Dictionary new.
	expectedContents at: book1 put: amount1.
	expectedContents at: book2 put: amount2.
	
	self assert: expectedContents equals: aCart contents.! !


!classDefinition: #Book category: #TusLibros!
Object subclass: #Book
	instanceVariableNames: 'isbn title'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Book methodsFor: 'initialization' stamp: 'instance  creation 11/12/2018 20:29:24'!
initializeWith: anIsbn
	
	! !

!Book methodsFor: 'initialization' stamp: 'instance  creation 11/12/2018 21:11:39'!
initializeWith: aIsbn titled: aTitle 
	
	isbn _ aIsbn.
	title _ aTitle! !


!Book methodsFor: 'accessing' stamp: 'instance  creation 11/12/2018 21:15:51'!
isbn

	^isbn! !

!Book methodsFor: 'accessing' stamp: 'instance  creation 11/12/2018 21:16:02'!
title
	
	^title! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: #TusLibros!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'instance creation' stamp: 'instance  creation 11/12/2018 20:29:09'!
with: anIsbn 
	
	^self new initializeWith: anIsbn ! !


!Book class methodsFor: 'as yet unclassified' stamp: 'instance  creation 11/12/2018 21:10:55'!
with: anIsbn titled: aTitle 

	^self new initializeWith: anIsbn titled: aTitle! !


!classDefinition: #BookInventory category: #TusLibros!
Object subclass: #BookInventory
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BookInventory methodsFor: 'accessing' stamp: 'instance  creation 11/12/2018 21:18:45'!
bookWith: anIsbn 
	
	^books at: anIsbn  ifAbsent:[self error: self class bookDoesNotExistErrorMessage]
! !


!BookInventory methodsFor: 'adding' stamp: 'instance  creation 11/12/2018 21:13:52'!
addBook: aIsbn titled: aTitle

	books at: aIsbn  put:  (Book with: aIsbn titled: aTitle) ! !

!BookInventory methodsFor: 'adding' stamp: 'instance  creation 11/12/2018 21:13:52'!
initialize

	books _ Dictionary new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BookInventory class' category: #TusLibros!
BookInventory class
	instanceVariableNames: ''!

!BookInventory class methodsFor: 'error messages' stamp: 'instance  creation 11/12/2018 20:59:24'!
bookDoesNotExistErrorMessage
	
	^ 'Book does not exist'! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'instance  creation 11/12/2018 20:06:18'!
isEmpty
	
	^contents isEmpty.! !


!Cart methodsFor: 'adding' stamp: 'instance  creation 11/12/2018 20:34:22'!
add: anAmount of: aBook 
	
	| previousAmount |
	
	previousAmount _ contents at: aBook ifAbsent: 0.
	
	contents at: aBook put: previousAmount + anAmount.! !


!Cart methodsFor: 'initialization' stamp: 'instance  creation 11/12/2018 20:05:07'!
initialize

	contents  _ Dictionary new.! !


!Cart methodsFor: 'accessing' stamp: 'instance  creation 11/12/2018 20:37:55'!
amountOf: aBook 
	
	^contents at: aBook ifAbsent: 0! !

!Cart methodsFor: 'accessing' stamp: 'instance  creation 11/12/2018 20:44:33'!
contents

	^contents! !
