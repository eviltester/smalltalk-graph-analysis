
"from page 46, black box testing"

diagram := DiagramObject new initialize.

node32 := Vertex new initialize.
node32 name: '32'.
diagram addContent: node32.

node33a1 := Vertex new initialize.
node33a1 name: '33a1'.
diagram addContent: node33a1.

link1 := Edge new initialize.
link1 from: node32 to: node33a1.
diagram addContent: link1.

tFT := TestingFlowTool new.
tFT addDiagram: diagram.

TestingToolDiagramList showOn: tFT.






mod1 := TestingFlowModel new.
mod1 name: 'Test Model'.

n32 := TestingFlowNode new.
n32 id: '32' name: 'input adjusted_gross_income'.
n33a1 := TestingFlowNode new id: '33a1' name: 'set checkmark_count to zero'.
n32 linksTo: n33a1.
n33a2 := TestingFlowNode new id: '33a2' name: '65 or older?' predicate: 'Age >= 65'.
n33a1 linksTo: n33a2.
n33a3 := TestingFlowNode new id: '33a3' name: 'Increment Checkmark_count'.
n33a2 linksTo: n33a3 when: 'True'.
n33a4 := TestingFlowNode new id: '33a4' name: 'are you blind?' predicate: 'Blind'.
n33a3 linksTo: n33a4.
n33a2 linksTo: n33a4 when: 'False'.
n33a5 := TestingFlowNode new id: '33a5' name: 'increment checkmark_count'.
n33a6 := TestingFlowNode new id: '33a6' name: 'spouse age >= 65?' predicate: 'SpouseAge >= 65'.
n33a4 linksTo: n33a5 when: 'True'.
n33a4 linksTo: n33a6 when: 'False'.
n33a5 linksTo: n33a6.
n33a7 := TestingFlowNode new id: '33a7' name: 'increment checkmark_count'.
n33a8 := TestingFlowNode new id: '33a8' name: 'spouse is blind?' predicate: 'SpouseBlind'.
n33a6 linksTo: n33a7 when: 'True'.
n33a6 linksTo: n33a8 when: 'False'.
n33a7 linksTo: n33a8.


n32 pathsTo: n33a6.

n32 pathsFrom.

mod1 addNode: n32.
mod1 addNode: n33a1.
mod1 addNode: n33a2.
mod1 addNode: n33a3.
mod1 addNode: n33a4.
mod1 testPaths.


" Testing Loops"
"single loop"
n1 := TestingFlowNode new id: '1'.
n2 := TestingFlowNode new id: '2'.
n3 := TestingFlowNode new id: '3'.
n1 linksTo: n2.
n2 linksTo: n3.
n2 linksTo: n2 when: 'we loop'.
n1 pathsFrom: nil.


"from binder pg 364"
nA := TestingFlowNode new id: 'A'.
nB := TestingFlowNode new id: 'B'.
nC := TestingFlowNode new id: 'C'.
nD := TestingFlowNode new id: 'D'.
nE := TestingFlowNode new id: 'E'.
nF := TestingFlowNode new id: 'F'.
nG := TestingFlowNode new id: 'G'.
nH := TestingFlowNode new id: 'H'.
nI := TestingFlowNode new id: 'I'.
nJ := TestingFlowNode new id: 'J'.
nK := TestingFlowNode new id: 'K'.
nL := TestingFlowNode new id: 'L'.
nA linksTo: nB.
nA linksTo: nL.
nB linksTo: nC.
nB linksTo: nL.
nC linksTo: nD.
nD linksTo: nE.
nD linksTo: nG.
nE linksTo: nF.
nE linksTo: nG.
nF linksTo: nD when: 'loopingY'.
nG linksTo: nL.
nG linksTo: nH.
nH linksTo: nI.
nI linksTo: nL.
nI linksTo: nJ.
nJ linksTo: nK.
nJ linksTo: nL.
nK linksTo: nI when: 'loopingZ'.
pathsColl := TestingFlowPathCollection new.
pathsColl paths: (nA pathsFrom: nil).
pathsColl expandAndRemoveLoopTerminatedPaths.

