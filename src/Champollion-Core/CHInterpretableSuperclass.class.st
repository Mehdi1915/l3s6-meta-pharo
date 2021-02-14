Class {
	#name : #CHInterpretableSuperclass,
	#superclass : #CHInterpretableSecondSuperClass,
	#category : #'Champollion-Core'
}

{ #category : #testing }
CHInterpretableSuperclass >> isInSuperclass [
	^ true
]

{ #category : #'as yet unclassified' }
CHInterpretableSuperclass >> methodInSuperclass [
	^ 5
]

{ #category : #accessing }
CHInterpretableSuperclass >> overriddenMethod [ 
	^ 5
]

{ #category : #'as yet unclassified' }
CHInterpretableSuperclass >> redefinedMethod [ 
	^ super redefinedMethod 
]
