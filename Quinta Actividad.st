!classDefinition: #I category: #'Quinta Actividad'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Quinta Actividad'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:44:20'!
+ unNumeroDePeano

	^unNumeroDePeano next! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 22:03:11'!
- unNumeroDePeano

	self error: 'No se puede restar un numero menor a un numero mayor o igual'! !

!I class methodsFor: 'as yet unclassified' stamp: 'a 9/10/2018 02:09:51'!
/ unNumeroDePeano

	unNumeroDePeano = I
	ifTrue:[^ self]
	ifFalse:[self error: 'no se puede dividir' ]! !

!I class methodsFor: 'as yet unclassified' stamp: 'a 9/10/2018 03:29:08'!
< unNumeroDePeano
	self == unNumeroDePeano 
	ifTrue: [^false].
	self  == I 
	ifTrue: [^true]
	ifFalse:[
		(unNumeroDePeano == I)
			ifTrue: [^false]
			ifFalse:[((self-I) < (unNumeroDePeano - I))  ]
						]! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:29:22'!
next

	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'a 9/10/2018 02:28:06'!
vecesDivideA: unNumeroDePeano

	^ unNumeroDePeano! !


!classDefinition: #II category: #'Quinta Actividad'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Quinta Actividad'!
II class
	instanceVariableNames: 'next prev'!

!II class methodsFor: 'as yet unclassified' stamp: 'luis 9/9/2018 20:34:59'!
* unNumeroDePeano

	unNumeroDePeano  == I 
	ifTrue: [^ self ]
	ifFalse:[
		^ self + (self * (unNumeroDePeano - I)).
		]
! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:47:13'!
+ unNumeroDePeano

	^self prev + unNumeroDePeano next! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 22:01:57'!
- unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self prev].

	^self prev - unNumeroDePeano prev! !

!II class methodsFor: 'as yet unclassified' stamp: 'a 9/10/2018 02:55:42'!
/ unNumeroDePeano

	self = unNumeroDePeano 
	ifTrue:[^I]
	ifFalse:[ self ]
	"ifFalse:[
		self < unNumeroDePeano 
			ifTrue:[self error: 'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'].

			^unNumeroDePeano vecesDivideA: self]
"! !

!II class methodsFor: 'as yet unclassified' stamp: 'a 9/10/2018 03:28:19'!
< unNumeroDePeano
	self == unNumeroDePeano 
	ifTrue: [^false].
	self  == I 
	ifTrue: [^true]
	ifFalse:[
		(unNumeroDePeano == I)
			ifTrue: [^false]
			ifFalse:[^ ((self-I) < (unNumeroDePeano - I))  ]
						]! !

!II class methodsFor: 'as yet unclassified' stamp: 'a 9/10/2018 03:30:09'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:48:10'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:49:14'!
prev

	^prev! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:48:32'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'L.A 9/9/2018 18:17:05'!
removeAllNext

	next ifNotNil:  [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'a 9/10/2018 03:27:33'!
vecesDivideA: unNumeroDePeano

	unNumeroDePeano < self
	ifTrue:[^I]
	ifFalse:[^I]! !

II initializeAfterFileIn!