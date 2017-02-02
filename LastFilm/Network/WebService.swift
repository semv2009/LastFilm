//
//  WebService.swift
//  LastFilm
//
//  Created by Семен Никулин on 02.02.17.
//  Copyright © 2017 niksemv. All rights reserved.
//

import Foundation
import Alamofire
import AEXML

class WebService {
    static let parseURL = "http://www.lostfilm.tv/rss.xml"
    
    static func loadLastFilms(result: @escaping (Result<[Film]>) -> Void) {
        Alamofire.request(parseURL).responseData { response in
            if let error = response.error {
                result(Result.failure(error))
            }
            var films = [Film]()
            guard let data = response.data else { return }
            do {
                let xmlDoc = try AEXMLDocument(xml: data)
                print(xmlDoc.xml)
                if let xmlFilms = xmlDoc.root["channel"]["item"].all {
                    for xmlFilm in xmlFilms {
                        let film = Film(xmlElement: xmlFilm)
                        films.append(film)
                    }
                    result(Result.success(films))
                }
            } catch(let error) {
                result(Result.failure(error))
            }
        }
    }
}
