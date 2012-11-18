"Filed out from Dolphin Smalltalk/Version 2.1"!

Model subclass: #TestingFlowNode
	instanceVariableNames: 'name id linksTo predicate'
	classVariableNames: ''
	poolDictionaries: ''!

TestingFlowNode class instanceVariableNames: ''!

TestingFlowNode comment: ''!

!TestingFlowNode categoriesForClass!No category! !

!TestingFlowNode methodsFor!

asTestingFlowDeconstructedNode
	|newNode|

	newNode := TestingFlowDeconstructedNode new.
	newNode id: (self id).
	newNode name: (self name).
	newNode overwriteLinksTo: (self linksTo).
	newNode predicate: (self predicate).
	newNode activate.
	newNode basedOn: self.
	^newNode!

displayOn: aStream 
	aStream nextPut: $(. 
	self id displayOn: aStream. 
	aStream nextPut: $,. 
	self name displayOn: aStream. 
	aStream nextPut: $).!

id
    ^id!

id: anID
    id := anID!

id: anID name: aName
	self id: anID.
	self name: aName.!

id: anID name: aName predicate: aPredicate
	self id: anID.
	self name: aName.
	self predicate: aPredicate.!

initialize
        self name: 'Node';
!

isLinkedTo
	"return a set of the nodes that it is linked to"
	
	|linkedSet|

	linkedSet := Set new.

	linksTo isNil ifFalse: [linksTo do: [:element |  element isNil ifFalse: [linkedSet add: (element to)]]].

	^linkedSet shrink.!

linksTo
	^linksTo!

linksTo: aTestingFlowNode
        |link|
	linksTo isNil ifTrue: [ linksTo := OrderedCollection new].
	link := TestingFlowLink new.
	link to: aTestingFlowNode.
	link from: self.
	linksTo add: link.
	^link.!

linksTo: aTestingFlowNode weighting: aPredicateEvaluation
        ^(self linksTo: aTestingFlowNode) weighting: aPredicateEvaluation!

name
    ^name!

name: aName
    name := aName!

overwriteLinksTo: aNewLinksToCollection
	linksTo := aNewLinksToCollection!

