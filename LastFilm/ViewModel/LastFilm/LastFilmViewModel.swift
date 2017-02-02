//
//  LastFilmViewModel.swift
//  LastFilm
//
//  Created by Семен Никулин on 02.02.17.
//  Copyright © 2017 niksemv. All rights reserved.
//

import Foundation

class LastFilmViewModel {
    
    var title: String {
        return "Last films"
    }
    var tableSource = [Film]()
    
    var userDidLoadFilms: ((_ viewModel: LastFilmViewModel) -> Void)?
    
    func loadFilms() {
        WebService.loadLastFilms { result in
            switch result {
            case .success(let films):
                self.tableSource = films
                self.userDidLoadFilms?(self)
            case .failure(let error):
                print(error)
            }
        }
    }
}
