//
//  FilmTableViewCell.swift
//  LastFilm
//
//  Created by Семен Никулин on 02.02.17.
//  Copyright © 2017 niksemv. All rights reserved.
//

import UIKit

class FilmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var roundImageView: RoundImageView!
    
    func updateUI(film: Film) {
        self.accessoryType = .disclosureIndicator
        roundImageView.updateUI()
        titleLabel.text = film.title
        dateLabel.text = film.date.toString()
        if let url = URL(string: film.imageUrl) {
            roundImageView.loadImage(url: url)
        }
    }
}
