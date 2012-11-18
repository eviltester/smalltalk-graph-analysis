"Filed out from Dolphin Smalltalk/Version 2.1"!

TestingFlowGraph subclass: #TestingFlowDeconstructedGraph
	instanceVariableNames: 'deconstructedFrom actions nextaction'
	classVariableNames: ''
	poolDictionaries: ''!

TestingFlowDeconstructedGraph class instanceVariableNames: ''!

TestingFlowDeconstructedGraph comment: ''!

!TestingFlowDeconstructedGraph categoriesForClass!No category! !

!TestingFlowDeconstructedGraph methodsFor!

actionDeconstructNode: aNode

	|activeLinks actionresult|

	"when carrying out the action we"
	"deconstruct the node"
	"deconstruct the loops and parallels"
	"create an action entry for (nextaction, node, orderedcollection of active links)"

	self deconstructNode: aNode.
	self deconstructLoopParallels.

	activeLinks := links select: [:linkelem | (linkelem isActive == true)].	

	actionresult := OrderedCollection new.
	actionresult add: nextaction.
	actionresult add: aNode.
	actionresult add: activeLinks.

	nextaction := nextaction + 1.
	actions add: actionresult.!

actions
	^actions!

autodeconstructByLowHighNodeDegree
	"automatically deconstruct the graph using the strategy of low degree nodes first"!

autodeconstructByNodeOrder
	"automatically deconstruct the graph by taking the nodes in order"

	nodes do: [:theNode | self actionDeconstructNode: theNode].!

deconstructedFrom
	^deconstructedFrom!

deconstructedFrom: aGraph
	deconstructedFrom := aGraph!

deconstructLoop: aNode
"for the given node, deconstruct the loop link associated with that node"

	|inlinks outlinks blockstart blockend|

	inlinks := links select: [:linkelem | ((linkelem to) == aNode) & ((linkelem from) == aNode) & ((linkelem isActive) == true)].
	outlinks := links select: [:linkelem | ((linkelem from) == aNode) & (((linkelem to) == aNode) == false) & ((linkelem isActive) == true)].

	"create new links"
	
	blockstart := TestingFlowBlockStart new.
	blockend := TestingFlowBlockEnd new.
	blockend associatedStart: blockstart.
	blockstart associatedEnd: blockend.
	blockend from: '0'.
	blockend to: 'M'.
	

	inlinks do: [:inlink |

					(inlink weighting) addFirst: blockstart.
					(inlink weighting) addLast: blockend.
	
				outlinks do:[:outlink |

					|newlink|
					newlink := TestingFlowDeconstructedLink new.
					newlink from: (inlink from).
					newlink to: (outlink to).
					newlink weighting: OrderedCollection new.
					(inlink weighting) do: [:weightelem | newlink weighting add: weightelem].
					(outlink weighting) do: [:weightelem | newlink weighting add: weightelem].
					newlink activate.
					self addLink: newlink.		
				].
			].
	
	"deactivate old links"
	inlinks do: [:linkelem | linkelem deactivate].
	outlinks do: [:linkelem | linkelem deactivate].

	"change fromNode LinksTo"
	"change to node LinksTo"!

deconstructLoopParallels
	self deconstructLoops.
	self deconstructParallels.!

deconstructLoops

	"for each of the links, check for loops and deconstructLoop that node"

	|looplinks loopnodes|
	looplinks := links select: [:linkelem | ((linkelem to) == (linkelem from)) & ((linkelem isActive) == true)].

	loopnodes := Set new.

	(looplinks isNil) ifFalse: [
		looplinks do: [:looplinkelem | loopnodes add: (looplinkelem from)].
		].

	(loopnodes isNil) ifFalse: [
		loopnodes do: [:loopnode | self deconstructLoop: loopnode].
		].!

deconstructNode: aNode
"deconstruct the node from the graph, redefining the links as appropriate"

	|inlinks outlinks|

	((aNode == (self firstNode)) | (aNode == (self lastNode))) ifTrue: [^self].

	inlinks := links select: [:linkelem | ((linkelem to) == aNode) & ((linkelem isActive) == true)].
	outlinks := links select: [:linkelem | ((linkelem from) == aNode) & ((linkelem isActive) == true)].

	((inlinks size) = 0) ifTrue: [^self]. "if it is a start node then we cannot deconstruct it"
	((outlinks size) = 0) ifTrue: [^self]. "if it is an end node then we cannot deconstruct it"

	"deactivate node"
	aNode deactivate.
	
	"create new links"
	
	inlinks do: [:inlink |

				outlinks do:[:outlink |

					|newlink|
					newlink := TestingFlowDeconstructedLink new.
					newlink from: (inlink from).
					newlink to: (outlink to).
					newlink weighting: OrderedCollection new.
					(inlink weighting) do: [:weightelem | newlink weighting add: weightelem].
					(outlink weighting) do: [:weightelem | newlink weighting add: weightelem].
					newlink activate.
					self addLink: newlink.		
				].
			].
	
	"deactivate old links"
	inlinks do: [:linkelem | linkelem deactivate].
	outlinks do: [:linkelem | linkelem deactivate].

	aNode deactivate.
	"change fromNode LinksTo"
	"change to node LinksTo"
	!

