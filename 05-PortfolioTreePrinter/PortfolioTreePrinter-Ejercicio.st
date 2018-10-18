!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'balance' stamp: 'jml 10/18/2018 19:30:46'!
applyToBalance: balance for: anAccount
	
	self subclassResponsibility! !


!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'jml 10/18/2018 09:40:04'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'jml 10/18/2018 19:57:05'!
initializeFor: aValue
	
	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'jml 10/18/2018 18:58:19'!
value
	"TODO subir a superclase?"
	^ value! !


!Deposit methodsFor: 'balance' stamp: 'jml 10/18/2018 19:31:00'!
applyToBalance: balance for: anAccount
	
	^ balance + value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'jml 10/18/2018 20:22:17'!
summaryLine
	
	^ 'Deposito por ', value printString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'jml 10/18/2018 18:56:56'!
for: aValue
	"TODO subir a superclase?"
	^ self new initializeFor: aValue ! !


!classDefinition: #IncomingWireTransfer category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #IncomingWireTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!IncomingWireTransfer methodsFor: 'initialization' stamp: 'jml 10/18/2018 20:02:10'!
initializeFor: aTransfer
	
	transfer := aTransfer.! !


!IncomingWireTransfer methodsFor: 'value' stamp: 'jml 10/18/2018 20:03:16'!
value
	
	^ transfer value! !


!IncomingWireTransfer methodsFor: 'balance' stamp: 'jml 10/18/2018 20:04:45'!
applyToBalance: balance for: anAccount
	
	^ balance + self value! !


!IncomingWireTransfer methodsFor: 'as yet unclassified' stamp: 'jml 10/18/2018 20:23:20'!
summaryLine
	
	^ 'Transferencia por ', self value printString! !

!IncomingWireTransfer methodsFor: 'as yet unclassified' stamp: 'jml 10/18/2018 20:08:37'!
transfer
	
	^ transfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IncomingWireTransfer class' category: #'PortfolioTreePrinter-Ejercicio'!
IncomingWireTransfer class
	instanceVariableNames: ''!

!IncomingWireTransfer class methodsFor: 'instance creation' stamp: 'jml 10/18/2018 20:01:28'!
for: aTransfer
	
	^ self new initializeFor: aTransfer! !


!classDefinition: #OutcomingWireTransfer category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #OutcomingWireTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!OutcomingWireTransfer methodsFor: 'initialization' stamp: 'jml 10/18/2018 20:01:55'!
initializeFor: aTransfer
	
	transfer := aTransfer.! !


!OutcomingWireTransfer methodsFor: 'value' stamp: 'jml 10/18/2018 20:03:26'!
value
	
	^ transfer value! !


!OutcomingWireTransfer methodsFor: 'balance' stamp: 'jml 10/18/2018 20:05:01'!
applyToBalance: balance for: anAccount
	
	^ balance - self value! !


!OutcomingWireTransfer methodsFor: 'as yet unclassified' stamp: 'jml 10/18/2018 20:23:27'!
summaryLine
	
	^ 'Transferencia por -', self value printString! !

!OutcomingWireTransfer methodsFor: 'as yet unclassified' stamp: 'jml 10/18/2018 20:08:25'!
transfer
	
	^ transfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OutcomingWireTransfer class' category: #'PortfolioTreePrinter-Ejercicio'!
OutcomingWireTransfer class
	instanceVariableNames: ''!

!OutcomingWireTransfer class methodsFor: 'instance creation' stamp: 'jml 10/18/2018 20:01:39'!
for: aTransfer
	
	^ self new initializeFor: aTransfer! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'jml 10/18/2018 19:31:27'!
applyToBalance: balance for: anAccount
	
	^ balance - value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'jml 10/18/2018 20:22:50'!
summaryLine
	
	^ 'Extraccion por ', value printString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:28'!
doesManage: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'L A 10/18/2018 11:54:15'!
doesManageAnyPartOf: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'balance' stamp: 'jml 10/15/2018 13:12:53'!
balance

	self subclassResponsibility! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'jml 10/12/2018 14:48:18'!
