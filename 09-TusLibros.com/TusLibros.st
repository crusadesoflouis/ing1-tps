!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'jml 11/15/2018 19:06:40'!
defaultCatalog
	
	| catalog |
	
	catalog _ Dictionary new.
	catalog at: self itemSellByTheStore put: 500.
	
	^ catalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'salesBook mpInterface cashier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'jml 11/15/2018 20:26:22'!
asd_test05
	
	| mp |
	
	mp _ SimulatedMerchantProcessorInterface new.
	
	mp simulateCardWithoudFunds: '1234'.
	
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'jml 11/15/2018 20:43:23'!
test01CannotCheckOutAnEmptyCart
	
	| cart |
	
	cart _ self createCart.
		
	self should: [
		cashier checkOut: cart with: self defaultCreditCard.
	] raise: Error - MessageNotUnderstood
	withExceptionDo: [ :exception |
		self assert: Cashier emptyCartErrorMessage equals: exception messageText.
		self assert: salesBook isEmpty.
		self assert: 0 equals: mpInterface numberOfRequestsSent.
	].! !

!CashierTest methodsFor: 'tests' stamp: 'jml 11/15/2018 20:44:24'!
test02CanCheckOutACartWithASingleElement
	
	| cart price catalog |
	
	catalog _ self defaultCatalog.
	
	price _ catalog at: self itemSellByTheStore.
	
	cart _ self createCart.
	cart add: 1 of: self itemSellByTheStore.
	
	cashier checkOut: cart with: self defaultCreditCard.
	
	self assert: 1 equals: salesBook size.
	self assert: price equals: (salesBook at: 1).
	self assert: 1 equals: mpInterface numberOfRequestsSent.! !

!CashierTest methodsFor: 'tests' stamp: 'jml 11/15/2018 20:53:10'!
test03CanCheckOutACartWithRepeatedItem
	
	| cart price amount |
	
	price _ self defaultCatalog at: self itemSellByTheStore.
	amount _ 3.
	
	cart _ self createCart.
	cart add: amount of: self itemSellByTheStore.
	
	cashier checkOut: cart with: self defaultCreditCard.
	
	self assert: 1 equals: salesBook size.
	self assert: price * amount equals: (salesBook at: 1).
	self assert: 1 equals: mpInterface numberOfRequestsSent.! !

!CashierTest methodsFor: 'tests' stamp: 'jml 11/15/2018 20:53:43'!
test04CannotCheckOutWithExpiredCreditCard
	
	| cart |
	
	cart _ self createCart.
	cart add: 3 of: self itemSellByTheStore.
	
	self should: [
		cashier checkOut: cart with: self expiredCreditCard.
	] raise: Error - MessageNotUnderstood
	withExceptionDo: [ :exception |
		self assert: Cashier expiredCreditCardErrorMessage equals: exception messageText.
		
		self assert: salesBook isEmpty.
		self assert: 0 equals: mpInterface numberOfRequestsSent.
	].! !

!CashierTest methodsFor: 'tests' stamp: 'jml 11/15/2018 21:26:11'!
test05CannotCheckoutWithNotFundedCreditCard
	
	| cart creditCard |
	
	creditCard _ self defaultCreditCard.
	
	cart _ self createCart.
	cart add: 3 of: self itemSellByTheStore.
	
	mpInterface simulateCardWithoutFunds: creditCard.
	
	self should: [
		cashier checkOut: cart with: creditCard.
	] raise: Error - MessageNotUnderstood
	withExceptionDo: [ :exception |
		self assert: MerchantProcessorInterface notEnoughFundsErrorDescription equals: exception messageText.
		
		self assert: salesBook isEmpty.
		self assert: 1 equals: mpInterface numberOfRequestsSent.
	].! !


!CashierTest methodsFor: 'support' stamp: 'jml 11/15/2018 18:28:33'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'support' stamp: 'jml 11/15/2018 18:56:24'!
defaultCatalog
	
	| catalog |
	
	catalog _ Dictionary new.
	catalog at: self itemSellByTheStore put: 500.
	
	^ catalog! !

