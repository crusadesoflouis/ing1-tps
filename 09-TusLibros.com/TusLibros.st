!classDefinition: #ExpiredObjectError category: #TusLibros!
Error subclass: #ExpiredObjectError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


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

!CashierTest methodsFor: 'tests' stamp: 'jml 11/28/2018 18:50:14'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			through: testObjectsFactory defaultMerchantProcessor
			measuringTimeWith: testObjectsFactory clock
			registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'jml 11/28/2018 18:50:20'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		through: testObjectsFactory defaultMerchantProcessor
		measuringTimeWith: testObjectsFactory clock 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'jml 11/28/2018 18:51:10'!
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
				measuringTimeWith: testObjectsFactory clock
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'jml 11/28/2018 18:54:23'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		through: testObjectsFactory defaultMerchantProcessor
		measuringTimeWith: testObjectsFactory clock
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'jml 11/28/2018 18:54:27'!
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
		measuringTimeWith: testObjectsFactory clock
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'jml 11/28/2018 18:54:31'!
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
		measuringTimeWith: testObjectsFactory clock
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
	instanceVariableNames: 'testObjects interface clock user password item creditCard price'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TuslibrosInterfaceTest methodsFor: 'assertions' stamp: 'jml 11/28/2018 18:58:29'!
assertInvalidCreditCardNumber: aNumber usingCartId: cartId
	
	self
		should: [
			interface
				checkoutCartWithId: cartId
				withCreditCard: aNumber
				expiringOn: testObjects currentMonth previous
				withOwner: 'owner'.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface invalidCreditCardNumberErrorMessage equals: exception messageText.
		].! !


!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 15:48:05'!
test01CannotListAnInvalidCart

	self
		should: [ interface listCartWithId: 666 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface cartNotFoundErrorMessage equals: exception messageText.
		].
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 15:48:14'!
test02CannotCreatCartForNonRegisteredUser
	
	self
		should: [ interface createCartFor: testObjects wrongUser andPassword: '123' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface userNotFoundErrorMessage equals: exception messageText.
		].
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 16:03:36'!
test03CannotCreatCartWithWrongPassword
	
	self
		should: [ interface createCartFor: user andPassword: testObjects wrongPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface invalidPasswordErrorMessage equals: exception messageText.
		].
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 16:07:10'!
test04NewCartsHaveDifferentIds

	| firstId secondId |

	firstId _ self createCart.
	secondId _ self createCart.
	
	self deny: firstId = secondId.
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 16:06:47'!
test05NewCartIsListedAsEmpty
	
	| cartId |
	
	cartId _ self createCart.
	
	self assert: (interface listCartWithId: cartId) isEmpty.! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 16:04:34'!
test06CannotAddItemToAnInvalidCart

	self
		should: [ interface add: 3 of: item toCartWithId: 0.]
		raise: Error - MessageNotUnderstood
		withExceptionDo:[ :exception |
			self assert: TusLibrosInterface cartNotFoundErrorMessage equals: exception messageText.
		].
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 16:07:24'!
test07ItemAddedToCartIsListed
	
	| cartList cartId quantity |
	
	quantity _ 3.
	
	cartId _ self createCart.
	interface add: quantity of: item toCartWithId: cartId.
	cartList _ interface listCartWithId: cartId.
	
	self deny: cartList isEmpty.
	self assert: 1 equals: cartList contents size.
	self assert: (cartList includes: item).
	self assert: quantity equals: (cartList occurrencesOf: item).! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 16:07:55'!
test08CannotAddNonPositiveNumberOfItems
	
	| cartId |
	
	cartId _ self createCart.
	
	self
		should: [ interface add: 0 of: item toCartWithId: cartId. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface invalidQuantityErrorMessage equals: exception messageText.
			self assert: (interface listCartWithId: cartId) isEmpty.
		]
	.! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 16:08:07'!
test09CannotAddItemsThatDoNotBelongToStore
	
	| cartId |
	
	cartId _ self createCart.
	
	self
		should: [ interface add: 10 of: testObjects itemNotSellByTheStore toCartWithId: cartId. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface invalidItemErrorMessage equals: exception messageText.
			self assert: (interface listCartWithId: cartId) isEmpty.
		]
	.! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 16:25:01'!