"3 nested loop 2"
n1 := TestingFlowNode new id: '1'.
n2 := TestingFlowNode new id: '2'.
n3 := TestingFlowNode new id: '3'.
n4 := TestingFlowNode new id: '4'.
n5 := TestingFlowNode new id: '5'.
n6 := TestingFlowNode new id: '6'.
n7 := TestingFlowNode new id: '7'.
n10 := TestingFlowNode new id: '10'.
n1 linksTo: n2.
n1 linksTo: n3.
n3 linksTo: n4.
n4 linksTo: n5.
n4 linksTo: n3 when: 'loop1'.
n4 linksTo: n7.
n7 linksTo: n6.
n5 linksTo: n3 when: 'loop2'.
n5 linksTo: n6.
n6 linksTo: n3 when: 'loop3'.
n6 linksTo: n10.

pathsColl := TestingFlowPathCollection new.
pathsColl paths: (n1 pathsFrom: nil).
pathsColl expandAndRemoveLoopTerminatedPaths.

"pairs1"
n0 := TestingFlowNode new id: '0'.
n1 := TestingFlowNode new id: '1'.
n2 := TestingFlowNode new id: '2'.
n3 := TestingFlowNode new id: '3'.
n4 := TestingFlowNode new id: '4'.
n5 := TestingFlowNode new id: '5'.
n6 := TestingFlowNode new id: '6'.
n7 := TestingFlowNode new id: '7'.
n8 := TestingFlowNode new id: '8'.
n9 := TestingFlowNode new id: '9'.
n10 := TestingFlowNode new id: '10'.
n0 linksTo: n1.
n1 linksTo: n2.
n1 linksTo: n3.
n3 linksTo: n5.
n3 linksTo: n9.
n5 linksTo: n6.
n5 linksTo: n7.
n7 linksTo: n9.
n7 linksTo: n8.
n9 linksTo: n4.

pathsColl := TestingFlowPathCollection new.
pathsColl paths: (n0 pathsFrom: nil).
pathsColl expandAndRemoveLoopTerminatedPaths.

"pairs2"
n0 := TestingFlowNode new id: '0'.
n1 := TestingFlowNode new id: '1'.
n2 := TestingFlowNode new id: '2'.
n3 := TestingFlowNode new id: '3'.
n4 := TestingFlowNode new id: '4'.
n5 := TestingFlowNode new id: '5'.
n6 := TestingFlowNode new id: '6'.
n7 := TestingFlowNode new id: '7'.
n8 := TestingFlowNode new id: '8'.
n9 := TestingFlowNode new id: '9'.
n10 := TestingFlowNode new id: '10'.
n11 := TestingFlowNode new id: '11'.
n12 := TestingFlowNode new id: '12'.
n13 := TestingFlowNode new id: '13'.
n14 := TestingFlowNode new id: '14'.
n0 linksTo: n1.
n1 linksTo: n2.
n1 linksTo: n3.
n2 linksTo: n4.
n3 linksTo: n13.
n3 linksTo: n8.
n4 linksTo: n5.
n4 linksTo: n6.
n5 linksTo: n14.
n6 linksTo: n14.
n8 linksTo: n9.
n8 linksTo: n10.
n9 linksTo: n4.
n10 linksTo: n4.
n13 linksTo: n4.
n14 linksTo: n7.

pathsColl := TestingFlowPathCollection new.
pathsColl paths: (n0 pathsFrom: nil).
pathsColl expandAndRemoveLoopTerminatedPaths.

"loop"
n1 := TestingFlowNode new id: '1'.
n2 := TestingFlowNode new id: '2'.
n3 := TestingFlowNode new id: '3'.
n4 := TestingFlowNode new id: '4'.
n5 := TestingFlowNode new id: '5'.
n6 := TestingFlowNode new id: '6'.
n7 := TestingFlowNode new id: '7'.
n1 linksTo: n2.
n2 linksTo: n3.
n2 linksTo: n5.
n3 linksTo: n4.
n5 linksTo: n7.
n6 linksTo: n5.
n7 linksTo: n6.
n7 linksTo: n4.

