"Filed out from Dolphin Smalltalk/Version 2.1"!

Model subclass: #TestingFlowBlockEnd
	instanceVariableNames: 'associatedStart from to'
	classVariableNames: ''
	poolDictionaries: ''!

TestingFlowBlockEnd class instanceVariableNames: ''!

TestingFlowBlockEnd comment: ''!

!TestingFlowBlockEnd categoriesForClass!No category! !

!TestingFlowBlockEnd methodsFor!

associatedStart
	^associatedStart!

associatedStart: aBlockend
	associatedStart := aBlockend!

displayOn: aStream 
	aStream nextPut: $]. 
	((self to) = 'M') ifTrue: [ aStream nextPut: $*].!

from
	^from!

from: aValue
	from := aValue!

to
	^to!

to: aValue
	to := aValue! !

!TestingFlowBlockEnd categoriesFor: #associatedStart!no category! !
!TestingFlowBlockEnd categoriesFor: #associatedStart:!no category! !
!TestingFlowBlockEnd categoriesFor: #displayOn:!no category! !
!TestingFlowBlockEnd categoriesFor: #from!no category! !
!TestingFlowBlockEnd categoriesFor: #from:!no category! !
!TestingFlowBlockEnd categoriesFor: #to!no category! !
!TestingFlowBlockEnd categoriesFor: #to:!no category! !

