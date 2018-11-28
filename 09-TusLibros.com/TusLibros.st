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
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:07:36'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			through: testObjectsFactory defaultMerchantProcessor
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:08:21'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		through: testObjectsFactory defaultMerchantProcessor
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:08:36'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				through: testObjectsFactory defaultMerchantProcessor
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:08:46'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		through: testObjectsFactory defaultMerchantProcessor
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:10:16'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard debitBehavior |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard.
	].
	
	cashier := Cashier 
		toCheckout: cart 
		charging: creditCard
		through: (testObjectsFactory merchantProcessorWithDebitBehavior: debitBehavior)
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:10:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard debitBehavior |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage ].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		through: (testObjectsFactory merchantProcessorWithDebitBehavior: debitBehavior)
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'jml 11/27/2018 12:03:01'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #TuslibrosInterfaceTest category: #TusLibros!
TestCase subclass: #TuslibrosInterfaceTest
	instanceVariableNames: 'testObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TuslibrosInterfaceTest methodsFor: 'assertions' stamp: 'jml 11/28/2018 02:26:38'!
assertInvalidCreditCardNumber: aNumber usingInterface: interface andCartId: cartId
	
	self
		should: [
			interface
				checkoutCartWithId: cartId
				withCreditCard: aNumber
				expiringOn: DateAndTime now month
				withOwner: 'owner'.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface invalidCreditCardNumberErrorMessage equals: exception messageText.
		].! !


!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:53:55'!
test01CannotListAnInvalidCart

	self
		should: [ testObjects tusLibrosInterface listCartWithId: 666 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface cartNotFoundErrorMessage equals: exception messageText.
		].
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:55:09'!
test02CannotCreatCartForNonRegisteredUser
	
	self
		should: [ testObjects tusLibrosInterface createCartFor: testObjects wrongUser andPassword: '123' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface userNotFoundErrorMessage equals: exception messageText.
		].
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:54:58'!
test03CannotCreatCartWithWrongPassword
	
	self
		should: [ testObjects tusLibrosInterface createCartFor: testObjects defaultUser andPassword: testObjects wrongPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface invalidPasswordErrorMessage equals: exception messageText.
		].
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:55:26'!
test04NewCartsHaveDifferentIds

	| interface firstId secondId |

	interface _ testObjects tusLibrosInterface. 
	firstId _ interface createCartFor: testObjects defaultUser andPassword: testObjects defaultPassword.
	secondId _ interface createCartFor: testObjects defaultUser andPassword: testObjects defaultPassword.
	
	self deny: firstId = secondId.
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:21:16'!
test05NewCartIsListedAsEmpty
	
	| interface cartId |
	
	interface _ testObjects tusLibrosInterface. 
	cartId _ interface createCartFor: testObjects defaultUser andPassword: testObjects defaultPassword.
	
	self assert: (interface listCartWithId: cartId) isEmpty.! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:58:21'!
test06CannotAddItemToAnInvalidCart

	self
		should: [ testObjects tusLibrosInterface add: 3 of: testObjects itemSellByTheStore toCartWithId: 0.]
		raise: Error - MessageNotUnderstood
		withExceptionDo:[ :exception |
			self assert: TusLibrosInterface cartNotFoundErrorMessage equals: exception messageText.
		].
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:21:16'!
test07ItemAddedToCartIsListed
	
	| cartList interface cartId item quantity |
	
	quantity _ 3.
	item _ testObjects itemSellByTheStore.
	interface _ testObjects tusLibrosInterface. 
	
	cartId _ interface createCartFor: testObjects defaultUser andPassword: testObjects defaultPassword.
	interface add: quantity of: item toCartWithId: cartId.
	cartList _ interface listCartWithId: cartId.
	
	self deny: cartList isEmpty.
	self assert: 1 equals: cartList size.
	self assert: (cartList includesKey: item).
	self assert: quantity equals: (cartList at: item).! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:21:16'!
