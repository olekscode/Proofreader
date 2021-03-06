Class {
	#name : #Proofreader,
	#superclass : #SpPresenter,
	#instVars : [
		'projectsDropList',
		'packagesList',
		'selectedPackagesLabel',
		'analyseButton',
		'notebook',
		'corrector',
		'unknownWords'
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
			spacing: 3;
			add: 'Select a project' height: self labelHeight;
			add: #projectsDropList height: self buttonHeight;
			add: 'Select packages' height: self labelHeight;
			add: #packagesList;
			add: (SpBoxLayout newHorizontal
				add: (SpBoxLayout newVertical
					add: '';
					add: #selectedPackagesLabel height: self labelHeight;
					yourself);
				add: #analyseButton width: self buttonWidth;
				yourself) height: self buttonHeight + 5;
			yourself) width: 250;
		add: #notebook;
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

{ #category : #'as yet unclassified' }
Proofreader >> analyseSelectedPackages [
	| packages classes methods |
	
	packages := packagesList selectedItems.
	classes := packages flatCollect: [ :package | package classes ].
	methods := classes flatCollect: [ :aClass | aClass methods ].
	
	notebook removeAll.
	
	self proposeMethodNamesCorrectionsFor: methods.
]

{ #category : #initialization }
Proofreader >> connectPresenters [
	packagesList whenSelectionChangedDo: [ 
		selectedPackagesLabel label: (packagesList selectedItems size asString, ' packages selected') ].
	
	analyseButton action: [ 
		self analyseSelectedPackages ].
]

{ #category : #initialization }
Proofreader >> initialize [
	| languageFile |
	super initialize.
	
	corrector := AISpellingCorrector new.
	
	languageFile := 'pharo-local/iceberg/pharo-ai/spelling-correction/data/english.json'
		asFileReference.
		
	corrector loadLanguageModelFrom: languageFile.

]

{ #category : #initialization }
Proofreader >> initializePresenters [

	projectsDropList := self newDropList.
		
	packagesList := self newList
		items: Smalltalk image packages;
		display: [ :package | package name ];
		displayIcon: [ Smalltalk ui iconNamed: #package ];
		beMultipleSelection;
		yourself.
		
	selectedPackagesLabel := self newLabel
		label: '0 packages selected';
		yourself.
		
	analyseButton := self newButton
		label: 'Analyse';
		yourself.
		
	notebook := self newNotebook.
]

{ #category : #initialization }
Proofreader >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	
	aWindowPresenter
		title: self class defaultTitle;
		initialExtent: self class defaultExtent.
]

{ #category : #'as yet unclassified' }
Proofreader >> proposeMethodNamesCorrectionsFor: aCollectionOfMethods [
	| words |
	
	unknownWords := Set new.
	
	aCollectionOfMethods
		do: [ :method |
			words := (method sourceCode substrings flatCollect: [ :token | token splitIdentifierName ]) asSet
				select: [ :word |
					word size > 2 and: [
						word isAllAlphaNumerics and: [
							word isAllDigits not ] ] ]
				thenCollect: [ :word | word asLowercase asProofreaderWord ].
			
			words
				reject: [ :word | corrector isKnownWord: word asString ]
				thenDo: [ :word |
					(unknownWords like: word ifAbsent: [ unknownWords add: word ])
						methods add: method ] ]
		displayingProgress: [ :method | method selector ].
			
	unknownWords
		do: [ :word | word corrections addAll: (corrector correctionsFor: word asString) ]
		displayingProgress: [ :word | word ].

	notebook addPage: (self newNotebookPage
		title: ('Method names (', aCollectionOfMethods size asString, ')');
		presenterProvider: [
			(self instantiate: ProofreaderMethodNamesCorrections)
				showWords: unknownWords;
				yourself ];
		yourself).
]
