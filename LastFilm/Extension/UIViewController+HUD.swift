//
//  UIViewController+HUD.swift
//  LastFilm
//
//  Created by Семен Никулин on 02.02.17.
//  Copyright © 2017 niksemv. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showLoadingView(_ text: String) {
        CustomHUD.instance?.textLabel.text = text
        CustomHUD.instance?.show(in: self.view)
    }
    
    func showLoadingView(_ view: UIView?, text: String) {
        CustomHUD.instance?.textLabel.text = text
        CustomHUD.instance?.show(in: view)
    }
    
    func changeTextLoadingView(_ text: String) {
        CustomHUD.instance?.textLabel.text = text
    }
    
    func hideLoadingView() {
        CustomHUD.instance?.dismiss()
    }
}