test08CannotAddNonPositiveNumberOfItems
	
	| interface cartId |
	
	interface _ testObjects tusLibrosInterface.
	
	cartId _ interface createCartFor: testObjects defaultUser andPassword: testObjects defaultPassword.
	
	self
		should: [ interface add: 0 of: testObjects itemSellByTheStore toCartWithId: cartId. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface invalidQuantityErrorMessage equals: exception messageText.
			self assert: (interface listCartWithId: cartId) isEmpty.
		]
	.! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:21:16'!
test09CannotAddItemsThatDoNotBelongToStore
	
	| interface cartId |
	
	interface _ testObjects tusLibrosInterface.
	
	cartId _ interface createCartFor: testObjects defaultUser andPassword: testObjects defaultPassword.
	
	self
		should: [ interface add: 10 of: testObjects itemNotSellByTheStore toCartWithId: cartId. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface invalidItemErrorMessage equals: exception messageText.
			self assert: (interface listCartWithId: cartId) isEmpty.
		]
	.! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/27/2018 13:01:56'!
test10CannotCheckoutAnInvalidCart
	
	| interface creditCard |
	
	interface _ testObjects tusLibrosInterface.
	
	creditCard  _ testObjects notExpiredCreditCard.
	
	self
		should: [
			interface
				checkoutCartWithId: 666
				withCreditCard: creditCard number
				expiringOn: creditCard expiration
				withOwner: creditCard owner.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface cartNotFoundErrorMessage equals: exception messageText.
		].
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/27/2018 13:02:15'!
test11CannotCheckoutAnEmptyCart
	
	| interface cartId creditCard |
	
	interface _ testObjects tusLibrosInterface.
	cartId _ interface createCartFor: testObjects defaultUser andPassword: testObjects defaultPassword.
	
	creditCard  _ testObjects notExpiredCreditCard.
	
	self
		should: [
			interface
				checkoutCartWithId: cartId
				withCreditCard: creditCard number
				expiringOn: creditCard expiration
				withOwner: creditCard owner.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface cartCanNotBeEmptyErrorMessage equals: exception messageText.
		]
	.
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:21:16'!
test12CannotCheckoutWithAnExpiredCreditCart
	
	| interface cartId item quantity creditCard |
	
	quantity _ 3.
	item _ testObjects itemSellByTheStore.
	creditCard  _ testObjects expiredCreditCard.
	
	interface _ testObjects tusLibrosInterface. 
	cartId _ interface createCartFor: testObjects defaultUser andPassword: testObjects defaultPassword.
	interface add: quantity of: item toCartWithId: cartId.
	
	self
		should: [
			interface
				checkoutCartWithId: cartId
				withCreditCard: creditCard number
				expiringOn: creditCard expiration
				withOwner: creditCard owner.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface canNotChargeAnExpiredCreditCardErrorMessage equals: exception messageText.
		].! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 02:26:56'!
test12_01CannotCheckoutWithAnInvalidCreditCardNumber
	
	| interface cartId item quantity |
	
	quantity _ 3.
	item _ testObjects itemSellByTheStore.
	interface _ testObjects tusLibrosInterface. 
	
	cartId _ interface createCartFor: testObjects defaultUser andPassword: testObjects defaultPassword.
	interface add: quantity of: item toCartWithId: cartId.
	
	self assertInvalidCreditCardNumber: 1234 usingInterface: interface andCartId: cartId.
	self assertInvalidCreditCardNumber: '123412341234123' usingInterface: interface andCartId: cartId.
	self assertInvalidCreditCardNumber: 'ABC4123412341234' usingInterface: interface andCartId: cartId.! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:21:16'!
test13CannotCheckoutWhenTheCreditCardHasNoCredit

	| interface cartId item quantity creditCard |
	
	quantity _ 3.
	item _ testObjects itemSellByTheStore.
	interface _ testObjects tusLibrosInterfaceWithDebitBehavior: [ :anAmount :aCreditCard |
		self error: TusLibrosInterface creditCardHasNoCreditErrorMessage
	].
	
	cartId _ interface createCartFor: testObjects defaultUser andPassword: testObjects defaultPassword.
	interface add: quantity of: item toCartWithId: cartId.
	creditCard _ testObjects notExpiredCreditCard.
	
	self
		should: [
			interface
				checkoutCartWithId: cartId
				withCreditCard: creditCard number
				expiringOn: creditCard expiration
				withOwner: creditCard owner
			.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface creditCardHasNoCreditErrorMessage equals: exception messageText.
		].! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:21:16'!
