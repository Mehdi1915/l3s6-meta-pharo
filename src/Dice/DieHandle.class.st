Class {
	#name : #DieHandle,
	#superclass : #Object,
	#instVars : [
		'diceList'
	],
	#category : #Dice
}

{ #category : #arithmetic }
DieHandle >> + aDicable [
	^ aDicable sumWithHandle: self
]

{ #category : #adding }
DieHandle >> addDie: aDie [
	diceList add: aDie.
]

{ #category : #'as yet unclassified' }
DieHandle >> dice [
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

{ #category : #'as yet unclassified' }
DieHandle >> sumWithDie: aDie [
	| handle |
	handle := self class new.
	self dice do: [ :each | handle addDie: each ].
	handle addDie: aDie.
	^ handle
]

{ #category : #'as yet unclassified' }
DieHandle >> sumWithHandle: aDieHandle [
	| hd |
	hd := self class new.
	self dice do: [ :each | hd addDie: each ].
	aDieHandle dice do: [ :each | hd addDie: each ].
	^ hd
]
