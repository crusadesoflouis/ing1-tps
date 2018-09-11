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

!I class methodsFor: 'operaciones' stamp: 'jml 9/11/2018 04:01:22'!
* unNumeroDePeano

	^unNumeroDePeano! !

!I class methodsFor: 'operaciones' stamp: 'ARM 9/6/2018 21:44:20'!
+ unNumeroDePeano

	^unNumeroDePeano next! !

!I class methodsFor: 'operaciones' stamp: 'jml 9/11/2018 04:12:04'!
- unNumeroDePeano

	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'operaciones' stamp: 'jml 9/11/2018 04:06:12'!
/ unNumeroDePeano

	unNumeroDePeano = I
	ifTrue:[^ self]
	ifFalse:[self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ]! !

!I class methodsFor: 'operaciones' stamp: 'a 9/10/2018 03:29:08'!
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

!I class methodsFor: 'operaciones' stamp: 'ARM 9/6/2018 21:29:22'!
next

	^II! !


!I class methodsFor: 'auxiliar' stamp: 'a 9/10/2018 02:28:06'!
vecesDivideA: unNumeroDePeano

	^ unNumeroDePeano! !


!I class methodsFor: 'mensajes de error' stamp: 'jml 9/11/2018 04:05:35'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'No se puede dividir por un número mayor'! !

!I class methodsFor: 'mensajes de error' stamp: 'jml 9/11/2018 04:11:07'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Números negativos no soportados'! !


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

!II class methodsFor: 'operaciones' stamp: 'luis 9/9/2018 20:34:59'!
* unNumeroDePeano

	unNumeroDePeano  == I 
	ifTrue: [^ self ]
	ifFalse:[
		^ self + (self * (unNumeroDePeano - I)).
		]
! !

!II class methodsFor: 'operaciones' stamp: 'jml 9/11/2018 04:03:23'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!II class methodsFor: 'operaciones' stamp: 'jml 9/11/2018 04:03:23'!
- unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self previous].

	^self previous - unNumeroDePeano previous! !

!II class methodsFor: 'operaciones' stamp: 'jml 9/11/2018 04:08:30'!
/ unNumeroDePeano

	self = unNumeroDePeano 
	ifTrue:[^I]
	"ifFalse:[ self ]."
	ifFalse:[
		self < unNumeroDePeano 
			ifTrue:[self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
			^unNumeroDePeano vecesDivideA: self ]! !

!II class methodsFor: 'operaciones' stamp: 'a 9/10/2018 03:28:19'!
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

!II class methodsFor: 'operaciones' stamp: 'jml 9/11/2018 04:03:04'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next setPrevious: self.
	].
	^next! !

!II class methodsFor: 'operaciones' stamp: 'jml 9/11/2018 04:03:23'!
previous

	^prev! !


!II class methodsFor: 'auxiliar' stamp: 'L.A 9/9/2018 18:17:05'!
removeAllNext

	next ifNotNil:  [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!II class methodsFor: 'auxiliar' stamp: 'jml 9/11/2018 04:03:04'!
setPrevious: unNumeroDePeano

	prev _ unNumeroDePeano! !

!II class methodsFor: 'auxiliar' stamp: 'a 9/11/2018 05:30:02'!
vecesDivideA: unNumeroDePeano

	self = unNumeroDePeano 
	ifTrue:[^I]
	ifFalse:[
	self < unNumeroDePeano 
		ifFalse:[self error: 'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'].
		^I + ( self vecesDivideA: (unNumeroDePeano -self)) 
		]! !


!II class methodsFor: 'mensajes de error' stamp: 'jml 9/11/2018 04:07:24'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'No se puede dividir por un número mayor'! !


!II class methodsFor: 'as yet unclassified' stamp: 'jml 9/11/2018 04:14:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := I.! !

II initializeAfterFileIn!