doesManage: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :account | account doesManage: anAccount ] ]
! !

!Portfolio methodsFor: 'testing' stamp: 'jml 10/13/2018 01:58:46'!
doesManageAnyPartOf: anAccount

	^ (anAccount doesManage: self) or: [ accounts anySatisfy: [ :account | account doesManageAnyPartOf: anAccount ] ]
! !

!Portfolio methodsFor: 'testing' stamp: 'jml 10/12/2018 12:04:31'!
hasRegistered: aTransaction

	^ accounts anySatisfy: [ :account | account hasRegistered: aTransaction ]! !


!Portfolio methodsFor: 'transactions' stamp: 'jml 10/18/2018 18:48:35'!
transactions 
	
	^ accounts inject: (OrderedCollection new) into: [ :transactions :account | transactions addAll: (account transactions); yourself ]! !

!Portfolio methodsFor: 'transactions' stamp: 'jml 10/15/2018 12:58:26'!
transactionsOf: anAccount 

	(self doesManage: anAccount)
		ifFalse: [ self error: self class accountNotManagedMessageDescription ].
	
	^ anAccount transactions! !


!Portfolio methodsFor: 'adding' stamp: 'jml 10/15/2018 12:46:55'!
addAccount: anAccount
	
	(self doesManageAnyPartOf: anAccount)
		ifTrue: [ self error: self class accountAlreadyManagedErrorMessage ].
	
	accounts add: anAccount.
! !


!Portfolio methodsFor: 'initialization' stamp: 'jml 10/12/2018 11:41:30'!
initialize
	
	accounts := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'jml 10/15/2018 12:44:07'!
balance
	
	^ accounts sum: [ :account | account balance ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'jml 10/15/2018 12:14:30'!
with: leftAccount with: rightAccount
	
	^ self withAll: (Array with: leftAccount with: rightAccount)! !

!Portfolio class methodsFor: 'instance creation' stamp: 'jml 10/15/2018 13:08:18'!
withAll: aCollectionOfAccounts

	| newPortfolio |
	
	aCollectionOfAccounts ifEmpty: [ self error: self emptyPortfolioErrorMessage ].
	
	newPortfolio := self new.
	aCollectionOfAccounts do: [ :account | newPortfolio addAccount: account ].
	
	^ newPortfolio! !


!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/8/2018 16:08:43'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/8/2018 16:08:53'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'jml 10/15/2018 13:09:25'!
emptyPortfolioErrorMessage
	
	^ 'Cannot create an empty portfolio'! !


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'jml 10/18/2018 19:10:18'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	incomingTransfers := OrderedCollection new.
	outcomingTransfers := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:28'!
doesManage: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'jml 10/13/2018 01:59:33'!
doesManageAnyPartOf: anAccount

	^ anAccount doesManage: self
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'jml 10/12/2018 10:50:23'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'jml 10/18/2018 20:04:01'!
balance
	
	^ transactions inject: 0 into: [ :balance :transaction | transaction applyToBalance: balance for: self ] "TODO sacar for:"! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'jml 10/18/2018 20:18:33'!
summaryLines
	
	^ transactions collect: [ :transaction | transaction summaryLine ]! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'jml 10/18/2018 20:11:44'!
initializeFor: aValue

	value := aValue.
	withdrawLeg := OutcomingWireTransfer for: self.
	depositLeg := IncomingWireTransfer for: self.
! !



!Transfer methodsFor: 'value' stamp: 'jml 10/18/2018 18:57:55'!
value
	
	^ value! !


!Transfer methodsFor: 'as yet unclassified' stamp: 'jml 10/18/2018 20:02:34'!
depositLeg
	
	^ depositLeg! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'jml 10/18/2018 20:02:49'!
withdrawLeg
	
	^ withdrawLeg! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'jml 10/18/2018 20:07:42'!
register: anAmount from: fromAccount to: toAccount
	
	| newTransfer |
	
	newTransfer := (self new initializeFor: anAmount).
	
	fromAccount register: newTransfer withdrawLeg.
	toAccount register: newTransfer depositLeg.
	
	^ newTransfer! !
