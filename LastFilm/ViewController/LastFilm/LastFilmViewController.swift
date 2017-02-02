//
//  LastFilmViewController.swift
//  LastFilm
//
//  Created by Семен Никулин on 02.02.17.
//  Copyright © 2017 niksemv. All rights reserved.
//

import UIKit

class LastFilmViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: LastFilmViewModel
    
    init(viewModel: LastFilmViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindToViewModel()
        self.title = viewModel.title
        viewModel.loadFilms()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delaysContentTouches = true
        tableView.register(UINib(nibName: "FilmTableViewCell", bundle: nil), forCellReuseIdentifier: "FilmCell")
    }
    
    func configureNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.isTranslucent = false
        self.edgesForExtendedLayout = UIRectEdge()
    }
    
    func bindToViewModel() {
        viewModel.userDidLoadFilms = { [unowned self] model in
            self.tableView.reloadData()
        }
    }
}

extension LastFilmViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as? FilmTableViewCell {
                let film = viewModel.tableSource[indexPath.row]
            cell.updateUI(film: film)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
