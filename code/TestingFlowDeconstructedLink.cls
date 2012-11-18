"Filed out from Dolphin Smalltalk/Version 2.1"!

TestingFlowLink subclass: #TestingFlowDeconstructedLink
	instanceVariableNames: 'active'
	classVariableNames: ''
	poolDictionaries: ''!

TestingFlowDeconstructedLink class instanceVariableNames: ''!

TestingFlowDeconstructedLink comment: ''!

!TestingFlowDeconstructedLink categoriesForClass!No category! !

!TestingFlowDeconstructedLink methodsFor!

activate
	active := true!

active
	^active!

deactivate
	active := false!

displayOn: aStream 
	aStream nextPut: $(. 
	self active displayOn: aStream. 
	aStream nextPut: $,. 
	self from displayOn: aStream. 
	aStream nextPut: $,. 
	self to displayOn: aStream. 
	self weightingDisplay: aStream.
	aStream nextPut: $).!

initialize
	self weighting: OrderedCollection new!

isActive
	^active!

printOn: aStream
	"self basicPrintOn: aStream. "
	self  displayOn: aStream. !

weightingDisplay: aStream 

	"for each link in the weighting ordered collection, display the weighting or the [ ]* + symbols"

	(self weighting) do: [:weightElem |
			(weightElem respondsTo: #weighting) 	
				ifTrue: [(weightElem weighting) displayOn: aStream]
				ifFalse: [weightElem displayOn: aStream].

		].! !

!TestingFlowDeconstructedLink categoriesFor: #activate!no category! !
!TestingFlowDeconstructedLink categoriesFor: #active!no category! !
!TestingFlowDeconstructedLink categoriesFor: #deactivate!no category! !
!TestingFlowDeconstructedLink categoriesFor: #displayOn:!no category! !
!TestingFlowDeconstructedLink categoriesFor: #initialize!no category! !
!TestingFlowDeconstructedLink categoriesFor: #isActive!no category! !
!TestingFlowDeconstructedLink categoriesFor: #printOn:!no category! !
!TestingFlowDeconstructedLink categoriesFor: #weightingDisplay:!no category! !