pathsFrom: aPathHistory
	"return the paths from this node"

	|paths path pathHistory loopNode loopNodePaths nonLoopNodePaths|

	pathHistory := aPathHistory.
	pathHistory isNil ifTrue: [pathHistory := OrderedCollection new].
	pathHistory add: self.

						Transcript show: 'path history '.
						Transcript show: pathHistory printString; cr.

	Transcript show: '+'.
	Transcript show: self id printString; cr.

	loopNodePaths := Set new.
	nonLoopNodePaths := Set new.
	paths := Set new.

	self linksTo isNil ifTrue: [
						path := OrderedCollection new.
						path add: self.
						paths add: path.
				
						Transcript show: '   Finish With '.
						Transcript show: paths printString; cr.
						pathHistory remove: self.
						^paths.
					].

	self linksTo isNil ifFalse:[

						Transcript show: 'Process Links to '.
						Transcript show: linksTo printString; cr.

	
		linksTo do:[:element |


			"am i linked to something in the path history? if so then that is a loop!!"

			((pathHistory includes: (element to)") & ((element to) ~= self")) ifTrue:[

						Transcript show: 'Linked to History '.
						Transcript show: element to printString; cr.


				path := OrderedCollection new.
				path add: self.
				loopNode := TestingFlowLoopLink new.
				loopNode to: (element to).
				loopNode when: (element when).
				path add: loopNode.
				loopNodePaths add: path.

						Transcript show: 'loop node paths are '.
						Transcript show: loopNodePaths printString; cr.

			]
			ifFalse: [

						Transcript show: 'Recursive call to process '.
						Transcript show: element to printString; cr.

						Transcript show: 'non loop node paths are '.
						Transcript show: nonLoopNodePaths printString; cr.
	
				"element is a TestingFlowLink"
				"for each link, add the link"
				"and the to"
				((element to) pathsFrom: pathHistory) do:[:pathElement |
						path := OrderedCollection new.
						path add: self.
						path add: element.
						pathElement do: [:actualPath |
							path add: actualPath.
						].
						nonLoopNodePaths add: path.

						Transcript show: 'non loop node paths now are '.
						Transcript show: nonLoopNodePaths printString; cr.

				].
			].		
		].		
	].

	pathHistory remove: self.
	Transcript show: '+'.
	Transcript show: self id printString; cr.


	"now analyse the paths, and if there is a testing loop in there then tag the testing loop on to all the paths that do not have testing loops."

	"for each loopNodePath construct a new set of paths using each of the nonLoopNodePaths"

						Transcript show: 'Loop Node Paths '.
						Transcript show: loopNodePaths printString; cr.
						Transcript show: 'non Loop Node Paths '.
						Transcript show: nonLoopNodePaths printString; cr.




	((loopNodePaths size) >0) ifTrue: [
		"then we have to process the loop Node Paths"

		Transcript show: '   Processing Loops'; cr.

		"a loop node path section is always going to be a pair, FlowNode and a FlowLoopLink"
		loopNodePaths do: [:loopPath |

			"special case, if the loop node path has no nonLoopPaths then don't process the nonLoopNodePaths"
			((nonLoopNodePaths size)>0) ifFalse: [paths add: loopPath]
			ifTrue: [
			nonLoopNodePaths do: [:nonLoopPath |
	
				path := OrderedCollection new.
				path add: (loopPath at: 1).
				path add: (loopPath at: 2).
	
				nonLoopPath do:[:nonLoopPathEntry |
					(nonLoopPathEntry = (loopPath at: 1)) ifFalse: [path add: nonLoopPathEntry.].
				].
				paths add: path.
			].	
			].	
		].
						Transcript show: 'returning Paths '.
						Transcript show: paths printString; cr.

		^paths.
	]
	ifFalse: [
		"then the nonLoopNodePaths reflects the current situation"
						Transcript show: 'returning nonLoopPaths '.
						Transcript show: nonLoopNodePaths printString; cr.

		^nonLoopNodePaths.
	].!

