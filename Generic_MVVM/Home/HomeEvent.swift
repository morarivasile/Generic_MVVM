//
//  HomeEvent.swift
//  mvvm_analytics
//
//  Created by Vasile Morari on 11.11.2022.
//

import UIKit

struct HomeEvent {
	enum VC {
		case viewDidLoad
		case changeBackgroundButtonDidTap
		case action
	}
	
	enum VM {
		case updateBackgroundColor(color: UIColor)
	}
	
	enum Tracking {
		case viewLoaded
		case colorDidChange(color: UIColor)
	}
}