test10CannotCheckoutAnInvalidCart
	
	self
		should: [ self checkoutCartWithId: 666 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface cartNotFoundErrorMessage equals: exception messageText.
		].
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 16:25:30'!
test11CannotCheckoutAnEmptyCart
	
	| cartId |
	
	cartId _ self createCart.
	
	self
		should: [ self checkoutCartWithId: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface cartCanNotBeEmptyErrorMessage equals: exception messageText.
		]
	.
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 16:26:40'!
test12CannotCheckoutWithAnExpiredCreditCart
	
	| cartId |
	
	creditCard _ testObjects expiredCreditCard.
	
	cartId _ self createCart.
	interface add: 15 of: item toCartWithId: cartId.
	
	self
		should: [ self checkoutCartWithId: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface canNotChargeAnExpiredCreditCardErrorMessage equals: exception messageText.
		].! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 16:10:56'!
test12_01CannotCheckoutWithAnInvalidCreditCardNumber
	
	| cartId |
	
	cartId _ self createCart.
	interface add: 10 of: item toCartWithId: cartId.
	
	self assertInvalidCreditCardNumber: 1234 usingCartId: cartId.
	self assertInvalidCreditCardNumber: '123412341234123' usingCartId: cartId.
	self assertInvalidCreditCardNumber: 'ABC4123412341234' usingCartId: cartId.! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 18:54:09'!
test13CannotCheckoutWhenTheCreditCardHasNoCredit

	| cartId |
	
	interface _ testObjects tusLibrosInterfaceWithDebitBehavior: [ :anAmount :aCreditCard |
		self error: TusLibrosInterface creditCardHasNoCreditErrorMessage
	].
	
	cartId _ self createCart.
	interface add: 10 of: item toCartWithId: cartId.
	
	self
		should: [ self checkoutCartWithId: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface creditCardHasNoCreditErrorMessage equals: exception messageText.
		].! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 18:54:13'!
test14CheckoutChargesCreditCardUsingMerchantProcessor

	| cartId quantity debitedAmount debitedCreditCard |
	
	quantity _ 3.
	
	interface _ testObjects tusLibrosInterfaceWithDebitBehavior: [ :anAmount :aCreditCard |
		debitedAmount _ anAmount.
		debitedCreditCard _ aCreditCard.
	].
	
	cartId _ self createCart.
	interface add: quantity of: item toCartWithId: cartId.
	
	self checkoutCartWithId: cartId.
	
	self assert: quantity * price equals: debitedAmount.
	self assert: creditCard equals: debitedCreditCard.! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 15:54:16'!
