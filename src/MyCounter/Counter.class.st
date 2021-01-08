Class {
	#name : #Counter,
	#superclass : #Object,
	#instVars : [
		'count'
	],
	#category : #MyCounter
}

{ #category : #accessing }
Counter >> count [
	^ count
]

{ #category : #accessing }
Counter >> count: anInteger [
	count := anInteger.
	^ count
]

{ #category : #API }
Counter >> decrement [
	self count: self count - 1
]

{ #category : #accessing }
Counter >> increment [ 
	self count: self count + 1
]

{ #category : #initialization }
Counter >> initialize [ 
	self count: 0
]
