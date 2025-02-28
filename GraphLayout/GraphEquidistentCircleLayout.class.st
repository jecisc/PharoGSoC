"
I represent a circle layout in which elements are equidistant from each other: the layout maintains the same distance between elements.
"
Class {
	#name : #GraphEquidistentCircleLayout,
	#superclass : #GAbstractWeightedCircleLayout,
	#category : #GraphLayout
}

{ #category : #hook }
GraphEquidistentCircleLayout >> computeSeparationFor: elements [ 
"Compute the separation between each element, this separation will always be the same"
	| sep |
	sep := ((2 * Float pi * (self computeRadiusFor: elements)) - (self weightSum: elements))/
	(elements size).
	^sep
]

{ #category : #hook }
GraphEquidistentCircleLayout >> doExecute: elements [ 
	| angle rad center angleIncrement |
	rad := self computeRadiusFor: elements.
	center := Point x: rad y: rad.
	angle := self initialAngle.
	elements
		do: [ :each | 
			| point |
			"First, the angle is increased only by the angle given by the element radius (height/2),
			then the point is set, and then it's increased by the rest of the total increment"
			"This is to consider both last and next elements weights"
			angle := angle + ((each height)/(2*rad)).
			point := center + (Point r: rad theta: angle).
			angleIncrement := (((each height)/2) + (self computeSeparationFor: elements))/rad.
			angle := angle + angleIncrement.
			translator translate: each to: point.
			]
]
