Class {
	#name : #StonePaperScissorsTest,
	#superclass : #TestCase,
	#category : #StonePaperScissors
}

{ #category : #tests }
StonePaperScissorsTest >> testPaperIsWinning [
	self assert: (Stone new play: Paper new) equals: #paper
	
]

{ #category : #tests }
StonePaperScissorsTest >> testScissorIsWinning [
	self assert: (Scissors new play: Paper new) equals: #scissors
]

{ #category : #tests }
StonePaperScissorsTest >> testStoneAgainstStone [
	self assert: (Stone new play: Stone new) equals: #draw
]
