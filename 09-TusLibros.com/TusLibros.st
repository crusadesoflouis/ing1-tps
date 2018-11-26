!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'jml 11/25/2018 23:44:36'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'jml 11/25/2018 23:44:41'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'jml 11/25/2018 23:44:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TuslibrosInterfaceTest category: #TusLibros!
TestCase subclass: #TuslibrosInterfaceTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/25/2018 23:19:00'!
test01CannotListAnInvalidCart

	self
		should: [ testObjectsFactory tusLibrosInterface listCart: 666 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo:[ :exception |
			self assert: TusLibrosInterface cartNotFoundErrorMessage equals: exception messageText.
		].
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/25/2018 23:18:55'!
test02CannotCreatCartForNonRegisteredUser
	
	| interface |
	
	interface _ testObjectsFactory tusLibrosInterface.
	
	self
		should: [ interface createCartFor: testObjectsFactory wrongUser andPassword: '123' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo:[ :exception |
			self assert: TusLibrosInterface userNotFoundErrorMessage equals: exception messageText.
		].
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/25/2018 23:18:50'!
test03CannotCreatCartWithWrongPassword
	
	| interface |
	
	interface _ testObjectsFactory tusLibrosInterface.
	
	self
		should: [ interface createCartFor: testObjectsFactory defaultUser andPassword: testObjectsFactory wrongPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo:[ :exception |
			self assert: TusLibrosInterface invalidPasswordErrorMessage equals: exception messageText.
		].
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'LA 11/22/2018 20:32:56'!
test04NewCartsHaveDifferentIds

	| interface firstId secondId |

	interface _ testObjectsFactory tusLibrosInterface. 
	firstId _ interface createCartFor: testObjectsFactory defaultUser andPassword: testObjectsFactory defaultPassword.
	secondId _ interface createCartFor: testObjectsFactory defaultUser andPassword: testObjectsFactory defaultPassword.
	
	self deny: firstId  = secondId.
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/25/2018 23:20:18'!
test05NewCartIsListedAsEmpty
	
	| interface cartId |
	
	interface _ testObjectsFactory tusLibrosInterface. 
	cartId _ interface createCartFor: testObjectsFactory defaultUser andPassword: testObjectsFactory defaultPassword.
	
	self assert: (interface listCart: cartId) isEmpty.! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/25/2018 23:18:39'!
test06CannotAddItemToAnInvalidCart


	self
		should: [ testObjectsFactory tusLibrosInterface add: 3 of: testObjectsFactory itemSellByTheStore toCartWithId: 0.]
		raise: Error - MessageNotUnderstood
		withExceptionDo:[ :exception |
			self assert: TusLibrosInterface cartNotFoundErrorMessage equals: exception messageText.
		].
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/25/2018 23:21:58'!
test07ItemAddedToCartIsListed
	
	| cartList interface cartId item quantity |
	
	quantity _ 3.
	item _ testObjectsFactory itemSellByTheStore.
	interface _ testObjectsFactory tusLibrosInterface. 
	
	cartId _ interface createCartFor: testObjectsFactory defaultUser andPassword: testObjectsFactory defaultPassword.
	interface add: quantity of: item toCartWithId: cartId.
	cartList _ interface listCart: cartId.
	
	self deny: cartList isEmpty.
	self assert: 1 equals: cartList size.
	self assert: (cartList includesKey: item).
	self assert: quantity equals: (cartList at: item).! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/25/2018 23:46:38'!
test08CannotAddNonPositiveNumberOfItems
	
	| interface cartId |
	
	interface _ testObjectsFactory tusLibrosInterface.
	
	cartId _ interface createCartFor: testObjectsFactory defaultUser andPassword: testObjectsFactory defaultPassword.
	
	self
		should: [ interface add: 0 of: testObjectsFactory itemSellByTheStore toCartWithId: cartId. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: Cart invalidQuantityErrorMessage equals: exception messageText.
			self assert: (interface listCart: cartId) isEmpty.
		]
	.! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/25/2018 23:48:11'!
test09CannotAddItemsThatDoNotBelongToStore
	
	| interface cartId |
	
	interface _ testObjectsFactory tusLibrosInterface.
	
	cartId _ interface createCartFor: testObjectsFactory defaultUser andPassword: testObjectsFactory defaultPassword.
	
	self
		should: [ interface add: 10 of: testObjectsFactory itemNotSellByTheStore toCartWithId: cartId. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: Cart invalidItemErrorMessage equals: exception messageText.
			self assert: (interface listCart: cartId) isEmpty.
		]
	.! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/26/2018 00:35:24'!
test10CannotCheckoutAnInvalidCart
	
	| interface |
	
	interface _ testObjectsFactory tusLibrosInterface.
	
	self
		should: [ interface checkOutCartWithId: 766 ccn: '0' expiratingOn: 1 of: 2040 owner: 'manolo'. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface cartNotFoundErrorMessage equals: exception messageText.
		]
	.
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/26/2018 00:37:04'!
test11CannotCheckoutAnEmptyCart
	
	| interface cartId |
	
	interface _ testObjectsFactory tusLibrosInterface.
	cartId _ interface createCartFor: testObjectsFactory defaultUser andPassword: testObjectsFactory defaultPassword.
	
	self
		should: [ interface checkOutCartWithId: cartId ccn: '0' expiratingOn: 1 of: 2040 owner: 'manolo'. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: Cashier cartCanNotBeEmptyErrorMessage equals: exception messageText.
		]
	.
	! !


!TuslibrosInterfaceTest methodsFor: 'setUp' stamp: 'LA 11/22/2018 20:19:29'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'jml 11/25/2018 23:46:03'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'jml 11/25/2018 23:46:13'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'LA 11/22/2018 21:32:37'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	contents := Dictionary new.! !


!Cart methodsFor: 'queries' stamp: 'LA 11/22/2018 21:35:59'!
occurrencesOf: anItem

	^ contents at: anItem ifAbsent: 0! !


!Cart methodsFor: 'testing' stamp: 'LA 11/22/2018 21:34:35'!
includes: anItem

	^ contents includesKey: anItem ! !

!Cart methodsFor: 'testing' stamp: 'LA 11/22/2018 21:34:47'!
isEmpty
	
	^contents isEmpty ! !


!Cart methodsFor: 'total' stamp: 'LA 11/22/2018 21:45:07'!
total
	
	^ contents keys inject: 0 into: [ :subtotal :item |
		| price quantity |
		
		price _ catalog at: item.
		quantity _ contents at: item.
		
		subtotal + (price * quantity).
	].! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'LA 11/22/2018 21:36:36'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.
	
	contents at: anItem put: (self occurrencesOf: anItem) + aQuantity.! !


!Cart methodsFor: 'accessing' stamp: 'LA 11/22/2018 21:34:21'!
contents
	
	^ contents! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'jml 11/25/2018 23:43:50'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'jml 11/25/2018 23:44:01'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'users' stamp: 'LA 11/22/2018 20:14:30'!
defaultPassword
	
	^ '1235'! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'LA 11/22/2018 20:14:15'!
defaultUser
	
	^ 'manolo'! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'LA 11/22/2018 20:14:02'!
registeredUsers

	|registeredUsers|
	
	registeredUsers _ Dictionary new.
	registeredUsers at: self defaultUser put: self defaultPassword.
	
	^ registeredUsers
	
		! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'LA 11/22/2018 20:14:53'!
wrongPassword
	
	^ '1234'! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'LA 11/22/2018 20:16:40'!
wrongUser
	
	^ 'pepe'! !


!StoreTestObjectsFactory methodsFor: 'interface' stamp: 'LA 11/22/2018 21:22:06'!
tusLibrosInterface
	
	^ TusLibrosInterface newWithUsers: self registeredUsers andCatalog: self defaultCatalog! !


!classDefinition: #TusLibrosInterface category: #TusLibros!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'users lastId activeCarts catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterface methodsFor: 'carts' stamp: 'LA 11/22/2018 21:27:14'!
findCart: aCartId
	
	(activeCarts includesKey: aCartId) ifFalse: [ self error: self class cartNotFoundErrorMessage ].
	
	^ activeCarts at: aCartId! !

!TusLibrosInterface methodsFor: 'carts' stamp: 'LA 11/22/2018 20:46:27'!
newId
	
	lastId _ lastId + 1.
	
	^ lastId
	! !


!TusLibrosInterface methodsFor: 'resources' stamp: 'jml 11/25/2018 23:42:00'!
add: aQuantity of: anItem toCartWithId: aCartId 
	
	| cart |
	
	cart _ self findCart: aCartId.
	
	cart add: aQuantity of: anItem.! !

!TusLibrosInterface methodsFor: 'resources' stamp: 'jml 11/26/2018 00:43:24'!
checkOutCartWithId: aCartId ccn: aCreditCardNumber expiratingOn: expirationMonth of: expirationYear owner: aName 
	
	| cart cashier total |
	
	cart _ self findCart: aCartId.
	
	cashier _ Cashier
		toCheckout: cart
		charging: nil
		throught: nil
		on: nil
		registeringOn: nil
	.
	
	total _ cashier checkOut.
	
	^ total! !

!TusLibrosInterface methodsFor: 'resources' stamp: 'LA 11/22/2018 21:19:37'!
createCartFor: anUserName andPassword: aPassword
	
	| cartId cart |
	
	(users includesKey: anUserName ) ifFalse: [self error: self class userNotFoundErrorMessage ].
	((users at: anUserName) = aPassword) ifFalse: [self error: self class invalidPasswordErrorMessage ].
	
	cartId _ self newId.
	
	cart _ Cart acceptingItemsOf: catalog.
	
	activeCarts at: cartId put: cart.
	
	^ cartId! !

!TusLibrosInterface methodsFor: 'resources' stamp: 'LA 11/22/2018 21:29:24'!
listCart: aCartId
	
	| cart |
	
	cart _ self findCart: aCartId.
	
	^ cart contents! !


!TusLibrosInterface methodsFor: 'initialization' stamp: 'LA 11/22/2018 21:20:18'!
initializeWithUsers: registeredUsers andCatalog: aCatalog

	users _ registeredUsers.
	catalog _ aCatalog.
	
	lastId _ 0.
	activeCarts _ Dictionary new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInterface class' category: #TusLibros!
TusLibrosInterface class
	instanceVariableNames: ''!

!TusLibrosInterface class methodsFor: 'error messages' stamp: 'LA 11/22/2018 19:51:13'!
cartNotFoundErrorMessage
	
	^'Cart not found'! !

!TusLibrosInterface class methodsFor: 'error messages' stamp: 'LA 11/22/2018 20:01:05'!
invalidPasswordErrorMessage
	
	^'InvalidPassword'! !

!TusLibrosInterface class methodsFor: 'error messages' stamp: 'LA 11/22/2018 19:58:17'!
userNotFoundErrorMessage
	
	^'User not found'! !


!TusLibrosInterface class methodsFor: 'instance creation' stamp: 'LA 11/22/2018 21:21:21'!
newWithUsers: users andCatalog: aCatalog

	^self new initializeWithUsers: users andCatalog: aCatalog.! !
