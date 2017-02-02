//
//  WebError.swift
//  LastFilm
//
//  Created by Семен Никулин on 02.02.17.
//  Copyright © 2017 niksemv. All rights reserved.
//

import Foundation

class WebError {
    static func titleError(code: Int) -> String {
        switch code {
        case -1009:
            return "Bad network. Please check your internet connection."
        case -1001:
            return "Network problem. Please check your internet connection."
        default:
            return "Please try again later"
        }
    }
}
