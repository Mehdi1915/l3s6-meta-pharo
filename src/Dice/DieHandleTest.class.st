Class {
	#name : #DieHandleTest,
	#superclass : #TestCase,
	#category : #Dice
}

{ #category : #tests }
DieHandleTest >> testAddTwoDice [
	| hd |
	hd := (Die withFaces: 6) + (Die withFaces: 6).
	self assert: hd dice size equals: 2.
]

{ #category : #tests }
DieHandleTest >> testAddingADieAndHandle [
	| hd |
	hd := (Die withFaces: 6) + (DieHandle new addDie: 6; yourself).
	self assert: hd dice size equals: 2
	
]

{ #category : #tests }
DieHandleTest >> testAddingAnHandleWithADie [
	| handle res |
	handle := DieHandle new 
		addDie: (Die withFaces: 6);
		addDie: (Die withFaces: 10);
		yourself.
	res := handle + (Die withFaces: 20).
	self assert: res diceNumber equals: 3
]

{ #category : #tests }
DieHandleTest >> testAddingTwiceTheSameDice [
	| handle |
	handle := DieHandle new.
	handle addDie: (Die withFaces: 6).
	self assert: handle diceNumber = 1.
	handle addDie: (Die withFaces: 6).
	self assert: handle diceNumber = 2.
]

{ #category : #tests }
DieHandleTest >> testCreationAdding [
	| handle |
	handle := DieHandle new
		addDie: (Die withFaces: 6);
		addDie: (Die withFaces: 10);
		yourself.
	self assert: handle diceNumber equals: 2.
]

{ #category : #tests }
DieHandleTest >> testRoll [
	| handle |
	handle := DieHandle new
			addDie: (Die withFaces: 6);
			addDie: (Die withFaces: 10);
			yourself.
	self assert: (handle roll between: 1 and: 16).
	
]

{ #category : #tests }
DieHandleTest >> testSimpleHandle [
	self assert: 2 D20 diceNumber = 2.
]

{ #category : #tests }
DieHandleTest >> testSumming [
	| handle |
	handle := 2 D20 + 3 D10.
	self assert: handle diceNumber equals: 5.
]
