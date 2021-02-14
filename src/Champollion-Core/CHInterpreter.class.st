Class {
	#name : #CHInterpreter,
	#superclass : #Object,
	#instVars : [
		'stack',
		'globalScope',
		'primitives'
	],
	#category : #'Champollion-Core'
}

{ #category : #accessing }
CHInterpreter >> argumentAt: anInteger [
	^ self tempAt: (self currentMethod arguments at: anInteger) name
]

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
	self tempAt: #___method put: anAST.
	self tempAt: #self put: anObject.
	anAST arguments with: aCollection do: [ :arg :value | self tempAt: arg name put: value ].
	result := self visitNode: anAST body.
	self popFrame.
	^ result
]

{ #category : #'as yet unclassified' }
CHInterpreter >> executePrimitiveMethod: anAST [
	| primitiveNumber |
	primitiveNumber := anAST pragmas detect: [ :each | each isPrimitive ] ifFound: [ :aPragmaPrimitive | aPragmaPrimitive arguments first value ] ifNone: [ self error: 'Not a primitive method' ].
	^ self perform: (primitives at: primitiveNumber)
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
	primitives := Dictionary new.
	self initializePrimitiveTable.
]

{ #category : #initialization }
CHInterpreter >> initializePrimitiveTable [
	primitives at: 1 put: #primitiveSmallIntegerAdd

]

{ #category : #'as yet unclassified' }
CHInterpreter >> lookup: aSymbol fromClass: aClass [ 
	(aClass includesSelector: aSymbol) ifTrue: [ ^ (aClass compiledMethodAt: aSymbol) ast ].
	^ aClass superclass ifNil: [ nil ] ifNotNil: [ self lookup: aSymbol fromClass: aClass superclass ]

]

{ #category : #'as yet unclassified' }
CHInterpreter >> popFrame [
	stack pop
]

{ #category : #'as yet unclassified' }
CHInterpreter >> primitiveAt [
	self numberOfArguments < 1 ifTrue: [ CHPrimitiveFail signal ].
	self receiver class classLayout isVariable ifFalse: [ CHPrimitiveFail signal ].
	((self argumentAt: 1) isKindOf: SmallInteger) ifFalse: [ CHPrimitiveFail signal ].

	self receiver size < (self argumentAt: 1) ifTrue: [ CHPrimitiveFail signal ].
	^ self receiver basicAt: (self argumentAt: 1)
]

{ #category : #'as yet unclassified' }
CHInterpreter >> primitiveBasicNew [
	self receiver isClass ifFalse: [ CHPrimitiveFail signal ].
	^ self receiver basicNew
]

{ #category : #'as yet unclassified' }
CHInterpreter >> primitiveBasicNewVariable [
	self numberOfArguments < 1 ifTrue: [ CHPrimitiveFail signal ].
	self receiver isClass ifFalse: [ CHPrimitiveFail signal ].
	self receiver class classLayout isVariable ifFalse: [ CHPrimitiveFail signal ].
	((self argumentAt: 1) isKindOf: SmallInteger) ifFalse: [ CHPrimitiveFail signal ].
	^ self receiver basicNew: (self argumentAt: 1)
]

{ #category : #'as yet unclassified' }
CHInterpreter >> primitiveIdentical [
	self numberOfArguments < 1 ifTrue: [ CHPrimitiveFail signal ].
	^ self receiver == (self argumentAt: 1)
]

{ #category : #'as yet unclassified' }
CHInterpreter >> primitiveSize [ 
	self receiver class classLayout isVariable ifFalse: [ CHPrimitiveFail signal ].
	^ self receiver basicSize
]

{ #category : #'as yet unclassified' }
CHInterpreter >> primitiveSmallIntegerAdd [
	| receiver argument result |
	self numberOfArguments < 1 ifTrue: [ CHPrimitiveFail signal ].
	receiver := self receiver.
	receiver class = SmallInteger ifFalse: [ CHPrimitiveFail signal ].
	argument := self argumentAt: 1.
	argument class = SmallInteger ifFalse: [ CHPrimitiveFail signal ].
	result := receiver + argument.
	result class = SmallInteger ifFalse: [ CHPrimitiveFail signal ].
	^ result
]

{ #category : #'as yet unclassified' }
CHInterpreter >> primitiveSmallIntegerDivide [
	| receiver argument result |
	self numberOfArguments < 1 ifTrue: [ CHPrimitiveFail signal ].
	receiver := self receiver.
	receiver class = SmallInteger ifFalse: [ CHPrimitiveFail signal ].
	argument := self argumentAt: 1.
	(argument class = SmallInteger and: [ argument ~= 0 ]) ifFalse: [ CHPrimitiveFail signal ].
	result := receiver / argument.
	result class = SmallInteger ifFalse: [ CHPrimitiveFail signal ].
	^ result
]

{ #category : #'as yet unclassified' }
CHInterpreter >> primitiveSmallIntegerLessThan [
	| receiver argument result |
	self numberOfArguments < 1 ifTrue: [ CHPrimitiveFail signal ].
	receiver := self receiver.
	receiver class = SmallInteger ifFalse: [ CHPrimitiveFail signal ].
	argument := self argumentAt: 1.
	argument class = SmallInteger ifFalse: [ CHPrimitiveFail signal ].
	^ receiver < argument
]

{ #category : #'as yet unclassified' }
CHInterpreter >> primitiveStringAt [
	self numberOfArguments < 1 ifTrue: [ CHPrimitiveFail signal ].
	self receiver class classLayout isBytes ifFalse: [ CHPrimitiveFail signal ].
	((self argumentAt: 1) isKindOf: SmallInteger) ifFalse: [ CHPrimitiveFail signal ]. 
	self receiver size < (self argumentAt: 1) ifTrue: [ CHPrimitiveFail signal ].
	^ self receiver at: (self argumentAt: 1)
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
CHInterpreter >> send: aSelector receiver: newReceiver lookupFromClass: lookupClass arguments: arguments [
	| method |
	method := self lookup: aSelector fromClass: lookupClass.
	method ifNil: [ | messageReification | messageReification := Message selector: aSelector arguments: arguments.
	^ self send: #doesNotUnderstand: newReceiver: receiver lookupFromClass: lookupClass arguments: { messageReification } ].
	^ self execute: method withReceiver: newReceiver andArguments: arguments
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
	| newReceiver args lookupClass |
	newReceiver := self visitNode: aMessageNode receiver.
	args := aMessageNode arguments collect: [ :each | self visitNode: each ].
	lookupClass := aMessageNode receiver isSuperVariable ifTrue: [ self currentMethod methodClass superclass ] ifFalse: [ newReceiver class ].
	^ self send: aMessageNode selector receiver: newReceiver lookupFromClass: lookupClass arguments: args asArray
]

{ #category : #visiting }
CHInterpreter >> visitMethodNode: aMethodNode [
	[ aMethodNode isPrimitive ifTrue: [ ^ self executePrimitiveMethod: aMethodNode ]] on: CHPrimitiveFail do: [ :err | ].
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
