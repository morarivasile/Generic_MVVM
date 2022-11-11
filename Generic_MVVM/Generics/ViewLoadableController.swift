//
//  ViewLoadableController.swift
//  mvvm_analytics
//
//  Created by Vasile Morari on 11.11.2022.
//

import UIKit

class ViewLoadableController<View: UIView>: UIViewController {
	
	var rootView: View {
		view as! View
	}
	
	override open func loadView() {
		self.view = View()
	}
}
