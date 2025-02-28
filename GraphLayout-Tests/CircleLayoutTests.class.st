"
I represent a collection of tests for all circle based layouts.
"
Class {
	#name : #CircleLayoutTests,
	#superclass : #TestCase,
	#category : #'GraphLayout-Tests'
}

{ #category : #'as yet unclassified' }
CircleLayoutTests >> testAbstractCircleInit [
	"Test that checks if initialization of object type GAbstractCircleLayout is correct. Expected resault 	for initialAngle is 0."
		
	|layout|
	layout := GAbstractCircleLayout new.
	self assert: (layout initialAngle) equals: 0
]

{ #category : #tests }
CircleLayoutTests >> testComputeIncrementalAngleFor [
	"A test that checks if the computation or incremental angle is done properly. 	initialIncrementalAngle in not selected, therefore for set of 4 elements, expected result is 1.57 	radians. We round down to two decilals for easier testing." 
	
	|gr layout|
	gr := Graph new.
	gr addVertexWithValue: 1;
		addVertexWithValue: 2;
		addVertexWithValue: 3;
		addVertexWithValue: 4.
	layout :=GraphCircleLayout  new.
	self assert: ((layout computeIncrementalAngleFor: (gr vertices)) roundDownTo: 0.01) equals: 1.57
]

{ #category : #tests }
CircleLayoutTests >> testComputeRadiusFor [
	"A test that checks if the computation or radius is done properly. initialRadius in not selected, 	therefore for set of 4 elements with scalingFactor of 11(default one), expected result is 44 	radians." 
	
	|gr layout|
	gr := Graph new.
	gr addVertexWithValue: 1;
		addVertexWithValue: 2;
		addVertexWithValue: 3;
		addVertexWithValue: 4.
	layout :=GraphCircleLayout  new.
	self assert: (layout computeRadiusFor: (gr vertices)) equals: 44
]

{ #category : #tests }
CircleLayoutTests >> testDoExecuteCircle [
	"A test that checks execution of circle layout. For easier testing, we transfer the set of vertices 	to LinkedList, so we can have ordered collection, and we round down to two decimals. Have in mind 	that position stors center of 	vertex.
	For v4, expected result 48.99@7.5 .
	For v3, expected result 5.0@51.5 .
	For v2, expected result 49.0@95.5 .
	For v1, expected result 93.0@51.5 ." 
	
	|gr v1 v2 v3 v4 layout used|
	gr := Graph new.
	v1 := gr addVertexWithValue: 1.
	v2 := gr addVertexWithValue: 2.
	v3 := gr addVertexWithValue: 3.
	v4 := gr addVertexWithValue: 4.
	gr addEdgeFrom: v3 to: v1;
		addEdgeFrom: v3 to: v4;
		addEdgeFrom: v4 to: v2.
	used := LinkedList new.
	used add: v1;
		add: v2;
		add: v3;
		add: v4.
	layout :=GraphCircleLayout  new.
	layout doExecute: (used).
	self assert: ((v2 position)roundDownTo: 0.01) equals: (49.0@95.5)
]

{ #category : #tests }
CircleLayoutTests >> testDoExecuteEquidistentCircle [
	"A test that checks execution of equidistent circle layout. For easier testing, we transfer the set 	of vertices 	to LinkedList, so we can have ordered collection, and we round down to two decimals. 	Have in mind that position stors center of 	vertex.
	For v4, expected result 57.69@10.86 .
	For v3, expected result 5.07@56.5 .
	For v2, expected result 47.75@92.98 .
	For v1, expected result 92.36@58.96 ." 
	
	|gr v1 v2 v3 v4 layout used|
	gr := Graph new.
	v1 := gr addVertexWithValue: 1.
	v2 := gr addVertexWithValue: 2.
	v2 setNewHeight: 10.
	v3 := gr addVertexWithValue: 3.
	v3 setNewHeight: 30.
	v4 := gr addVertexWithValue: 4.
	v4 setNewHeight: 20.
	gr addEdgeFrom: v3 to: v1;
		addEdgeFrom: v3 to: v4;
		addEdgeFrom: v4 to: v2.
	used := LinkedList new.
	used add: v1;
		add: v2;
		add: v3;
		add: v4.
	layout :=GraphEquidistentCircleLayout  new.
	layout doExecute: (used).
	self assert: ((v3 position)roundDownTo: 0.01) equals: (5.07@56.5)
]

{ #category : #tests }
CircleLayoutTests >> testDoExecuteWeightedCircle [
	"A test that checks execution of weighted circle layout. For easier testing, we transfer the set 	of vertices 	to LinkedList, so we can have ordered collection, and we round down to two decimals. 	Have in mind that position stors center of 	vertex.
	For v4, expected result 78.44@21.3 .
	For v3, expected result 5.96@49.85 .
	For v2, expected result 44.4@92.75 .
	For v1, expected result 84.59@77.36 ." 
	
	|gr v1 v2 v3 v4 layout used|
	gr := Graph new.
	v1 := gr addVertexWithValue: 1.
	v2 := gr addVertexWithValue: 2.
	v2 setNewHeight: 10.
	v3 := gr addVertexWithValue: 3.
	v3 setNewHeight: 30.
	v4 := gr addVertexWithValue: 4.
	v4 setNewHeight: 20.
	gr addEdgeFrom: v3 to: v1;
		addEdgeFrom: v3 to: v4;
		addEdgeFrom: v4 to: v2.
	used := LinkedList new.
	used add: v1;
		add: v2;
		add: v3;
		add: v4.
	layout :=GraphWeightedCircleLayout  new.
	layout doExecute: (used).
	self assert: ((v4 position)roundDownTo: 0.01) equals: (78.44@21.3)
]
