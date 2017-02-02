//
//  Film.swift
//  LastFilm
//
//  Created by Семен Никулин on 02.02.17.
//  Copyright © 2017 niksemv. All rights reserved.
//

import Foundation
import AEXML

class Film {
    var title: String
    var imageUrl: String
    var date: Date
    var link: String
    
    init(xmlElement: AEXMLElement) {
        self.title = xmlElement["title"].value ?? ""
        self.link = xmlElement["link"].value ?? ""
        self.imageUrl = ""
        self.date = Date()
        
        self.imageUrl = getImageUrl(attribute: xmlElement["description"].value ?? "")
        self.date = getDate(dateString: xmlElement["pubDate"].value ?? "")
    }
    
    private func getImageUrl(attribute: String) -> String {
        let parts = attribute.components(separatedBy: "\"")
        return "http:" + parts[1]
    }
    
    private func getDate(dateString: String) -> Date {
        let parts = dateString.components(separatedBy: "+")
        let pattern = parts[0]
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
        let date = dateFormatter.date(from: pattern)
        if let date = date {
            return date
        } else {
            return Date()
        }
    }
}
