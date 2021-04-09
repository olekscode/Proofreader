Class {
	#name : #Proofreader,
	#superclass : #SpPresenter,
	#instVars : [
		'projectsDropList',
		'packagesList',
		'analyseButton',
		'typosList'
	],
	#category : #Proofreader
}

{ #category : #settings }
Proofreader class >> defaultExtent [
	^ 1000@600
]

{ #category : #specs }
Proofreader class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		spacing: 2;
		add: (SpBoxLayout newVertical
			spacing: 2;
			add: 'Select a project' height: self labelHeight;
			add: #projectsDropList height: self buttonHeight;
			add: 'Select packages' height: self labelHeight;
			add: #packagesList;
			add: #analyseButton height: self buttonHeight;
			yourself) width: 250;
		add: #typosList;
		yourself.
]

{ #category : #settings }
Proofreader class >> defaultTitle [
	^ 'Proofreader'
]

{ #category : #'world menu' }
Proofreader class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Proofreader)
		parent: #Sources;
		action: [ self open ];
		order: 2;
		help: 'A tool for proofreading source code and correcting language mistakes';
		icon: (self iconNamed: #edit).
]

{ #category : #examples }
Proofreader class >> open [
	<example>
	self new openWithSpec
]

{ #category : #initialization }
Proofreader >> initializePresenters [

	projectsDropList := self newDropList.
		
	packagesList := self newList
		items: Smalltalk image packages;
		display: [ :package | package name ];
		displayIcon: [ Smalltalk ui iconNamed: #package ];
		yourself.
		
	analyseButton := self newButton
		label: 'Analyse';
		yourself.
		
	typosList := self newList.
]

{ #category : #initialization }
Proofreader >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	
	aWindowPresenter
		title: self class defaultTitle;
		initialExtent: self class defaultExtent.
]