test14CheckoutChargesCreditCardUsingMerchantProcessor

	| interface cartId item numberOfItems creditCard debitedAmount price debitedCreditCard |
	
	numberOfItems _ 3.
	item _ testObjects itemSellByTheStore.
	price _ testObjects itemSellByTheStorePrice.
	
	interface _ testObjects tusLibrosInterfaceWithDebitBehavior: [ :anAmount :aCreditCard |
		debitedAmount _ anAmount.
		debitedCreditCard _ aCreditCard.
	].
	
	cartId _ interface createCartFor: testObjects defaultUser andPassword: testObjects defaultPassword.
	interface add: numberOfItems of: item toCartWithId: cartId.
	creditCard _ testObjects notExpiredCreditCard.
	
	interface
		checkoutCartWithId: cartId
		withCreditCard: creditCard number
		expiringOn: creditCard expiration
		withOwner: creditCard owner.
	
	self assert: numberOfItems * price equals: debitedAmount.
	self assert: creditCard equals: debitedCreditCard.! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:21:16'!
test15CannotListPurchasesForNonRegisteredUser
	
	| interface |
	
	interface _ testObjects tusLibrosInterface.
	
	self
		should: [ interface listPurchasesFor: testObjects wrongUser andPassword: '123' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo:[ :exception |
			self assert: TusLibrosInterface userNotFoundErrorMessage equals: exception messageText.
		].
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:21:16'!
test16CannotListPurchasesWithWrongPassword

	| interface |
	
	interface _ testObjects tusLibrosInterface.
	
	self
		should: [ interface listPurchasesFor: testObjects defaultUser andPassword: '123' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo:[ :exception |
			self assert: TusLibrosInterface invalidPasswordErrorMessage equals: exception messageText.
		].
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:21:16'!
test17PurchaseListForNewUserIsEmpty

	| interface purchases |
	
	interface _ testObjects tusLibrosInterface.
	
	purchases _ interface listPurchasesFor: testObjects defaultUser andPassword: testObjects defaultPassword.
	
	self assert: purchases contents isEmpty.
	self assert: 0 equals: purchases total.! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:21:16'!
test18PurchaseIsListed

	| interface purchaseList cartId creditCard item numberOfItems password user purchases |
	
	user _ testObjects defaultUser.
	password _ testObjects defaultPassword.
	numberOfItems _ 3.
	item _ testObjects itemSellByTheStore.
	
	interface _ testObjects tusLibrosInterface.
	
	cartId _ interface createCartFor: user andPassword: password.
	interface add: numberOfItems of: item toCartWithId: cartId.
	creditCard _ testObjects notExpiredCreditCard.
	
	interface
		checkoutCartWithId: cartId
		withCreditCard: creditCard number
		expiringOn: creditCard expiration
		withOwner: creditCard owner.
		
	purchases _ interface listPurchasesFor: user andPassword: password.
	purchaseList _ purchases contents.
	
	self deny: purchaseList isEmpty.
	self assert: 1 equals: purchaseList size.
	self assert: (purchaseList includesKey: item).
	self assert: numberOfItems equals: (purchaseList at: item).
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:21:16'!
test19PurchasesOfAnotherUserAreNotListed

	| listingUser purchasingUser interface cartId creditCard item numberOfItems purchases |
	
	listingUser _ testObjects defaultUser.
	purchasingUser _ testObjects secondUser.
	
	numberOfItems _ 3.
	item _ testObjects itemSellByTheStore.
	
	interface _ testObjects tusLibrosInterface.
	
	cartId _ interface createCartFor: purchasingUser andPassword: testObjects secondUserPassword.
	
	interface add: numberOfItems of: item toCartWithId: cartId.
	creditCard _ testObjects notExpiredCreditCard.
	
	interface
		checkoutCartWithId: cartId
		withCreditCard: creditCard number
		expiringOn: creditCard expiration
		withOwner: creditCard owner.
		
	purchases _ interface listPurchasesFor: listingUser andPassword: testObjects defaultPassword.
	
	self assert: purchases contents isEmpty.
	self assert: 0 equals: purchases total.! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/27/2018 12:21:16'!
test20SeveralPurchasesAreAddedInList

	| interface purchaseList creditCard item password user purchases cartId1 cartId2 quantity1 quantity2 |
	
	user _ testObjects defaultUser.
	password _ testObjects defaultPassword.
	quantity1 _ 3.
	quantity2 _ 5.
	creditCard _ testObjects notExpiredCreditCard.
	item _ testObjects itemSellByTheStore.
	
	interface _ testObjects tusLibrosInterface.
	cartId1 _ interface createCartFor: user andPassword: password.
	
	interface add: quantity1 of: item toCartWithId: cartId1.
	interface
		checkoutCartWithId: cartId1
		withCreditCard: creditCard number
		expiringOn: creditCard expiration
		withOwner: creditCard owner.
	
	cartId2 _ interface createCartFor: user andPassword: password.
	
	interface add: quantity2 of: item toCartWithId: cartId2.
	interface
		checkoutCartWithId: cartId2
		withCreditCard: creditCard number
		expiringOn: creditCard expiration
		withOwner: creditCard owner.
		
	purchases _ interface listPurchasesFor: user andPassword: password.
	purchaseList _ purchases contents.
	
	self deny: purchaseList isEmpty.
	self assert: 1 equals: purchaseList size.
	self assert: (purchaseList includesKey: item).
	self assert: quantity1 + quantity2 equals: (purchaseList at: item).
	! !


!TuslibrosInterfaceTest methodsFor: 'setup' stamp: 'jml 11/27/2018 12:21:16'!
setUp

	testObjects := StoreTestObjectsFactory new.
	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog contents user'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'jml 11/25/2018 23:46:03'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'jml 11/25/2018 23:46:13'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'jml 11/26/2018 18:52:55'!
initializeFor: aUser acceptingItemsOf: aCatalog
	
	user _ aUser.
	catalog _ aCatalog.
	contents _ Dictionary new.! !


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

!Cart methodsFor: 'accessing' stamp: 'jml 11/26/2018 18:55:55'!
user
	
	^ user ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'jml 11/26/2018 18:52:27'!
for: aUser acceptingItemsOf: aCatalog

	^ self new initializeFor: aUser acceptingItemsOf: aCatalog ! !


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

!Cashier methodsFor: 'checkout - private' stamp: 'jml 11/26/2018 18:55:39'!
createSale
	
	^ Sale of: cart user withContents: cart contents andTotal: total
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


!Cashier methodsFor: 'initialization' stamp: 'jml 11/27/2018 12:00:16'!
initializeToCheckout: aCart charging: aCreditCard through: aMerchantProcessor registeringOn: aSalesBook
	
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


!Cashier class methodsFor: 'instance creation' stamp: 'jml 11/27/2018 12:00:58'!
toCheckout: aCart charging: aCreditCard through: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard through: aMerchantProcessor registeringOn: aSalesBook! !


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
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'jml 11/28/2018 02:03:57'!
initializeExpiringOn: aMonth withNumber: aNumber andOwner: anOwner 
	
	expiration := aMonth.
	number := aNumber.
	owner := anOwner.! !


!CreditCard methodsFor: 'accessing' stamp: 'LA 11/26/2018 04:55:42'!
expiration

	^expiration! !

!CreditCard methodsFor: 'accessing' stamp: 'LA 11/26/2018 04:55:34'!
number

	^number! !

!CreditCard methodsFor: 'accessing' stamp: 'LA 11/26/2018 04:55:50'!
owner
	
	^owner! !


!CreditCard methodsFor: 'comparing' stamp: 'jml 11/26/2018 17:56:56'!
= anObject
	
	(self == anObject) ifTrue: [ ^ true ].
	(anObject isKindOf: self class) ifFalse: [ ^ false ].
	
	^ number = anObject number
		and: [ owner = anObject owner ]
		and: [ expiration = anObject expiration ]
	
	! !

!CreditCard methodsFor: 'comparing' stamp: 'jml 11/26/2018 17:59:12'!
hash
	
	^ number hash bitXor: (owner hash bitXor: expiration hash)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'validating' stamp: 'jml 11/28/2018 02:20:15'!
validateNumber: aNumber
	
	((aNumber isKindOf: String) and: [ aNumber size = 16 ] and: [ aNumber allSatisfy: [ :char | char isDigit ]  ])
		ifFalse: [ self error: self invalidCreditCardNumberErrorMessage ].! !


!CreditCard class methodsFor: 'instance creation' stamp: 'jml 11/28/2018 02:04:20'!
expiringOn: aMonth withNumber: aNumber andOwner: anOwner 
	
	self validateNumber: aNumber.
	
	^self new initializeExpiringOn: aMonth withNumber: aNumber andOwner: anOwner ! !


!CreditCard class methodsFor: 'error messages' stamp: 'jml 11/28/2018 02:12:58'!
invalidCreditCardNumberErrorMessage
	
	^ 'Invalid credit card number'! !


!classDefinition: #MerchantProcessorInterface category: #TusLibros!
Object subclass: #MerchantProcessorInterface
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorInterface methodsFor: 'operations' stamp: 'LA 11/22/2018 15:37:34'!
debit: anAmount from: aCreditCard
	
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
	instanceVariableNames: 'debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SimulatedMerchantProcessorInterface methodsFor: 'initialization' stamp: 'jml 11/26/2018 17:09:13'!
initializeWithDebitBehavior: aBehavior
	
	debitBehavior _ aBehavior.! !


!SimulatedMerchantProcessorInterface methodsFor: 'operations' stamp: 'jml 11/26/2018 19:05:34'!
debit: anAmount from: aCreditCard
	
	debitBehavior value: anAmount value: aCreditCard.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SimulatedMerchantProcessorInterface class' category: #TusLibros!
SimulatedMerchantProcessorInterface class
	instanceVariableNames: ''!

!SimulatedMerchantProcessorInterface class methodsFor: 'instance creation' stamp: 'jml 11/26/2018 17:08:55'!
withDebitBehavior: aBehavior
	
	^ self new initializeWithDebitBehavior: aBehavior ! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total contents user'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'accessing' stamp: 'jml 11/26/2018 18:28:49'!
contents
	
	^ contents! !

!Sale methodsFor: 'accessing' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !

!Sale methodsFor: 'accessing' stamp: 'jml 11/26/2018 18:58:46'!
user
	
	^ user! !


!Sale methodsFor: 'initialization' stamp: 'jml 11/26/2018 18:54:37'!
initializeOf: aUser withContents: aContent andTotal: anAmount
	
	user _ aUser.
	contents _ aContent.
	total _ anAmount.! !

!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'jml 11/26/2018 18:54:17'!
of: aUser withContents: aContent andTotal: anAmount
	
	^ self new initializeOf: aUser withContents: aContent andTotal: anAmount! !


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


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'jml 11/26/2018 18:53:29'!
createCart
	
	^Cart for: self defaultUser acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LA 11/26/2018 04:59:19'!
expiredCreditCard
	
	^CreditCard expiringOn:  (Month month: today monthIndex year: today yearNumber - 1) withNumber: '1111222244445555' andOwner: 'manolo'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LA 11/26/2018 04:59:08'!
notExpiredCreditCard
	
	^CreditCard expiringOn:  (Month month: today monthIndex year: today yearNumber + 1) withNumber: '1111222244445555' andOwner: 'manolo'! !


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

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'jml 11/26/2018 18:45:48'!
registeredUsers

	| registeredUsers |
	
	registeredUsers _ Dictionary new.
	registeredUsers at: self defaultUser put: self defaultPassword.
	registeredUsers at: self secondUser put: self secondUserPassword.
	
	^ registeredUsers
	
		! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'jml 11/26/2018 18:44:35'!
secondUser
	
	^ 'cacho'! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'jml 11/26/2018 18:45:15'!
secondUserPassword
	
	^ '1245645'! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'LA 11/22/2018 20:14:53'!
wrongPassword
	
	^ '1234'! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'LA 11/22/2018 20:16:40'!
wrongUser
	
	^ 'pepe'! !


!StoreTestObjectsFactory methodsFor: 'interface' stamp: 'jml 11/27/2018 12:13:31'!
tusLibrosInterface
	
	^ self tusLibrosInterfaceWithDebitBehavior: [ :anAmount :aCreditCard | ]! !

!StoreTestObjectsFactory methodsFor: 'interface' stamp: 'jml 11/27/2018 12:12:59'!
tusLibrosInterfaceWithDebitBehavior: aBehavior
	
	| mp |
	
	mp _ self merchantProcessorWithDebitBehavior: aBehavior.
	
	^ TusLibrosInterface newWithUsers: self registeredUsers catalog: self defaultCatalog merchantProcessor: mp.! !


!StoreTestObjectsFactory methodsFor: 'merchant processor' stamp: 'jml 11/27/2018 12:06:50'!
defaultMerchantProcessor
	
	^ SimulatedMerchantProcessorInterface withDebitBehavior: [ :anAmount :aCreditCart | ]! !

!StoreTestObjectsFactory methodsFor: 'merchant processor' stamp: 'jml 11/27/2018 12:06:05'!
merchantProcessorWithDebitBehavior: aBehavior
	
	^ SimulatedMerchantProcessorInterface withDebitBehavior: aBehavior! !


!classDefinition: #TusLibrosInterface category: #TusLibros!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'users lastId activeCarts catalog sales merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterface methodsFor: 'carts' stamp: 'jml 11/26/2018 00:58:02'!
findCartWithId: aCartId
	
	(activeCarts includesKey: aCartId) ifFalse: [ self error: self class cartNotFoundErrorMessage ].
	
	^ activeCarts at: aCartId! !

!TusLibrosInterface methodsFor: 'carts' stamp: 'LA 11/22/2018 20:46:27'!
newId
	
	lastId _ lastId + 1.
	
	^ lastId
	! !


!TusLibrosInterface methodsFor: 'resources' stamp: 'jml 11/26/2018 00:58:02'!
add: aQuantity of: anItem toCartWithId: aCartId 
	
	| cart |
	
	cart _ self findCartWithId: aCartId.
	
	cart add: aQuantity of: anItem.! !

!TusLibrosInterface methodsFor: 'resources' stamp: 'jml 11/27/2018 12:19:43'!
checkoutCartWithId: aCartId withCreditCard: aCreditCardNumber expiringOn: expirationMonthOfYear withOwner: aName 
	
	| cart cashier total creditCard |
	
	cart _ self findCartWithId: aCartId.
	creditCard _ CreditCard expiringOn: expirationMonthOfYear withNumber: aCreditCardNumber andOwner: aName.

	cashier _ Cashier
		toCheckout: cart
		charging: creditCard
		through: merchantProcessor
		on: DateAndTime now
		registeringOn: sales.
	
	total _ cashier checkOut.
	^ total
! !

!TusLibrosInterface methodsFor: 'resources' stamp: 'jml 11/26/2018 18:51:38'!
createCartFor: anUserName andPassword: aPassword
	
	| cartId cart |
	
	(users includesKey: anUserName ) ifFalse: [self error: self class userNotFoundErrorMessage ].
	((users at: anUserName) = aPassword) ifFalse: [self error: self class invalidPasswordErrorMessage ].
	
	cartId _ self newId.
	
	cart _ Cart for: anUserName acceptingItemsOf: catalog.
	
	activeCarts at: cartId put: cart.
	
	^ cartId! !

!TusLibrosInterface methodsFor: 'resources' stamp: 'jml 11/26/2018 00:58:02'!
listCartWithId: aCartId
	
	| cart |
	
	cart _ self findCartWithId: aCartId.
	
	^ cart contents! !

!TusLibrosInterface methodsFor: 'resources' stamp: 'jml 11/26/2018 18:58:22'!
listPurchasesFor: aUserName andPassword: aPassword 

	| userSales purchasedItems total |
	
	(users includesKey: aUserName ) ifFalse: [self error: self class userNotFoundErrorMessage ].
	((users at: aUserName) = aPassword) ifFalse: [self error: self class invalidPasswordErrorMessage ].
	
	total _ 0.
	
	purchasedItems _ Dictionary new.
	
	userSales _ sales select: [ :sale | sale user = aUserName ].
	
	userSales do: [ :sale |
		total _ total + sale total.
		sale contents associationsDo: [ :assoc | | currentQuantity item quantity |
			item _ assoc key.
			quantity _ assoc value.
			currentQuantity _ purchasedItems at: item ifAbsent: 0.
			purchasedItems at: item put: currentQuantity + quantity.
		].
	].
	
	^ Sale of: aUserName withContents: purchasedItems andTotal: total! !


!TusLibrosInterface methodsFor: 'initialization' stamp: 'jml 11/26/2018 17:14:48'!
initializeWithUsers: registeredUsers catalog: aCatalog merchantProcessor: aMerchantProcessor

	users _ registeredUsers.
	catalog _ aCatalog.
	merchantProcessor _ aMerchantProcessor.
	sales _ OrderedCollection new.
	
	lastId _ 0.
	activeCarts _ Dictionary new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInterface class' category: #TusLibros!
TusLibrosInterface class
	instanceVariableNames: ''!

!TusLibrosInterface class methodsFor: 'error messages' stamp: 'jml 11/27/2018 11:54:04'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^ Cashier canNotChargeAnExpiredCreditCardErrorMessage! !

!TusLibrosInterface class methodsFor: 'error messages' stamp: 'jml 11/27/2018 11:53:36'!
cartCanNotBeEmptyErrorMessage
	
	^ Cashier cartCanNotBeEmptyErrorMessage! !

!TusLibrosInterface class methodsFor: 'error messages' stamp: 'LA 11/22/2018 19:51:13'!
cartNotFoundErrorMessage
	
	^'Cart not found'! !

!TusLibrosInterface class methodsFor: 'error messages' stamp: 'jml 11/27/2018 11:54:52'!
creditCardHasNoCreditErrorMessage
	
	^ Cashier creditCardHasNoCreditErrorMessage! !

!TusLibrosInterface class methodsFor: 'error messages' stamp: 'jml 11/28/2018 02:23:04'!
invalidCreditCardNumberErrorMessage
	
	^ CreditCard invalidCreditCardNumberErrorMessage! !

!TusLibrosInterface class methodsFor: 'error messages' stamp: 'jml 11/27/2018 11:52:55'!
invalidItemErrorMessage
	
	^ Cart invalidItemErrorMessage! !

!TusLibrosInterface class methodsFor: 'error messages' stamp: 'LA 11/22/2018 20:01:05'!
invalidPasswordErrorMessage
	
	^'InvalidPassword'! !

!TusLibrosInterface class methodsFor: 'error messages' stamp: 'jml 11/27/2018 11:52:19'!
invalidQuantityErrorMessage
	
	^ Cart invalidQuantityErrorMessage! !

!TusLibrosInterface class methodsFor: 'error messages' stamp: 'LA 11/22/2018 19:58:17'!
userNotFoundErrorMessage
	
	^'User not found'! !


!TusLibrosInterface class methodsFor: 'instance creation' stamp: 'jml 11/26/2018 17:15:31'!
newWithUsers: users catalog: aCatalog merchantProcessor: aMerchantProcessor

	^ self new initializeWithUsers: users catalog: aCatalog merchantProcessor: aMerchantProcessor! !