test15CannotListPurchasesForNonRegisteredUser
	
	self
		should: [ interface listPurchasesFor: testObjects wrongUser andPassword: '123' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo:[ :exception |
			self assert: TusLibrosInterface userNotFoundErrorMessage equals: exception messageText.
		].
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 16:14:41'!
test16CannotListPurchasesWithWrongPassword

	self
		should: [ interface listPurchasesFor: user andPassword: '123' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo:[ :exception |
			self assert: TusLibrosInterface invalidPasswordErrorMessage equals: exception messageText.
		].
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 16:14:52'!
test17PurchaseListForNewUserIsEmpty

	| purchases |
	
	purchases _ interface listPurchasesFor: user andPassword: password.
	
	self assert: purchases contents isEmpty.
	self assert: 0 equals: purchases total.! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 16:28:57'!
test18PurchaseIsListed

	| purchaseItems cartId quantity purchases |
	
	quantity _ 3.
	
	cartId _ self createCart.
	interface add: quantity of: item toCartWithId: cartId.
	
	self checkoutCartWithId: cartId.
		
	purchases _ interface listPurchasesFor: user andPassword: password.
	purchaseItems _ purchases contents.
	
	self assert: quantity * price equals: purchases total.
	self deny: purchaseItems isEmpty.
	self assert: 1 equals: purchaseItems contents size.
	self assert: (purchaseItems includes: item).
	self assert: quantity equals: (purchaseItems occurrencesOf: item).
	
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 16:29:17'!
test19PurchasesOfAnotherUserAreNotListed

	| cartId purchases |
	
	cartId _ self createCart.
	
	interface add: 10 of: item toCartWithId: cartId.
	
	self checkoutCartWithId: cartId.
		
	purchases _ interface listPurchasesFor: testObjects secondUser andPassword: testObjects secondUserPassword.
	
	self assert: purchases contents isEmpty.
	self assert: 0 equals: purchases total.! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 16:19:29'!
test20SeveralPurchasesAreAddedInList

	| quantity1 quantity2 totalQuantity purchaseList purchases |
	
	quantity1 _ 3.
	quantity2 _ 5.
	totalQuantity _ quantity1 + quantity2.
	
	self performPurchase: quantity1.
	self performPurchase: quantity2.
		
	purchases _ interface listPurchasesFor: user andPassword: password.
	purchaseList _ purchases contents.
	
	self assert: totalQuantity * price equals: purchases total.
	self deny: purchaseList isEmpty.
	self assert: 1 equals: purchaseList contents size.
	self assert: (purchaseList includes: item).
	self assert: totalQuantity equals: (purchaseList occurrencesOf: item).
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 17:50:42'!
test21CannotAddItemsToAnExpiredCart
	
	| cartId |
	
	cartId _ self createCart.
	
	clock advance: interface sessionDuration + 1 minutes.
	
	self
		should: [ interface add: 10 of: item toCartWithId: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface cartNotFoundErrorMessage equals: exception messageText.
		].
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 17:52:31'!
test22CannotListAnExpiredCart
	
	| cartId |
	
	cartId _ self createCart.
	
	clock advance: interface sessionDuration + 1 minutes.
	
	self
		should: [ interface listCartWithId: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface cartNotFoundErrorMessage equals: exception messageText.
		].
	! !

!TuslibrosInterfaceTest methodsFor: 'tests' stamp: 'jml 11/28/2018 17:54:04'!
test23CannotCheckoutAnExpiredCart
	
	| cartId |
	
	cartId _ self createCart.
	interface add: 10 of: item toCartWithId: cartId.
	
	clock advance: interface sessionDuration + 1 minutes.
	
	self
		should: [ self checkoutCartWithId: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :exception |
			self assert: TusLibrosInterface cartNotFoundErrorMessage equals: exception messageText.
		].
	! !


!TuslibrosInterfaceTest methodsFor: 'setup' stamp: 'jml 11/28/2018 18:54:01'!
setUp

	testObjects _ StoreTestObjectsFactory new.
	
	clock _ testObjects clock.
	interface _ testObjects tusLibrosInterface.
	
	item _ testObjects itemSellByTheStore.
	price _ testObjects itemSellByTheStorePrice.
	
	user _ testObjects defaultUser.
	password _ testObjects defaultPassword.
	
	creditCard _ testObjects notExpiredCreditCard.! !


!TuslibrosInterfaceTest methodsFor: 'operations' stamp: 'jml 11/28/2018 16:23:22'!
checkoutCartWithId: cartId
	
	interface
		checkoutCartWithId: cartId
		withCreditCard: creditCard number
		expiringOn: creditCard expiration
		withOwner: creditCard owner.! !

!TuslibrosInterfaceTest methodsFor: 'operations' stamp: 'jml 11/28/2018 16:06:31'!
createCart
	
	^ interface createCartFor: user andPassword: password! !

!TuslibrosInterfaceTest methodsFor: 'operations' stamp: 'jml 11/28/2018 16:22:47'!
performPurchase: aQuantity
	
	| cartId |
	
	cartId _ self createCart.	
	interface add: aQuantity of: item toCartWithId: cartId.
	self checkoutCartWithId: cartId.! !


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


!Cart methodsFor: 'initialization' stamp: 'jml 11/28/2018 02:36:04'!
initializeFor: aUser acceptingItemsOf: aCatalog
	
	user _ aUser.
	catalog _ aCatalog.
	contents _ Bag new.! !


!Cart methodsFor: 'queries' stamp: 'jml 11/28/2018 02:36:43'!
occurrencesOf: anItem

	^ contents occurrencesOf: anItem! !


!Cart methodsFor: 'testing' stamp: 'jml 11/28/2018 02:37:04'!
includes: anItem

	^ contents includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'jml 11/28/2018 02:37:12'!
isEmpty
	
	^ contents isEmpty ! !


!Cart methodsFor: 'total' stamp: 'jml 11/28/2018 02:41:09'!
total
	
	^ contents sum: [ :item | catalog at: item ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'jml 11/28/2018 02:41:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.
	
	contents add: anItem withOccurrences: aQuantity.! !


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


!Cashier class methodsFor: 'instance creation' stamp: 'jml 11/28/2018 18:49:20'!
toCheckout: aCart charging: aCreditCard through: aMerchantProcessor measuringTimeWith: aClock registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aClock now.
	
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


!classDefinition: #Clock category: #TusLibros!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'accessing' stamp: 'jml 11/28/2018 17:15:46'!
now
	
	self subclassResponsibility! !


!classDefinition: #FixedClock category: #TusLibros!
Clock subclass: #FixedClock
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!FixedClock methodsFor: 'initialization' stamp: 'jml 11/28/2018 17:18:31'!
initializePointingTo: aDateAndTime
	
	now _ aDateAndTime.! !


!FixedClock methodsFor: 'changing time' stamp: 'jml 11/28/2018 17:16:29'!
advance: aDuration
	
	now _ now + aDuration! !


!FixedClock methodsFor: 'accessing' stamp: 'jml 11/28/2018 17:15:58'!
now
	
	^ now! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FixedClock class' category: #TusLibros!
FixedClock class
	instanceVariableNames: ''!

!FixedClock class methodsFor: 'instance creation' stamp: 'jml 11/28/2018 17:18:22'!
pointingTo: aDateAndTime
	
	^ self new initializePointingTo: aDateAndTime! !


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


!classDefinition: #PerishableObject category: #TusLibros!
Object subclass: #PerishableObject
	instanceVariableNames: 'value duration clock lastUseTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PerishableObject methodsFor: 'accessing' stamp: 'jml 11/28/2018 18:27:09'!
value
	
	| now |
	
	now _ clock now.
	now - lastUseTime > duration ifTrue: [ ExpiredObjectError new signal: 'Object has expired' ].
	lastUseTime _ now.
	
	^ value! !


!PerishableObject methodsFor: 'initialization' stamp: 'jml 11/28/2018 18:08:21'!
initializeWith: anObject during: aDuration measuringTimeWith: aClock
	
	value _ anObject.
	duration _ aDuration.
	clock _ aClock.
	lastUseTime _ aClock now.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PerishableObject class' category: #TusLibros!
PerishableObject class
	instanceVariableNames: ''!

!PerishableObject class methodsFor: 'instance creation' stamp: 'jml 11/28/2018 18:05:41'!
with: aCart during: aDuration measuringTimeWith: aClock
	
	^ self new initializeWith: aCart during: aDuration measuringTimeWith: aClock! !


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
	instanceVariableNames: 'clock'
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


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'jml 11/28/2018 19:01:00'!
expiredCreditCard
	
	^ CreditCard expiringOn: self currentMonth previous withNumber: '1111222244445555' andOwner: 'manolo'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'jml 11/28/2018 18:59:35'!
notExpiredCreditCard
	
	^ CreditCard expiringOn: self currentMonth next withNumber: '1111222244445555' andOwner: 'manolo'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'jml 11/28/2018 18:36:09'!
initialize

	clock _ FixedClock pointingTo: DateAndTime now.! !


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


!StoreTestObjectsFactory methodsFor: 'interface' stamp: 'jml 11/28/2018 18:53:25'!
tusLibrosInterface
	
	^ self tusLibrosInterfaceWithDebitBehavior: [ :anAmount :aCreditCard | ]! !

!StoreTestObjectsFactory methodsFor: 'interface' stamp: 'jml 11/28/2018 18:53:37'!
tusLibrosInterfaceWithDebitBehavior: aBehavior
	
	| mpInterface |
	
	mpInterface _ self merchantProcessorWithDebitBehavior: aBehavior.
	
	^ TusLibrosInterface newMeasuringTimeWith: clock users: self registeredUsers catalog: self defaultCatalog merchantProcessor: mpInterface.! !


!StoreTestObjectsFactory methodsFor: 'merchant processor' stamp: 'jml 11/28/2018 15:46:37'!
defaultMerchantProcessor
	
	^ self merchantProcessorWithDebitBehavior: [ :anAmount :aCreditCart | ]! !

!StoreTestObjectsFactory methodsFor: 'merchant processor' stamp: 'jml 11/27/2018 12:06:05'!
merchantProcessorWithDebitBehavior: aBehavior
	
	^ SimulatedMerchantProcessorInterface withDebitBehavior: aBehavior! !


!StoreTestObjectsFactory methodsFor: 'time' stamp: 'jml 11/28/2018 18:50:58'!
clock
	
	^ clock! !

!StoreTestObjectsFactory methodsFor: 'time' stamp: 'jml 11/28/2018 18:58:43'!
currentMonth
	
	^ clock now month! !

!StoreTestObjectsFactory methodsFor: 'time' stamp: 'jml 11/28/2018 18:42:27'!
now
	
	^ clock now! !


!classDefinition: #TusLibrosInterface category: #TusLibros!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'users lastId catalog sales merchantProcessor clock activeCartSessions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterface methodsFor: 'carts' stamp: 'jml 11/28/2018 18:29:09'!
findCartWithId: aCartId
	
	| cart |
	
	(activeCartSessions includesKey: aCartId) ifFalse: [ self error: self class cartNotFoundErrorMessage ].
	
	[ cart _ (activeCartSessions at: aCartId) value ]
		on: ExpiredObjectError
		do: [
			activeCartSessions removeKey: aCartId.
			self error: self class cartNotFoundErrorMessage 
		].
	
	^ cart! !

!TusLibrosInterface methodsFor: 'carts' stamp: 'LA 11/22/2018 20:46:27'!
newId
	
	lastId _ lastId + 1.
	
	^ lastId
	! !

!TusLibrosInterface methodsFor: 'carts' stamp: 'jml 11/28/2018 17:04:55'!
sessionDuration
	
	^ 30 minutes! !


!TusLibrosInterface methodsFor: 'resources' stamp: 'jml 11/26/2018 00:58:02'!
add: aQuantity of: anItem toCartWithId: aCartId 
	
	| cart |
	
	cart _ self findCartWithId: aCartId.
	
	cart add: aQuantity of: anItem.! !

!TusLibrosInterface methodsFor: 'resources' stamp: 'jml 11/28/2018 18:49:56'!
checkoutCartWithId: aCartId withCreditCard: aCreditCardNumber expiringOn: expirationMonthOfYear withOwner: aName 
	
	| cart cashier total creditCard |
	
	cart _ self findCartWithId: aCartId.
	creditCard _ CreditCard expiringOn: expirationMonthOfYear withNumber: aCreditCardNumber andOwner: aName.

	cashier _ Cashier
		toCheckout: cart
		charging: creditCard
		through: merchantProcessor
		measuringTimeWith: clock
		registeringOn: sales.
	
	total _ cashier checkOut.
	^ total
! !

!TusLibrosInterface methodsFor: 'resources' stamp: 'jml 11/28/2018 18:32:19'!
createCartFor: aUserName andPassword: aPassword
	
	| cartId cart cartSession |
	
	self authenticateUser: aUserName with: aPassword.
	
	cartId _ self newId.
	cart _ Cart for: aUserName acceptingItemsOf: catalog.
	
	cartSession _ PerishableObject with: cart during: self sessionDuration measuringTimeWith: clock.
	activeCartSessions at: cartId put: cartSession.
	
	^ cartId! !

!TusLibrosInterface methodsFor: 'resources' stamp: 'jml 11/26/2018 00:58:02'!
listCartWithId: aCartId
	
	| cart |
	
	cart _ self findCartWithId: aCartId.
	
	^ cart contents! !

!TusLibrosInterface methodsFor: 'resources' stamp: 'jml 11/28/2018 16:33:31'!
listPurchasesFor: aUserName andPassword: aPassword 

	| userSales purchasedItems total |
	
	self authenticateUser: aUserName with: aPassword.
	
	userSales _ sales select: [ :sale | sale user = aUserName ].
	
	total _ userSales inject: 0 into: [ :subtotal :sale | subtotal + sale total ].
	purchasedItems _ userSales inject: Bag new into: [ :items :sale | items addAll: sale contents; yourself ].
	
	^ Sale of: aUserName withContents: purchasedItems andTotal: total! !


!TusLibrosInterface methodsFor: 'initialization' stamp: 'jml 11/28/2018 18:29:09'!
initializeMeasuringTimeWith: aClock users: registeredUsers catalog: aCatalog merchantProcessor: aMerchantProcessor
	
	clock _ aClock.
	users _ registeredUsers.
	catalog _ aCatalog.
	merchantProcessor _ aMerchantProcessor.
	sales _ OrderedCollection new.
	
	lastId _ 0.
	activeCartSessions _ Dictionary new.! !


!TusLibrosInterface methodsFor: 'authentication' stamp: 'jml 11/28/2018 16:33:47'!
authenticateUser: aUserName with: aPassword
	
	(users includesKey: aUserName ) ifFalse: [self error: self class userNotFoundErrorMessage ].
	((users at: aUserName) = aPassword) ifFalse: [self error: self class invalidPasswordErrorMessage ].! !

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


!TusLibrosInterface class methodsFor: 'instance creation' stamp: 'jml 11/28/2018 17:11:20'!
newMeasuringTimeWith: aClock users: users catalog: aCatalog merchantProcessor: aMerchantProcessor

	^ self new initializeMeasuringTimeWith: aClock users: users catalog: aCatalog merchantProcessor: aMerchantProcessor! !
