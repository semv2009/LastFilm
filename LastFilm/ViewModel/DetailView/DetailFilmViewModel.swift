//
//  DetailFilmViewModel.swift
//  LastFilm
//
//  Created by Семен Никулин on 02.02.17.
//  Copyright © 2017 niksemv. All rights reserved.
//

import Foundation

class DetailFilmViewModel {
    
    var title: String {
        return "Detail film"
    }
    
    var film: Film
    
    init(film: Film) {
        self.film = film
    }
}
