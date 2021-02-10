Class {
	#name : #CHInterpreter,
	#superclass : #Object,
	#instVars : [
		'stack',
		'globalScope'
	],
	#category : #'Champollion-Core'
}

{ #category : #private }
CHInterpreter >> currentScope [ 
	^ self topFrame 
]

{ #category : #running }
CHInterpreter >> execute: anAST [
	^ self visitNode: anAST
]

{ #category : #running }
CHInterpreter >> execute: anAST withReceiver: anObject [
	| result |
	self pushNewFrame.
	self topFrame parentScope: (CHInstanceScope new receiver: anObject; parentScope: globalScope; yourself); yourself.
	self topFrame receiver: anObject.
	result := self visitNode: anAST.
	self popFrame.
	^ result
]

{ #category : #'as yet unclassified' }
CHInterpreter >> executeMethod: anAST withReceiver: anObject [ 
	^ self 
	  executeMethod: anAST 
	  withReceiver: anObject 
	  andArguments: #()
]

{ #category : #'as yet unclassified' }
CHInterpreter >> executeMethod: anAST withReceiver: anObject andArguments: aCollection [
	| result |
	self pushNewFrame.
	self topFrame parentScope: (CHInstanceScope new receiver: anObject; parentScope: globalScope; yourself); yourself.
	anAST arguments with: aCollection do: [ :arg :value | self topFrame at: arg name put: value ].
	result := self visitNode: anAST.
	self popFrame.
	^ result
]

{ #category : #accessing }
CHInterpreter >> globalEnvironmentAt: aSymbol put: anObject [
	globalScope at: aSymbol put: anObject  
]

{ #category : #initialization }
CHInterpreter >> initialize [ 
	super initialize.
	globalScope := CHGlobalScope new.
	stack := CTStack new.
]

{ #category : #'as yet unclassified' }
CHInterpreter >> popFrame [
	stack pop
]

{ #category : #'as yet unclassified' }
CHInterpreter >> pushNewFrame [
	| newTop |
	newTop := CHMethodScope new.
	stack push: newTop.
	^ newTop
]

{ #category : #accessing }
CHInterpreter >> receiver [
	^ self topFrame receiver
]

{ #category : #'as yet unclassified' }
CHInterpreter >> scopeDefining: aName [
	^ self currentScope scopeDefining: aName
]

{ #category : #'as yet unclassified' }
CHInterpreter >> topFrame [
	^ stack top
]

{ #category : #visiting }
CHInterpreter >> visitArrayNode: aRBArrayNode [
	^ aRBArrayNode statements collect: [ :e | self visitNode: e ] as: Array
]

{ #category : #visiting }
CHInterpreter >> visitAssignmentNode: anAssignmentNode [
	| value |
	value := self visitNode: anAssignmentNode value.
	(self scopeDefining: anAssignmentNode variable name)
		write: anAssignmentNode variable name
		withValue: value.
	^ value
]

{ #category : #visiting }
CHInterpreter >> visitGlobalNode: aRBGlobalNode [
	^ globalScope at: aRBGlobalNode name ifAbsent: [ self error: aRBGlobalNode name, ' not found' ]
]

{ #category : #visiting }
CHInterpreter >> visitLiteralArrayNode: aLiteralArrayNode [
	^ aLiteralArrayNode contents collect: [ :literalNode | self visitNode: literalNode ] as: Array 
]

{ #category : #visiting }
CHInterpreter >> visitLiteralValueNode: aLiteralValueNode [
	^ aLiteralValueNode value
]

{ #category : #visiting }
CHInterpreter >> visitMessageNode: aMessageNode [
	| newReceiver method args |
	newReceiver := self visitNode: aMessageNode receiver.
	args := aMessageNode arguments collect: [ :each | self visitNode: each ].
	method := (newReceiver class compiledMethodAt: aMessageNode selector) ast.
	^ self executeMethod: method withReceiver: newReceiver andArguments: args
]

{ #category : #visiting }
CHInterpreter >> visitMethodNode: aMethodNode [
	^ self visitNode: aMethodNode body
]

{ #category : #visiting }
CHInterpreter >> visitNode: aNode [
	^ aNode acceptVisitor: self
]

{ #category : #visiting }
CHInterpreter >> visitReturnNode: aReturnNode [
	^ self visitNode: aReturnNode value
]

{ #category : #visiting }
CHInterpreter >> visitSelfNode: aNode [
	^ self receiver 
]

{ #category : #visiting }
CHInterpreter >> visitSequenceNode: aSequenceNode [
	aSequenceNode statements allButLast
		do: [ :each | self visitNode: each ].
	^ self visitNode: aSequenceNode statements last
]

{ #category : #visiting }
CHInterpreter >> visitSuperNode: aNode [
	^ self receiver 
]

{ #category : #visiting }
CHInterpreter >> visitVariableNode: aVariableNode [
	^ (self scopeDefining: aVariableNode name) read: aVariableNode name
]