pathsColl := TestingFlowPathCollection new.
pathsColl paths: (n1 pathsFrom: nil).
pathsColl expandAndRemoveLoopTerminatedPaths.


"nested loop"
n1 := TestingFlowNode new id: '1'.
n2 := TestingFlowNode new id: '2'.
n3 := TestingFlowNode new id: '3'.
n4 := TestingFlowNode new id: '4'.
n5 := TestingFlowNode new id: '5'.
n6 := TestingFlowNode new id: '6'.
n7 := TestingFlowNode new id: '7'.
n8 := TestingFlowNode new id: '8'.
n9 := TestingFlowNode new id: '9'.

n1 linksTo: n2.
n1 linksTo: n3.
n3 linksTo: n4.
n4 linksTo: n5.
n5 linksTo: n7.
n7 linksTo: n4.
n5 linksTo: n6.
n6 linksTo: n8.
n8 linksTo: n3.
n6 linksTo: n9.
n2 linksTo: n9.

pathsColl := TestingFlowPathCollection new.
pathsColl paths: (n1 pathsFrom: nil).
pathsColl expandAndRemoveLoopTerminatedPaths.

pathsColl2 := TestingFlowPathCollection new.
pathsColl2 paths: (n1 pathsTo: n5 history: nil).
pathsColl2 expandAndRemoveLoopTerminatedPaths.

"test scripting article model"
n1 := TestingFlowNode new id: '1'.
n2 := TestingFlowNode new id: '2'.
n3 := TestingFlowNode new id: '3'.
n4 := TestingFlowNode new id: '4'.
n5 := TestingFlowNode new id: '5'.
n6 := TestingFlowNode new id: '6'.

n1 linksTo: n2.
n2 linksTo: n3 when: 'C2'.
n3 linksTo: n2.
n2 linksTo: n4 when: 'C3'.
n4 linksTo: n2.
n2 linksTo: n5 when: 'C4'.
n5 linksTo: n2.
n2 linksTo: n6 when: '!C1'.

pathsColl := TestingFlowPathCollection new.
pathsColl paths: (n1 pathsFrom: nil).
pathsColl expandAndRemoveLoopTerminatedPaths.


"new code for graphs"
tg := TestingFlowGraph new.

n1 := TestingFlowNode new id: '1'.
n2 := TestingFlowNode new id: '2'.
n3 := TestingFlowNode new id: '3'.
n4 := TestingFlowNode new id: '4'.
n5 := TestingFlowNode new id: '5'.
n6 := TestingFlowNode new id: '6'.

tg addNode: n1.
tg addNode: n2.
tg addNode: n3.
tg addNode: n4.
tg addNode: n5.
tg addNode: n6.

tg addLink: (n1 linksTo: n2).
tg addLink: (n2 linksTo: n3 weighting: 'C2').
tg addLink: (n3 linksTo: n2).
tg addLink: (n2 linksTo: n4 weighting: 'C3').
tg addLink: (n4 linksTo: n2).
tg addLink: (n2 linksTo: n5 weighting: 'C4').
tg addLink: (n5 linksTo: n2).
tg addLink: (n2 linksTo: n6 weighting: '!C1').

tg firstNode.
tg lastNode.


tgd := tg asTestingFlowDeconstructedGraph.
tgd deconstructNode: ((tgd nodes) at: 5).
tgd deconstructLoop: ((tgd nodes) at: 2).
tgd deconstructNode: ((tgd nodes) at: 4).
tgd deconstructLoop: ((tgd nodes) at: 2).
tgd deconstructNode: ((tgd nodes) at: 3).
tgd deconstructLoop: ((tgd nodes) at: 2).




"new code for graphs from beizer pg 253"
btg := TestingFlowGraph new.

bn1 := TestingFlowNode new id: '1'.
bn2 := TestingFlowNode new id: '2'.
bn3 := TestingFlowNode new id: '3'.
bn4 := TestingFlowNode new id: '4'.
bn5 := TestingFlowNode new id: '5'.
bn6 := TestingFlowNode new id: '6'.
bn7 := TestingFlowNode new id: '7'.
bn8 := TestingFlowNode new id: '8'.
bn9 := TestingFlowNode new id: '9'.
bn10 := TestingFlowNode new id: '10'.

