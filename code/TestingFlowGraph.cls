"Filed out from Dolphin Smalltalk/Version 2.1"!

Model subclass: #TestingFlowGraph
	instanceVariableNames: 'name nodes links'
	classVariableNames: ''
	poolDictionaries: ''!

TestingFlowGraph class instanceVariableNames: ''!

TestingFlowGraph comment: ''!

!TestingFlowGraph categoriesForClass!No category! !

!TestingFlowGraph methodsFor!

addLink: aLink
	links isNil ifTrue: [ links := OrderedCollection new].
	links add: aLink.!

addNode: aNode
	nodes isNil ifTrue: [ nodes := OrderedCollection new].
	nodes add: aNode.!

asTestingFlowDeconstructedGraph
	|newGraph nodePairs linkPairs tempDeconstructedNode tempDeconstructedLink tempOrderedCollection tempLinksTo|

	newGraph := TestingFlowDeconstructedGraph new.
	nodePairs := OrderedCollection new.
	linkPairs := OrderedCollection new.

	"set up the node pairs and then the same for the link pairs"
	"an ordered collection of ordered collections, each ordered collection being a: node, deconstructed node"
	nodes do: [:currNode |
			tempOrderedCollection := OrderedCollection new.
			tempOrderedCollection add: currNode; add: currNode asTestingFlowDeconstructedNode.
			nodePairs add: tempOrderedCollection.
			].	

	links do: [:currLink |
			tempOrderedCollection := OrderedCollection new.
			tempOrderedCollection add: currLink; add: currLink asTestingFlowDeconstructedLink.
			linkPairs add: tempOrderedCollection.
			].	


	"for each link of the linksto on each deconstructed node, map to the correct deconstructed link"
	nodePairs do: [:currPair | |currNode| 
				currNode := currPair at: 2.

				tempLinksTo := OrderedCollection new.
				((currNode linksTo) isNil ) 
				ifFalse: [ currNode linksTo do: [:currLink |
					tempOrderedCollection := linkPairs select: [:pairElem | (pairElem at: 1) == currLink].

					tempLinksTo add: ((tempOrderedCollection at: 1) at: 2).
					].
					currNode overwriteLinksTo: tempLinksTo.
				].
				newGraph addNode: currNode. 
			].	

	
	"for each deconstructed link, map to the correct deconstructed node"
	linkPairs do: [:currPair | |currLink| 
				currLink := currPair at: 2.
			
				tempOrderedCollection := nodePairs select: [:pairElem | (pairElem at: 1) == (currLink to)].
				currLink to: ((tempOrderedCollection at: 1) at: 2).

				tempOrderedCollection := nodePairs select: [:pairElem | (pairElem at: 1) == (currLink from)].
				currLink from: ((tempOrderedCollection at: 1) at: 2).

				newGraph addLink: currLink.
			].	




	newGraph deconstructedFrom: self.
	^newGraph!

firstNode
	"return the first start node"
	|startnodes|

	startnodes := self startNodes.
	startnodes do: [:element | element isNil ifFalse: [^element]].

!

lastNode
	"return the first end node"
	|endnodes|

	endnodes := self stopNodes.
	endnodes do: [:element | element isNil ifFalse: [^element]].!

links
	^links!

links: aCollection
	links := aCollection!

name
	^name!

name: aName
	name := aName!

nodes
	^nodes!

nodes: aCollection
	nodes := aCollection!

removeLink: aLink
	"remove the given link from the graph"

	links remove: aLink.!

removeNode: aNode

	nodes remove: aNode!

startNodes
	"return the start nodes found (nodes linked to)"

	"start node is a node with no in-links i.e. it is not on the rhs of any link i.e. link to <> node"

	|startnodes|

	startnodes := nodes select: [:nodelem | 
						((links select: [:linkelem |
							(linkelem to) ==  nodelem
						]) size) = 0
					].
	^startnodes!

stopNodes
	"return the start nodes found (nodes linked to)"

	"end node is a node with no out-links i.e. it is not on the lhs of any link i.e. link from <> node"

	|endnodes|

	endnodes := nodes select: [:nodelem | 
						((links select: [:linkelem |
							(linkelem from) ==  nodelem
						]) size) = 0
					].
	^endnodes! !

!TestingFlowGraph categoriesFor: #addLink:!no category! !
!TestingFlowGraph categoriesFor: #addNode:!no category! !
!TestingFlowGraph categoriesFor: #asTestingFlowDeconstructedGraph!no category! !
!TestingFlowGraph categoriesFor: #firstNode!no category! !
!TestingFlowGraph categoriesFor: #lastNode!no category! !
!TestingFlowGraph categoriesFor: #links!no category! !
!TestingFlowGraph categoriesFor: #links:!no category! !
!TestingFlowGraph categoriesFor: #name!no category! !
!TestingFlowGraph categoriesFor: #name:!no category! !
!TestingFlowGraph categoriesFor: #nodes!no category! !
!TestingFlowGraph categoriesFor: #nodes:!no category! !
!TestingFlowGraph categoriesFor: #removeLink:!no category! !
!TestingFlowGraph categoriesFor: #removeNode:!no category! !
!TestingFlowGraph categoriesFor: #startNodes!no category! !
!TestingFlowGraph categoriesFor: #stopNodes!no category! !

