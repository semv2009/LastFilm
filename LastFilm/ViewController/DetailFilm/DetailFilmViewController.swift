//
//  DetailFilmViewController.swift
//  LastFilm
//
//  Created by Семен Никулин on 02.02.17.
//  Copyright © 2017 niksemv. All rights reserved.
//

import UIKit

class DetailFilmViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: RoundImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var viewModel: DetailFilmViewModel
    
    init(viewModel: DetailFilmViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewDidLayoutSubviews() {
        imageView.updateUI()
    }
    
    func configureView() {
        titleLabel.text = viewModel.film.title
        linkLabel.text = viewModel.film.link
        dateLabel.text = viewModel.film.date.toString()
        if let url = URL(string: viewModel.film.imageUrl) {
            imageView.loadImage(url: url)
        }
        configureLinkLabel()
    }
    
    func configureLinkLabel() {
        scrollView.delaysContentTouches = false
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openLink(_:)))
        linkLabel.addGestureRecognizer(gesture)
    }

    func openLink(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: viewModel.film.link) {
            UIApplication.shared.open(url)
        }
    }
}
