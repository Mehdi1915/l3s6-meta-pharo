Class {
	#name : #Paper,
	#superclass : #Object,
	#category : #StonePaperScissors
}

{ #category : #'as yet unclassified' }
Paper >> play: anotherTool [ 
	^ anotherTool playAgainstPaper: self
]

{ #category : #'as yet unclassified' }
Paper >> play: anElement onDraw: aDrawBlock onWin: aWinBlock onLose: aLoseBlock [
	^ anElement playAgainstPaper: self onDraw: aDrawBlock onReceiverWin: aWinBlock onReceiverLose: aLoseBlock
]

{ #category : #'as yet unclassified' }
Paper >> playAgainstPaper: aPaper [ 
	^ #draw
]

{ #category : #'as yet unclassified' }
Paper >> playAgainstPaper: aPaper onDraw: aDrawBlock onReceiverWin: aWinBlock onReceiverLose: aLoseBlock [  
	^ aDrawBlock value
]

{ #category : #'as yet unclassified' }
Paper >> playAgainstScissors: aScissors [ 
	^ #scissors
]

{ #category : #'as yet unclassified' }
Paper >> playAgainstStone: aStone [
	^ #paper
]
