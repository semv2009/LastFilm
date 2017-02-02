//
//  LastFilmViewModel.swift
//  LastFilm
//
//  Created by Семен Никулин on 02.02.17.
//  Copyright © 2017 niksemv. All rights reserved.
//

import Foundation
import Alamofire

class LastFilmViewModel {
    
    var title: String {
        return "Last films"
    }
    
    var tableSource = [Film]()
    
    func loadFilms(complete: @escaping (_ result: Result<LastFilmViewModel>) -> Void) {
        WebService.loadLastFilms { result in
            switch result {
            case .success(let films):
                self.tableSource = films
                self.tableSource.sort(by: { $0.0.date > $0.1.date })
                complete(Result.success(self))
            case .failure(let error):
                complete(Result.failure(error))
            }
        }
    }
}
