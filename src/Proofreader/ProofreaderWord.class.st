Class {
	#name : #ProofreaderWord,
	#superclass : #Object,
	#instVars : [
		'word',
		'methods',
		'corrections'
	],
	#category : #Proofreader
}

{ #category : #comparing }
ProofreaderWord >> = anObject [
	
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	
	^ word = anObject word
]

{ #category : #converting }
ProofreaderWord >> asString [
	^ word asString
]

{ #category : #accessing }
ProofreaderWord >> corrections [

	^ corrections
]

{ #category : #comparing }
ProofreaderWord >> hash [
	^ word hash
]

{ #category : #initialization }
ProofreaderWord >> initialize [
	super initialize.
	
	methods := OrderedCollection new.
	corrections := OrderedCollection new.
]

{ #category : #accessing }
ProofreaderWord >> methods [

	^ methods
]

{ #category : #printing }
ProofreaderWord >> printOn: aStream [
	word printOn: aStream
]

{ #category : #accessing }
ProofreaderWord >> word [

	^ word
]

{ #category : #accessing }
ProofreaderWord >> word: anObject [

	word := anObject
]
