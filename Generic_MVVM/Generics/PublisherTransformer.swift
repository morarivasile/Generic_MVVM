//
//  PublisherTransformer.swift
//  mvvm_analytics
//
//  Created by Vasile Morari on 11.11.2022.
//

import Combine

protocol PublisherTransformer {
	associatedtype Input
	associatedtype Output
	func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never>
}

struct AnyTransformer<Input, Output> {
	let _transform: (_ input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never>
	
	init<Transformer: PublisherTransformer>(transformer: Transformer) where Transformer.Input == Input, Transformer.Output == Output {
		self._transform = transformer.transform(input:)
	}
}
