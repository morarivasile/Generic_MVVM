//
//  TrackingHomeViewModel.swift
//  mvvm_analytics
//
//  Created by Vasile Morari on 11.11.2022.
//

import Combine
import UIKit

final class TrackingHomeViewModel: PublisherTransformer {
	
	private let output = PassthroughSubject<HomeEvent.VM, Never>()
	private var cancellables = Set<AnyCancellable>()
	private var actionHandler: (() -> Void)?
	
	private let tracker: HomeTrackable
	
	init(tracker: HomeTrackable = HomeTracker(), actionHandler: (() -> Void)? = nil) {
		self.tracker = tracker
		self.actionHandler = actionHandler
	}
	
	func transform(input: AnyPublisher<HomeEvent.VC, Never>) -> AnyPublisher<HomeEvent.VM, Never> {
		input.sink { [unowned self] event in
			switch event {
			case .viewDidLoad:
				tracker.track(event: .viewLoaded)
			case .changeBackgroundButtonDidTap:
				let color = UIColor.red
				tracker.track(event: .colorDidChange(color: color))
				output.send(.updateBackgroundColor(color: color))
			case .action:
				actionHandler?()
			}
		}.store(in: &cancellables)
		
		return output.eraseToAnyPublisher()
	}
}