btg addNode: bn1.
btg addNode: bn2.
btg addNode: bn3.
btg addNode: bn4.
btg addNode: bn5.
btg addNode: bn6.
btg addNode: bn7.
btg addNode: bn8.
btg addNode: bn9.
btg addNode: bn10.

btg addLink: (bn1 linksTo: bn3 weighting: 'a').
btg addLink: (bn3 linksTo: bn4 weighting: 'b').
btg addLink: (bn4 linksTo: bn5 weighting: 'c').
btg addLink: (bn4 linksTo: bn8 weighting: 'g').
btg addLink: (bn5 linksTo: bn6 weighting: 'd').
btg addLink: (bn6 linksTo: bn2 weighting: 'e').
btg addLink: (bn6 linksTo: bn10 weighting: 'i').
btg addLink: (bn7 linksTo: bn3 weighting: 'f').
btg addLink: (bn8 linksTo: bn7 weighting: 'j').
btg addLink: (bn8 linksTo: bn9 weighting: 'k').
btg addLink: (bn9 linksTo: bn5 weighting: 'h').
btg addLink: (bn10 linksTo: bn9 weighting: 'l').
btg addLink: (bn10 linksTo: bn7 weighting: 'm').

btgd := btg asTestingFlowDeconstructedGraph.
btgd deconstructNode: ((btgd nodes) at: 10).
btgd deconstructLoopParallels.
btgd deconstructNode: ((btgd nodes) at: 9).
btgd deconstructLoopParallels.
btgd deconstructNode: ((btgd nodes) at: 7).
btgd deconstructLoopParallels.
btgd deconstructNode: ((btgd nodes) at: 8).
btgd deconstructLoopParallels.
"btgd deconstructParallel: ((btgd nodes) at: 4)."
btgd deconstructNode: ((btgd nodes) at: 4).
btgd deconstructLoopParallels.
"btgd deconstructLoop: ((btgd nodes) at: 3)."
btgd deconstructNode: ((btgd nodes) at: 5).
btgd deconstructLoopParallels.
"btgd deconstructLoop: ((btgd nodes) at: 6)."
btgd deconstructNode: ((btgd nodes) at: 3).
btgd deconstructLoopParallels.
"btgd deconstructLoop: ((btgd nodes) at: 6)."
btgd deconstructNode: ((btgd nodes) at: 6).
btgd deconstructLoopParallels.

btgd actionDeconstructNode: ((btgd nodes) at: 10).
btgd actionDeconstructNode: ((btgd nodes) at: 9).
btgd actionDeconstructNode: ((btgd nodes) at: 7).
btgd actionDeconstructNode: ((btgd nodes) at: 8).
btgd actionDeconstructNode: ((btgd nodes) at: 4).
btgd actionDeconstructNode: ((btgd nodes) at: 5).
btgd actionDeconstructNode: ((btgd nodes) at: 3).
btgd actionDeconstructNode: ((btgd nodes) at: 6).

"now do the same with the horrible 3-10 strategy"
atgd := btg asTestingFlowDeconstructedGraph.
atgd actionDeconstructNode: ((atgd nodes) at: 1).
atgd actionDeconstructNode: ((atgd nodes) at: 2).
atgd actionDeconstructNode: ((atgd nodes) at: 3).
atgd actionDeconstructNode: ((atgd nodes) at: 4).


atgd actionDeconstructNode: ((atgd nodes) at: 5).
atgd actionDeconstructNode: ((atgd nodes) at: 6).
atgd actionDeconstructNode: ((atgd nodes) at: 7).
atgd actionDeconstructNode: ((atgd nodes) at: 8).
atgd actionDeconstructNode: ((atgd nodes) at: 9).
atgd actionDeconstructNode: ((atgd nodes) at: 10).

atgd isDeconstructionComplete 


atgd := btg asTestingFlowDeconstructedGraph.
atgd autodeconstructByNodeOrder.