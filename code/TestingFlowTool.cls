"Filed out from Dolphin Smalltalk/Version 2.1"!

Model subclass: #TestingFlowTool
	instanceVariableNames: 'diagrams'
	classVariableNames: ''
	poolDictionaries: ''!

TestingFlowTool class instanceVariableNames: ''!

TestingFlowTool comment: ''!

!TestingFlowTool categoriesForClass!No category! !

!TestingFlowTool methodsFor!

addDiagram: aDiagram
	^self diagrams add: aDiagram
!

diagrams
	^diagrams!

initialize
	"Private - Initialize the receiver"
	diagrams := ListModel with: OrderedCollection new.
!

removeDiagram: aDiagram
	^self diagrams remove: aDiagram! !

!TestingFlowTool categoriesFor: #addDiagram:!no category! !
!TestingFlowTool categoriesFor: #diagrams!no category! !
!TestingFlowTool categoriesFor: #initialize!no category! !
!TestingFlowTool categoriesFor: #removeDiagram:!no category! !

