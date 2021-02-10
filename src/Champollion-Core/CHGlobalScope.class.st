Class {
	#name : #CHGlobalScope,
	#superclass : #Object,
	#instVars : [
		'globalDictionary'
	],
	#category : #'Champollion-Core'
}

{ #category : #accessing }
CHGlobalScope >> at: aKey put: aValue [ 
	globalDictionary at: aKey put: aValue 
]

{ #category : #accessing }
CHGlobalScope >> globalDictionary: anObject [ 
	globalDictionary := anObject 
]

{ #category : #initialization }
CHGlobalScope >> initialize [ 
	super initialize.
	globalDictionary := Dictionary new
]

{ #category : #'meta-object-protocol' }
CHGlobalScope >> read: aString [
	^ globalDictionary at: aString
]

{ #category : #'as yet unclassified' }
CHGlobalScope >> scopeDefining: aString [
	^ self
]
