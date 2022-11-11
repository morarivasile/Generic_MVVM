//
//  HomeView.swift
//  mvvm_analytics
//
//  Created by Vasile Morari on 11.11.2022.
//

import Combine
import UIKit

final class HomeView: UIView {
	enum Event {
		case buttonTap
		case action
	}
	
	private let eventSubject = PassthroughSubject<Event, Never>()
	var eventPublisher: AnyPublisher<Event, Never> {
		eventSubject.eraseToAnyPublisher()
	}
	
	private(set) lazy var button: UIButton = {
		let button = UIButton()
		button.setTitle("Change color", for: .normal)
		button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
		return button
	}()
	
	private(set) lazy var actionButton: UIButton = {
		let button = UIButton()
		button.setTitle("Action", for: .normal)
		button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupLayout()
	}
	
	@objc private func changeColor() {
		eventSubject.send(.buttonTap)
	}
	
	@objc private func buttonAction() {
		eventSubject.send(.action)
	}
	
	private func setupLayout() {
		button.translatesAutoresizingMaskIntoConstraints = false
		actionButton.translatesAutoresizingMaskIntoConstraints = false
		
		addSubview(button)
		addSubview(actionButton)
		
		NSLayoutConstraint.activate([
			button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			button.heightAnchor.constraint(equalToConstant: 50),
			button.centerYAnchor.constraint(equalTo: centerYAnchor),
			
			actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			actionButton.heightAnchor.constraint(equalToConstant: 50),
			actionButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
		])
	}
}