pathsTo: aNode history: aPathHistory
	"return the paths from this node to the stated one"

	"return the paths from this node"

	|paths path pathHistory loopNode loopNodePaths nonLoopNodePaths|

	pathHistory := aPathHistory.
	paths := Set new.

	(self == aNode) ifTrue:[
						path := OrderedCollection new.
						path add: self.
						paths add: path.
						^paths.
				].



	pathHistory isNil ifTrue: [pathHistory := OrderedCollection new].
	pathHistory add: self.

						Transcript show: 'path history '.
						Transcript show: pathHistory printString; cr.

	Transcript show: '+'.
	Transcript show: self id printString; cr.

	loopNodePaths := Set new.
	nonLoopNodePaths := Set new.

	self linksTo isNil ifTrue: [
						path := OrderedCollection new.
						path add: self.
						paths add: path.
				
						Transcript show: '   Finish With '.
						Transcript show: paths printString; cr.
						pathHistory remove: self.
						^paths.
					].

	self linksTo isNil ifFalse:[

						Transcript show: 'Process Links to '.
						Transcript show: linksTo printString; cr.

	
		linksTo do:[:element |


			"am i linked to something in the path history? if so then that is a loop!!"

			((pathHistory includes: (element to)") & ((element to) ~= self")) ifTrue:[

						Transcript show: 'Linked to History '.
						Transcript show: element to printString; cr.


				path := OrderedCollection new.
				path add: self.
				loopNode := TestingFlowLoopLink new.
				loopNode to: (element to).
				loopNode when: (element when).
				path add: loopNode.
				loopNodePaths add: path.

						Transcript show: 'loop node paths are '.
						Transcript show: loopNodePaths printString; cr.

			]
			ifFalse: [

						Transcript show: 'Recursive call to process '.
						Transcript show: element to printString; cr.

						Transcript show: 'non loop node paths are '.
						Transcript show: nonLoopNodePaths printString; cr.
	
				"element is a TestingFlowLink"
				"for each link, add the link"
				"and the to"
				((element to) pathsTo: aNode history: pathHistory) do:[:pathElement |
						path := OrderedCollection new.
						path add: self.
						path add: element.
						pathElement do: [:actualPath |
							path add: actualPath.
						].
						nonLoopNodePaths add: path.

						Transcript show: 'non loop node paths now are '.
						Transcript show: nonLoopNodePaths printString; cr.

				].
			].		
		].		
	].

	pathHistory remove: self.
	Transcript show: '+'.
	Transcript show: self id printString; cr.


	"now analyse the paths, and if there is a testing loop in there then tag the testing loop on to all the paths that do not have testing loops."

	"for each loopNodePath construct a new set of paths using each of the nonLoopNodePaths"

						Transcript show: 'Loop Node Paths '.
						Transcript show: loopNodePaths printString; cr.
						Transcript show: 'non Loop Node Paths '.
						Transcript show: nonLoopNodePaths printString; cr.




	((loopNodePaths size) >0) ifTrue: [
		"then we have to process the loop Node Paths"

		Transcript show: '   Processing Loops'; cr.

		"a loop node path section is always going to be a pair, FlowNode and a FlowLoopLink"
		loopNodePaths do: [:loopPath |

			"special case, if the loop node path has no nonLoopPaths then don't process the nonLoopNodePaths"
			((nonLoopNodePaths size)>0) ifFalse: [paths add: loopPath]
			ifTrue: [
			nonLoopNodePaths do: [:nonLoopPath |
	
				path := OrderedCollection new.
				path add: (loopPath at: 1).
				path add: (loopPath at: 2).
	
				nonLoopPath do:[:nonLoopPathEntry |
					(nonLoopPathEntry = (loopPath at: 1)) ifFalse: [path add: nonLoopPathEntry.].
				].
				paths add: path.
			].	
			].	
		].
						Transcript show: 'returning Paths '.
						Transcript show: paths printString; cr.

		^paths.
	]
	ifFalse: [
		"then the nonLoopNodePaths reflects the current situation"
						Transcript show: 'returning nonLoopPaths '.
						Transcript show: nonLoopNodePaths printString; cr.

		^nonLoopNodePaths.
	].!

predicate
	^predicate!

predicate: aCondition
	predicate := aCondition.!

printOn: aStream
	self basicPrintOn: aStream. 
	self  displayOn: aStream. ! !

!TestingFlowNode categoriesFor: #asTestingFlowDeconstructedNode!no category! !
!TestingFlowNode categoriesFor: #displayOn:!no category! !
!TestingFlowNode categoriesFor: #id!no category! !
!TestingFlowNode categoriesFor: #id:!no category! !
!TestingFlowNode categoriesFor: #id:name:!no category! !
!TestingFlowNode categoriesFor: #id:name:predicate:!no category! !
!TestingFlowNode categoriesFor: #initialize!no category! !
!TestingFlowNode categoriesFor: #isLinkedTo!no category! !
!TestingFlowNode categoriesFor: #linksTo!no category! !
!TestingFlowNode categoriesFor: #linksTo:!no category! !
!TestingFlowNode categoriesFor: #linksTo:weighting:!no category! !
!TestingFlowNode categoriesFor: #name!no category! !
!TestingFlowNode categoriesFor: #name:!no category! !
!TestingFlowNode categoriesFor: #overwriteLinksTo:!no category! !
!TestingFlowNode categoriesFor: #pathsFrom:!no category! !
!TestingFlowNode categoriesFor: #pathsTo:history:!no category! !
!TestingFlowNode categoriesFor: #predicate!no category! !
!TestingFlowNode categoriesFor: #predicate:!no category! !
!TestingFlowNode categoriesFor: #printOn:!no category! !