!CashierTest methodsFor: 'support' stamp: 'jml 11/15/2018 21:07:41'!
defaultCreditCard
	
	^ CreditCard named: 'Lector' numbered: '1111222233334444' expires: GregorianMonthOfYear current next next.! !

!CashierTest methodsFor: 'support' stamp: 'jml 11/15/2018 21:07:53'!
expiredCreditCard
	
	^ CreditCard named: 'Lector' numbered: '1111222233334444' expires: GregorianMonthOfYear current previous previous.! !

!CashierTest methodsFor: 'support' stamp: 'jml 11/15/2018 18:29:21'!
itemSellByTheStore
	
	^ 'validBook'! !


!CashierTest methodsFor: 'set up' stamp: 'jml 11/15/2018 20:43:41'!
setUp
	
	salesBook _ OrderedCollection new.
	mpInterface _ SimulatedMerchantProcessorInterface new.
	cashier _ Cashier newWithSalesBook: salesBook andInterface: mpInterface.! !


!classDefinition: #CreditCardTest category: #TusLibros!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'jml 11/15/2018 21:09:15'!
test01CannotHaveEmptyName
	
	self should: [
		CreditCard named: '' numbered: '1111222233334444' expires: GregorianMonthOfYear current.
	] raise: Error - MessageNotUnderstood
	withExceptionDo: [ :exception |
		self assert: CreditCard invalidNameErrorDescription equals: exception messageText.
	].
	! !

!CreditCardTest methodsFor: 'tests' stamp: 'jml 11/15/2018 21:13:52'!
test02CannotHaveInvalidCardNumber
	
	self should: [
		CreditCard named: 'Jorge' numbered: '1222233334444' expires: GregorianMonthOfYear current.
	] raise: Error - MessageNotUnderstood
	withExceptionDo: [ :exception |
		self assert: CreditCard invalidCardNumberErrorDescription equals: exception messageText.
	].
	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'jml 11/15/2018 18:57:25'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'jml 11/15/2018 19:14:13'!
assertIsValidQuantity: aQuantity
	
	aQuantity isInteger ifFalse: [ self error: self invalidQuantityErrorMessage ].
	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'jml 11/15/2018 19:11:18'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'accessing' stamp: 'jml 11/15/2018 19:01:23'!
catalog
	
	^ catalog! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'jml 11/15/2018 19:20:07'!
total
	
	^ items inject: 0 into: [ :total :item | total + catalog at: item ].! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'jml 11/15/2018 19:12:50'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.
	
	items add: anItem withOccurrences: aQuantity.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'salesBook mpInterface'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checking out' stamp: 'jml 11/15/2018 20:59:51'!
checkOut: aCart with: aCreditCard 
	
	| total |
	
	(aCreditCard isExpiredAt: GregorianMonthOfYear current) ifTrue: [ self error: self class expiredCreditCardErrorMessage ].
	
	aCart isEmpty ifTrue: [ self error: self class emptyCartErrorMessage ].
	
	total _ aCart total.
	
	mpInterface debit: total from: aCreditCard.
	
	salesBook add: total.
	
	"TODO return ticket?"! !


!Cashier methodsFor: 'initialization' stamp: 'jml 11/15/2018 20:41:14'!
initializeWithSalesBook: aSalesBook andInterface: anMpInterface
	
	salesBook _ aSalesBook.
	mpInterface _ anMpInterface.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: 'salesBook'!

!Cashier class methodsFor: 'error messages' stamp: 'jml 11/15/2018 18:32:43'!
emptyCartErrorMessage
	
	^ 'The cart is empty'! !

!Cashier class methodsFor: 'error messages' stamp: 'jml 11/15/2018 19:45:09'!
expiredCreditCardErrorMessage
	
	^ 'Credit card is expired'! !


