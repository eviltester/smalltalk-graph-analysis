"Filed out from Dolphin Smalltalk/Version 2.1"!

Model subclass: #TestingFlowLink
	instanceVariableNames: 'from to weighting'
	classVariableNames: ''
	poolDictionaries: ''!

TestingFlowLink class instanceVariableNames: ''!

TestingFlowLink comment: 'a testing flow link has a to and a when (value of the predicate of the parent)'!

!TestingFlowLink categoriesForClass!No category! !

!TestingFlowLink methodsFor!

asTestingFlowDeconstructedLink
	|newLink|

	newLink := TestingFlowDeconstructedLink new.
	newLink from: (self from).
	newLink to: (self to).
	newLink weighting: (OrderedCollection new).
	(newLink weighting) add: self.
	newLink activate.
	^newLink!

displayOn: aStream
	aStream nextPut: $(. 
	self from displayOn: aStream. 
	aStream nextPut: $,. 
	self to displayOn: aStream. 
	aStream nextPut: $,. 
	self weighting displayOn: aStream. 
	aStream nextPut: $).!

from
	^from!

from: aNode
	from := aNode!

printOn: aStream
	self basicPrintOn: aStream. 
	self  displayOn: aStream. !

to
	^to!

to: aTestingFlowNode
	to := aTestingFlowNode!

weighting
	^weighting!

weighting: aConditionValue
	weighting := aConditionValue.
	^self! !

!TestingFlowLink categoriesFor: #asTestingFlowDeconstructedLink!no category! !
!TestingFlowLink categoriesFor: #displayOn:!no category! !
!TestingFlowLink categoriesFor: #from!no category! !
!TestingFlowLink categoriesFor: #from:!no category! !
!TestingFlowLink categoriesFor: #printOn:!no category! !
!TestingFlowLink categoriesFor: #to!no category! !
!TestingFlowLink categoriesFor: #to:!no category! !
!TestingFlowLink categoriesFor: #weighting!no category! !
!TestingFlowLink categoriesFor: #weighting:!no category! !

