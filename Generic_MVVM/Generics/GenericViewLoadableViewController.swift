//
//  GenericViewLoadableViewController.swift
//  mvvm_analytics
//
//  Created by Vasile Morari on 11.11.2022.
//

import Combine
import UIKit

typealias GenericPlainController<Input, Output> = GenericViewLoadableViewController<Input, Output, UIView>

class GenericViewLoadableViewController<Input, Output, View: UIView>: ViewLoadableController<View> {
	
	private let output: PassthroughSubject<Input, Never> = .init()
	private let transformer: AnyTransformer<Input, Output>
	var cancellables = Set<AnyCancellable>()
	
	init(transformer: AnyTransformer<Input, Output>) {
		self.transformer = transformer
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		bind()
	}
	
	private func bind() {
		transformer._transform(output.eraseToAnyPublisher()).sink { [weak self] event in
			self?.handleEvent(event)
		}.store(in: &cancellables)
	}
	
	func sendEvent(_ event: Input) {
		output.send(event)
	}
	
	func handleEvent(_ event: Output) { }
}
