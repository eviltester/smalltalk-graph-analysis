"Filed out from Dolphin Smalltalk/Version 2.1"!

Model subclass: #TestingFlowModel
	instanceVariableNames: 'name graph graphDeconstructions nodes'
	classVariableNames: ''
	poolDictionaries: ''!

TestingFlowModel class instanceVariableNames: ''!

TestingFlowModel comment: ''!

!TestingFlowModel categoriesForClass!No category! !

!TestingFlowModel methodsFor!

addNode: aNode
	graph addNode: aNode.!

displayOn: aStream
	aStream nextPut: $(. 
	self name displayOn: aStream. 
	aStream nextPut: $).!

firstNode
	"return the first start node"
	|startnodes|

	startnodes := self StartNodes.
	startnodes do: [:element | element isNil ifFalse: [^element]].!

initialize
	graph := TestingFlowGraph new.!

name
	^name!

name: aName
	name := aName!

nodes
	^(graph nodes)!

printOn: aStream
	self basicPrintOn: aStream. 
	self  displayOn: aStream. !

StartNodes
	"return the start nodes found (nodes linked to)"

	|linked|
	
	linked := Set new.

	nodes do: [:element | element isNil ifFalse: [(element isLinkedTo) isNil ifFalse:[ (element isLinkedTo) do: [:linkelem | linked add: linkelem]]]].

	^linked!

testPaths
	"return the test paths for a model"

	|paths path startat|

	paths := OrderedCollection new.
	
	startat := self nodes firstNode.

	"for each path add it to the collection"
	"node isLinkedTo isNil means end of the path"! !

!TestingFlowModel categoriesFor: #addNode:!no category! !
!TestingFlowModel categoriesFor: #displayOn:!no category! !
!TestingFlowModel categoriesFor: #firstNode!no category! !
!TestingFlowModel categoriesFor: #initialize!no category! !
!TestingFlowModel categoriesFor: #name!no category! !
!TestingFlowModel categoriesFor: #name:!no category! !
!TestingFlowModel categoriesFor: #nodes!no category! !
!TestingFlowModel categoriesFor: #printOn:!no category! !
!TestingFlowModel categoriesFor: #StartNodes!no category! !
!TestingFlowModel categoriesFor: #testPaths!no category! !

