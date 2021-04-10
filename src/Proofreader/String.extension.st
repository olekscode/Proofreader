Extension { #name : #String }

{ #category : #'*Proofreader' }
String >> asProofreaderWord [
	^ ProofreaderWord new
		word: self asSymbol;
		yourself
]