deconstructParallel: aNode
"deconstruct the parallel links from the given node"

	|tonodes outlinks parallellinks blockstart blockend|

	"inlinks := links select: [:linkelem | ((linkelem to) == aNode) & ((linkelem from) == aNode) & ((linkelem isActive) == true)]."
	outlinks := links select: [:linkelem | ((linkelem from) == aNode) &  ((linkelem isActive) == true)].

	tonodes := Set new.
	outlinks do: [:outelem | tonodes add: (outelem to)].

	((tonodes size) < (outlinks size)) ifTrue: [ "parallel to process" 

		tonodes do: [:toelem |
			"get the links for each of the to nodes"
			parallellinks := outlinks select: [:linkelem | ((linkelem to) == toelem) ].
			(parallellinks size) > 1 ifTrue: [	|newlink|
				"parallel found"

					"create new links"
	
				blockstart := TestingFlowBlockStart new.
				blockend := TestingFlowBlockEnd new.
				blockend associatedStart: blockstart.
				blockstart associatedEnd: blockend.
				blockend from: '1'.
				blockend to: '1'.

			
				newlink := TestingFlowDeconstructedLink new.
				newlink weighting: OrderedCollection new.
				(newlink weighting) addFirst: blockstart.
				newlink from: ((parallellinks at: 1) from).
				newlink to: ((parallellinks at: 1) to).

				parallellinks do: [:parallellink |
							(parallellink weighting) do: [:weightelem | newlink weighting add: weightelem].
						"	(newlink weighting) add: (parallellink weighting)."
							((parallellinks identityIndexOf: parallellink) == (parallellinks size)) ifFalse: [ (newlink weighting) add: (TestingFlowBlockOr new) ].
							parallellink deactivate.

				].

				newlink activate.
				self addLink: newlink.		
				(newlink weighting) addLast: blockend.

			].

		].

	].


	!

deconstructParallels
	"for each of the active links, get the nodes and deconstructParallel that node"

	|parlinks parnodes|
	parlinks := links select: [:linkelem | (linkelem isActive) == true].

	parnodes := Set new.

	(parlinks isNil) ifFalse: [
		parlinks do: [:parlinkelem | parnodes add: (parlinkelem from)].
		].

	(parnodes isNil) ifFalse: [
		parnodes do: [:parnode | self deconstructParallel: parnode].
		].!

initialize
	nextaction := 1.
	actions := OrderedCollection new.!

isDeconstructionComplete
	"true if only inlink and outlink nodes remain"
	|activenodes fromlinks tolinks|

	"for each active node"
		"if from is not an innode"
		"or to is not an outnode"
		"then it is not complete"
	"if not then it must be complete"


	activenodes := nodes select: [:thenode | (thenode isActive)].

	activenodes do: [:thenode |
		fromlinks := links select: [:thelink | (thelink from == thenode) & (thelink isActive)].
		tolinks := links select: [:thelink | (thelink to == thenode) & (thelink isActive)].

		(((tolinks size >0) & (fromlinks size = 0)) | ((tolinks size =0) & (fromlinks size > 0))) ifFalse: [^false].
	].

	^true.
	! !

!TestingFlowDeconstructedGraph categoriesFor: #actionDeconstructNode:!no category! !
!TestingFlowDeconstructedGraph categoriesFor: #actions!no category! !
!TestingFlowDeconstructedGraph categoriesFor: #autodeconstructByLowHighNodeDegree!no category! !
!TestingFlowDeconstructedGraph categoriesFor: #autodeconstructByNodeOrder!no category! !
!TestingFlowDeconstructedGraph categoriesFor: #deconstructedFrom!no category! !
!TestingFlowDeconstructedGraph categoriesFor: #deconstructedFrom:!no category! !
!TestingFlowDeconstructedGraph categoriesFor: #deconstructLoop:!no category! !
!TestingFlowDeconstructedGraph categoriesFor: #deconstructLoopParallels!no category! !
!TestingFlowDeconstructedGraph categoriesFor: #deconstructLoops!no category! !
!TestingFlowDeconstructedGraph categoriesFor: #deconstructNode:!no category! !
!TestingFlowDeconstructedGraph categoriesFor: #deconstructParallel:!no category! !
!TestingFlowDeconstructedGraph categoriesFor: #deconstructParallels!no category! !
!TestingFlowDeconstructedGraph categoriesFor: #initialize!no category! !
!TestingFlowDeconstructedGraph categoriesFor: #isDeconstructionComplete!no category! !