!Cashier class methodsFor: 'instance creation' stamp: 'jml 11/15/2018 20:42:08'!
newWithSalesBook: aSalesBook andInterface: anMpInterface
	
	^ self new initializeWithSalesBook: aSalesBook andInterface: anMpInterface.! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationMonth name number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'assertions' stamp: 'jml 11/15/2018 21:12:29'!
assertIsValidName: aName
	
	aName isEmpty ifTrue: [ self error: self class invalidNameErrorDescription ].! !

!CreditCard methodsFor: 'assertions' stamp: 'jml 11/15/2018 21:16:27'!
assertIsValidNumber: aName
	
	"TODO otros chequeos?"
	aName size = 16 ifFalse: [ self error: self class invalidCardNumberErrorDescription ].! !


!CreditCard methodsFor: 'initialization' stamp: 'jml 11/15/2018 21:14:36'!
initializeNamed: aName numbered: aCardNumber expires: aMonthOfYear
	
	self assertIsValidName: aName.
	self assertIsValidNumber: aCardNumber.
	
	name _ aName.
	number _ aCardNumber.
	expirationMonth _ aMonthOfYear.! !


!CreditCard methodsFor: 'testing' stamp: 'jml 11/15/2018 21:01:44'!
isExpiredAt: aMonthOfYear
	
	^ expirationMonth < aMonthOfYear! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'jml 11/15/2018 21:05:41'!
named: aName numbered: aCardNumber expires: aMonthOfYear 
	
	^ self new initializeNamed: aName numbered: aCardNumber expires: aMonthOfYear.! !


!CreditCard class methodsFor: 'error messages' stamp: 'jml 11/15/2018 21:16:15'!
invalidCardNumberErrorDescription
	
	^ 'Invalid card number'! !

!CreditCard class methodsFor: 'error messages' stamp: 'jml 11/15/2018 21:13:02'!
invalidNameErrorDescription
	
	^ 'Invalid name'! !


!classDefinition: #MerchantProcessorInterface category: #TusLibros!
Object subclass: #MerchantProcessorInterface
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorInterface methodsFor: 'queries' stamp: 'jml 11/15/2018 20:45:20'!
numberOfRequestsSent
	
	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorInterface class' category: #TusLibros!
MerchantProcessorInterface class
	instanceVariableNames: ''!

!MerchantProcessorInterface class methodsFor: 'error messages' stamp: 'jml 11/15/2018 21:23:28'!
notEnoughFundsErrorDescription
	
	^ 'Card has not enough funds'! !


!classDefinition: #SimulatedMerchantProcessorInterface category: #TusLibros!
MerchantProcessorInterface subclass: #SimulatedMerchantProcessorInterface
	instanceVariableNames: 'numberOfRequests unfundedCards'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SimulatedMerchantProcessorInterface methodsFor: 'queries' stamp: 'jml 11/15/2018 20:52:26'!
numberOfRequestsSent
	
	^ numberOfRequests! !


!SimulatedMerchantProcessorInterface methodsFor: 'initialization' stamp: 'jml 11/15/2018 21:24:32'!
initialize
	
	numberOfRequests _ 0.
	unfundedCards _ Set new.! !


!SimulatedMerchantProcessorInterface methodsFor: 'requests - private' stamp: 'jml 11/15/2018 20:51:31'!
simulateRequest
	
	numberOfRequests _ numberOfRequests + 1.! !


!SimulatedMerchantProcessorInterface methodsFor: 'requests' stamp: 'jml 11/15/2018 21:25:53'!
debit: anAmount from: aCreditCard
	
	self simulateRequest.
	
	(unfundedCards includes: aCreditCard) ifTrue: [
		self error: self class notEnoughFundsErrorDescription.
	].! !


!SimulatedMerchantProcessorInterface methodsFor: 'simulating' stamp: 'jml 11/15/2018 21:24:17'!
simulateCardWithoutFunds: aCreditCard 
	
	unfundedCards add: aCreditCard.! !
