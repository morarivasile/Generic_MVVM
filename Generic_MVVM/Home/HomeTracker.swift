//
//  HomeTracker.swift
//  mvvm_analytics
//
//  Created by Vasile Morari on 11.11.2022.
//

import Foundation

protocol HomeTrackable {
	func track(event: HomeEvent.Tracking)
}

struct HomeTracker: HomeTrackable {
	func track(event: HomeEvent.Tracking) {
		switch event {
		case .viewLoaded:
			print("viewLoaded")
		case .colorDidChange(let color):
			print("colorDidChange: \(color)")
		}
	}
}
