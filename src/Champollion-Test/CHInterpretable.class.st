Class {
	#name : #CHInterpretable,
	#superclass : #CHInterpretableSuperclass,
	#instVars : [
		'x',
		'collaborator',
		'current',
		'evaluationOrder'
	],
	#category : #'Champollion-Test'
}

{ #category : #'as yet unclassified' }
CHInterpretable >> asendMessageInSuperclass [
	^ self methodInSuperclass
]

{ #category : #'as yet unclassified' }
CHInterpretable >> callingFailingPrimitive [
	^ self failingPrimitive 
]

{ #category : #'as yet unclassified' }
CHInterpretable >> changeCollaboratorWithArgument [ 
	collaborator x: 500
]

{ #category : #'as yet unclassified' }
CHInterpretable >> changeCollaboratorX [ 
	collaborator store100IntoX 
]

{ #category : #accessing }
CHInterpretable >> collaborator [ 
	^ collaborator 
]

{ #category : #accessing }
CHInterpretable >> collaborator: anObject [ 
	collaborator := anObject 
]

{ #category : #'as yet unclassified' }
CHInterpretable >> currentMethod [
	^ self tempAt: #__method
]

{ #category : #'reflective operations' }
CHInterpretable >> doesNotUnderstand: aMessage [ 
	^ aMessage 
]

{ #category : #'as yet unclassified' }
CHInterpretable >> doesSuperLookupFromSuperClass [
	^ super isInSuperclass 
]

{ #category : #'as yet unclassified' }
CHInterpretable >> evaluateReceiver [ 
	evaluationOrder := self next.
	^ self
]

{ #category : #accessing }
CHInterpretable >> evaluationOrder [
	^ evaluationOrder
]

{ #category : #'as yet unclassified' }
CHInterpretable >> failingPrimitive [
	<primitive: 1>
	^ 'failure'
]

{ #category : #initialization }
CHInterpretable >> initialize [
	super initialize.
	current := { "empty" }.
]

{ #category : #testing }
CHInterpretable >> isInSuperclass [ 
	^ false
]

{ #category : #'as yet unclassified' }
CHInterpretable >> messageArg1: arg1 arg2: arg2 arg3: arg3 [
	^ { arg1 . arg2 . arg3 } 
]

{ #category : #accessing }
CHInterpretable >> next [
	| result |
	result := current.
	current := { current  }.
	^ result
]

{ #category : #accessing }
CHInterpretable >> overriddenMethod [
	^ super overriddenMethod
]

{ #category : #'as yet unclassified' }
CHInterpretable >> peanoToInt: aPeanoNumber [
	^ aPeanoNumber ifEmpty: [ 0 ] ifNonEmpty: [ 1 + (self peanoToInt: aPeanoNumber first) ]
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnBoolean [ 
	^ false
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnEmptyLiteralArray [ 
	^ #()
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnEvaluationOrder [
	^ self evaluateReceiver messageArg1: self next arg2: self next arg3: self next 
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnFloat [ 
	^ 3.14
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnGlobal [ 
	^ Global 
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnInteger [
	^ 5
]

{ #category : #tests }
CHInterpretable >> returnRecursiveLiteralArray [
	^ #(true 1 #('ahah'))
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnSelf [
	^ self
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnSuper [
	^ super
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnUnassignedTemp [
	| temp |
	^ temp
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnX [
	^ x
]

{ #category : #'as yet unclassified' }
CHInterpretable >> sendMessageInSuperclass [
	^ self methodInSuperclass
]

{ #category : #'as yet unclassified' }
CHInterpretable >> sendMessageNotUnderstand [
	^ self messageIDoNotUnderstandWithArg1: 17 withArg2: 27
]

{ #category : #'as yet unclassified' }
CHInterpretable >> sendMessageReturnX [ 
	^ self returnX
]

{ #category : #initialization }
CHInterpretable >> setXAndMessage [ 
	x := 1000.
	collaborator returnX.
	^ x
]

{ #category : #'as yet unclassified' }
CHInterpretable >> smallIntAdd [
	^ 1 + 5
]

{ #category : #'as yet unclassified' }
CHInterpretable >> store100IntoX [ 
	^ x := 100
]

{ #category : #writing }
CHInterpretable >> writeTemporaryVariable [ 
	| temp |
	temp := 100.
	^ temp
]

{ #category : #accessing }
CHInterpretable >> x [
	^ x
]

{ #category : #accessing }
CHInterpretable >> x: anInteger [
	x := anInteger 
]
