"Filed out from Dolphin Smalltalk/Version 2.1"!

Model subclass: #TestingFlowPathCollection
	instanceVariableNames: 'paths'
	classVariableNames: ''
	poolDictionaries: ''!

TestingFlowPathCollection class instanceVariableNames: ''!

TestingFlowPathCollection comment: ''!

!TestingFlowPathCollection categoriesForClass!No category! !

!TestingFlowPathCollection methodsFor!

expandAndRemoveLoopTerminatedPaths

	"for each loop terminated path"
	"find all other paths that have a beginning sequence which is the same as theirs"
	"e.g. ABCDEF->D, would match ABCDHI and ABCDEKL but not ABRCDEVB"
	"for each matching path we need to create a new path with the loop portion inserted between the loop start pair"
	"i.e in the above example we would insert DEF->D between the C and D giving ABCDEF->DHI"

	|startSequence loopSequence loopStartNode processStart|

	paths do: [:pathsElement |

		pathsElement isNil ifFalse:[

			"is this path a loop terminated path?"
			((pathsElement last) class name = #TestingFlowLoopLink) ifTrue:[

				"if so then transcript print it"
				"Transcript show: pathsElement printString;cr."

				"identify the startSequence"
				startSequence := OrderedCollection new.
				loopSequence := OrderedCollection new.
				loopStartNode := (pathsElement last) to.
				processStart := 1.

				pathsElement do: [:sequenceElement |

					(sequenceElement = loopStartNode) ifTrue: [processStart := 0].
					(processStart = 1) ifTrue:[startSequence add: sequenceElement] ifFalse: [loopSequence add: sequenceElement].

				].
				"identify the loopSequence"

				Transcript show: 'START SEQUENCE';cr.
				Transcript show: startSequence printString;cr.
				Transcript show: 'LOOP SEQUENCE';cr.
				Transcript show: loopSequence printString;cr.


				paths do: [:innerPathElement |
					
					innerPathElement isNil ifFalse:[

						"avoid processing yourself"
						(innerPathElement ~= pathsElement) ifTrue: [
							
							|sameAs loopPath|
							sameAs := 1.

							"pathsElement blowup."

							"Check if the path has the same start sequence"
							((innerPathElement size) >= (startSequence size)) ifTrue: [
								1 to: (startSequence size) do: [:anIndex |
									((innerPathElement at: anIndex) = (startSequence at: anIndex)) ifFalse: [sameAs := 0].
								].
							]
							ifFalse: [sameAs := 0].
							
							(sameAs = 1) ifTrue: [
								loopPath := innerPathElement upTo: (startSequence last).
								1 to: (loopSequence size) do: [:i | loopPath add: (loopSequence at: i)].
								((startSequence size) + 1) to: (innerPathElement size) do: [:i |
									loopPath add: (innerPathElement at: i).
								].
									Transcript show: 'New SEQUENCE';cr.
									Transcript show: loopPath printString;cr.
									paths add: loopPath.						
							].
						].
					].
				].

				Transcript show: 'Remove SEQUENCE';cr.
				Transcript show: pathsElement printString;cr.

				paths remove: pathsElement.

			].
		].
	].!

paths
	^paths!

paths: aPathSet
	paths := aPathSet! !

!TestingFlowPathCollection categoriesFor: #expandAndRemoveLoopTerminatedPaths!no category! !
!TestingFlowPathCollection categoriesFor: #paths!no category! !
!TestingFlowPathCollection categoriesFor: #paths:!no category! !

