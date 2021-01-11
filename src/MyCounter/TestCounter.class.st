Class {
	#name : #TestCounter,
	#superclass : #TestCase,
	#category : #MyCounter
}

{ #category : #tests }
TestCounter >> testCount [
	| c |
	c := Counter new.
	c count: 5.
	self assert: c count equals: 5.
]

{ #category : #tests }
TestCounter >> testDecrement [
	| c |
	c := Counter new.
	c count: 2.
	c decrement.
	self assert: c count equals: 1.
]

{ #category : #tests }
TestCounter >> testIncrement [
	| c |
	c := Counter new.
	c increment.
	self assert: c count equals: 1.
]
