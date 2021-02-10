Class {
	#name : #CHInstanceScope,
	#superclass : #Object,
	#instVars : [
		'receiver',
		'parentScope'
	],
	#category : #'Champollion-Core'
}

{ #category : #'as yet unclassified' }
CHInstanceScope >> definedVariables [
	^ receiver class allInstVarNames 
]

{ #category : #accessing }
CHInstanceScope >> parentScope [ 
	^ parentScope 
]

{ #category : #accessing }
CHInstanceScope >> parentScope: anObject [ 
	parentScope := anObject 
]

{ #category : #'meta-object-protocol' }
CHInstanceScope >> read: aString [
	^ receiver instVarNamed: aString
]

{ #category : #accessing }
CHInstanceScope >> receiver: anObject [
	receiver := anObject
]

{ #category : #'as yet unclassified' }
CHInstanceScope >> scopeDefining: aString [
	(self definedVariables includes: aString)
		ifTrue: [ ^ self ].
	^ self parentScope scopeDefining: aString
]

{ #category : #writing }
CHInstanceScope >> write: aString withValue: anInteger [
	receiver instVarNamed: aString put: anInteger 
]
