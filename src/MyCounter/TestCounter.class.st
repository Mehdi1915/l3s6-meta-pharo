Class {
	#name : #TestCounter,
	#superclass : #Counter,
	#category : #MyCounter
}

{ #category : #tests }
TestCounter >> testCount [
	| c |
	c := Counter new.
	c count: 5.
	self assert: c count = 5.
]

{ #category : #tests }
TestCounter >> testIncrement [
	| c |
	c := Counter new.
	c increment.
	self assert: c count = 1.
]
