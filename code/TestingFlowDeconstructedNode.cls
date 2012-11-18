"Filed out from Dolphin Smalltalk/Version 2.1"!

TestingFlowNode subclass: #TestingFlowDeconstructedNode
	instanceVariableNames: 'active basedOn'
	classVariableNames: ''
	poolDictionaries: ''!

TestingFlowDeconstructedNode class instanceVariableNames: ''!

TestingFlowDeconstructedNode comment: ''!

!TestingFlowDeconstructedNode categoriesForClass!No category! !

!TestingFlowDeconstructedNode methodsFor!

activate
	active := true!

basedOn
	^basedOn!

basedOn: aNode
	basedOn := aNode!

deactivate
	active := false!

isActive
	^active! !

!TestingFlowDeconstructedNode categoriesFor: #activate!no category! !
!TestingFlowDeconstructedNode categoriesFor: #basedOn!no category! !
!TestingFlowDeconstructedNode categoriesFor: #basedOn:!no category! !
!TestingFlowDeconstructedNode categoriesFor: #deactivate!no category! !
!TestingFlowDeconstructedNode categoriesFor: #isActive!no category! !

