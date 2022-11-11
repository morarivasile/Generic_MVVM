//
//  RandomColorHomeViewModel.swift
//  mvvm_analytics
//
//  Created by Vasile Morari on 11.11.2022.
//

import Combine
import UIKit

final class RandomColorHomeViewModel: PublisherTransformer {
	
	private let output = PassthroughSubject<HomeEvent.VM, Never>()
	private var cancellables = Set<AnyCancellable>()
	private var actionHandler: (() -> Void)?
	
	init(actionHandler: (() -> Void)? = nil) {
		self.actionHandler = actionHandler
	}
	
	func transform(input: AnyPublisher<HomeEvent.VC, Never>) -> AnyPublisher<HomeEvent.VM, Never> {
		input.sink { [unowned self] event in
			switch event {
			case .viewDidLoad:
				output.send(.updateBackgroundColor(color: .systemTeal))
			case .changeBackgroundButtonDidTap:
				let color = UIColor(
					red: .random(in: (0...1)),
					green: .random(in: (0...1)),
					blue: .random(in: (0...1)),
					alpha: 1.0
				)
				
				output.send(.updateBackgroundColor(color: color))
			case .action:
				actionHandler?()
			}
		}.store(in: &cancellables)
		
		return output.eraseToAnyPublisher()
	}
}
