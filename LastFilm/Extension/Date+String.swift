//
//  Date+String.swift
//  LastFilm
//
//  Created by Семен Никулин on 02.02.17.
//  Copyright © 2017 niksemv. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "d MMMM yyyy - HH:mm"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: self)
    }
}
