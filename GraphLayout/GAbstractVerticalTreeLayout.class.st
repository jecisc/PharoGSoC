"
I represent abstract class that describes Vertical tree layouts.
"
Class {
	#name : #GAbstractVerticalTreeLayout,
	#superclass : #GAbstractRegularTreeLayout,
	#category : #GraphLayout
}

{ #category : #'hook-private' }
GAbstractVerticalTreeLayout >> childrenFor: aVertex except: usedOnes [
	|set|
	set:= Set new.
	(usedOnes isEmpty )
	ifTrue:[^aVertex outNeighbourhood] 
	ifFalse:[aVertex outNeighbourhood do:
		[:each| 
			(each vertexExists: each in: usedOnes)
			ifFalse: [ set add: each ]
			].
		^set
		]
]
