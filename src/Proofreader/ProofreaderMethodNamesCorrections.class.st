Class {
	#name : #ProofreaderMethodNamesCorrections,
	#superclass : #SpPresenter,
	#instVars : [
		'methodNames',
		'correctedMethodNames'
	],
	#category : #Proofreader
}

{ #category : #specs }
ProofreaderMethodNamesCorrections class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		spacing: 2;
		add: #methodNames;
		add: #correctedMethodNames;
		yourself.
]

{ #category : #specs }
ProofreaderMethodNamesCorrections class >> open [
	<example>
	self new openWithSpec.
]

{ #category : #initialization }
ProofreaderMethodNamesCorrections >> initializePresenters [
	methodNames := self newList.
	correctedMethodNames := self newList.
]

{ #category : #'accessing model' }
ProofreaderMethodNamesCorrections >> setModelBeforeInitialization: aCollectionOfCorrections [

	methodNames
		items: aCollectionOfCorrections;
		display: [ :correction | correction key ].
]
