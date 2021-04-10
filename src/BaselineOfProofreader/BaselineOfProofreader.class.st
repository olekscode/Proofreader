Class {
	#name : #BaselineOfProofreader,
	#superclass : #BaselineOf,
	#category : #BaselineOfProofreader
}

{ #category : #baselines }
BaselineOfProofreader >> baseline: spec [
	<baseline>
	spec for: #common do: [	
		"External dependencies"
		spec
			baseline: 'AISpellingCorrection'
			with: [ spec repository: 'github://pharo-ai/spelling-correction/src' ].
			
		spec
			baseline: 'IdentifierNameSplitter'
			with: [ spec repository: 'github://olekscode/IdentifierNameSplitter/src' ].
				
		"Packages"
		spec 
			package: 'Proofreader' with: [ spec requires: #('AISpellingCorrection' 'IdentifierNameSplitter') ];
			package: 'Proofreader-Tests' with: [ spec requires: #('Proofreader') ] ]
]
