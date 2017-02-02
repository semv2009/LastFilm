//
//  CustipHud.swift
//  LastFilm
//
//  Created by Семен Никулин on 02.02.17.
//  Copyright © 2017 niksemv. All rights reserved.
//

import Foundation
import JGProgressHUD

class CustomHUD {
    static var instance = JGProgressHUD(style: .dark)
    
    static func setText(_ text: String) {
        instance?.textLabel.text = text
    }
}
