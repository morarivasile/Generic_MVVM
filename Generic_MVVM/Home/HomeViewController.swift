//
//  HomeViewController.swift
//  mvvm_analytics
//
//  Created by Vasile Morari on 11.11.2022.
//

import Combine
import UIKit

final class HomeViewController: GenericViewLoadableViewController<HomeEvent.VC, HomeEvent.VM, HomeView> {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		bind()
		sendEvent(.viewDidLoad)
	}
	
	func bind() {
		rootView.eventPublisher.sink { [weak self] event in
			switch event {
			case .buttonTap:
				self?.sendEvent(.changeBackgroundButtonDidTap)
			case .action:
				self?.sendEvent(.action)
			}
		}.store(in: &cancellables)
	}
	
	override func handleEvent(_ event: HomeEvent.VM) {
		switch event {
		case .updateBackgroundColor(let color):
			rootView.backgroundColor = color
		}
	}
}
