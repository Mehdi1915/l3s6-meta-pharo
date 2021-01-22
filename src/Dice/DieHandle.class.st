Class {
	#name : #DieHandle,
	#superclass : #Object,
	#instVars : [
		'diceList'
	],
	#category : #Dice
}

{ #category : #arithmetic }
DieHandle >> + aDieHandle [
	| handle |
	handle := DieHandle new.
	self allDie do: [ :each | handle addDie: each].
	aDieHandle allDie do: [ :each | handle addDie: each ].
	^ handle 
]

{ #category : #adding }
DieHandle >> addDie: aDie [
	diceList add: aDie.
]

{ #category : #'as yet unclassified' }
DieHandle >> allDie [
	^ diceList .
]

{ #category : #'as yet unclassified' }
DieHandle >> diceNumber [
	^ diceList size.
]

{ #category : #initialization }
DieHandle >> initialize [
	diceList  := OrderedCollection  new.
]

{ #category : #'as yet unclassified' }
DieHandle >> roll [ 
	^ diceList inject: 0 into: [ :sum :each | sum + each roll ]
]
